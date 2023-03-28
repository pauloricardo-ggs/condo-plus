import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class AddFilterButton extends StatelessWidget {
  final List<String> filtros;
  final int filtroSelecionado;
  final String tag;
  final Function callback;

  const AddFilterButton({
    required this.filtros,
    required this.filtroSelecionado,
    required this.tag,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 40.0),
        child: OpenPopupButton(
          popupCard: FilterPopupCard(tag: tag, filtroSelecionado: filtroSelecionado, callback: callback, filtros: filtros),
          tag: tag,
          child: Material(
            color: colorScheme.primary,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.filter_alt, size: 23, color: AppColors.white),
                  SizedBox(width: 8.0),
                  Text(filtros[filtroSelecionado], style: TextStyle(color: AppColors.white, fontFamily: DefaultValues.fontFamily)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterPopupCard extends StatelessWidget {
  final List<String> filtros;
  final int filtroSelecionado;
  final String tag;
  final Function callback;

  const FilterPopupCard({
    required this.filtros,
    required this.filtroSelecionado,
    required this.tag,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CustomBlurredContainer(
      child: Center(
        child: Hero(
          tag: tag,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Material(
              color: theme.colorScheme.primary,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemCount: filtros.length,
                itemBuilder: (context, index) {
                  return FilterButton(text: filtros[index], isSelected: filtroSelecionado == index, onPressed: callback, novoFiltro: index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final Function onPressed;
  final bool isSelected;
  final String text;
  final int novoFiltro;

  const FilterButton({
    required this.onPressed,
    required this.isSelected,
    required this.text,
    required this.novoFiltro,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        disabledBackgroundColor: Colors.black.withOpacity(0.2),
        elevation: isSelected ? 0 : 4,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            color: AppColors.white.withOpacity(isSelected ? 0.4 : 1),
            fontSize: 18,
            fontFamily: DefaultValues.fontFamily,
          ),
        ),
      ),
      onPressed: isSelected
          ? null
          : () async => {
                Navigator.pop(context),
                await Future.delayed(Duration(milliseconds: 50)),
                onPressed(novoFiltro),
              },
    );
  }
}
