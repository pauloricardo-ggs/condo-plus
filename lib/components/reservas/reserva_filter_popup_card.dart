import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class ReservaFilterPopupCard extends StatelessWidget {
  final String tag;
  final int filtroSelecionado;
  final Function callback;
  final List<String> filtros;

  const ReservaFilterPopupCard({
    required this.tag,
    required this.filtroSelecionado,
    required this.callback,
    required this.filtros,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CustomBlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Hero(
            tag: tag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: theme.colorScheme.primary,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ReservasFiltroButton(text: filtros[0], isSelected: filtroSelecionado == 0, onPressed: callback, novoFiltro: 0),
                      ReservasFiltroButton(text: filtros[1], isSelected: filtroSelecionado == 1, onPressed: callback, novoFiltro: 1),
                      ReservasFiltroButton(text: filtros[2], isSelected: filtroSelecionado == 2, onPressed: callback, novoFiltro: 2),
                      ReservasFiltroButton(text: filtros[3], isSelected: filtroSelecionado == 3, onPressed: callback, novoFiltro: 3),
                      ReservasFiltroButton(text: filtros[4], isSelected: filtroSelecionado == 4, onPressed: callback, novoFiltro: 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReservasFiltroButton extends StatelessWidget {
  final Function onPressed;
  final bool isSelected;
  final String text;
  final int novoFiltro;

  const ReservasFiltroButton({
    required this.onPressed,
    required this.isSelected,
    required this.text,
    required this.novoFiltro,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ElevatedButton(
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
      ),
    );
  }
}
