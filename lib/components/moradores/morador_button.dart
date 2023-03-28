import 'package:condo_plus/components/moradores/morador_detalhes_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/devpack.dart';
import 'package:condo_plus/models/morador.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoradorButtonList extends StatelessWidget {
  final List<dynamic> moradores;

  const MoradorButtonList({required this.moradores});

  @override
  Widget build(BuildContext context) {
    return moradores.isEmpty
        ? Column(
            children: [
              SizedBox(height: 60),
              Text(
                'Esse apartamento está vazio,\ncadastre moradores para ele.',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: DefaultValues.fontFamily,
                ),
              ),
            ],
          )
        : Expanded(
            child: ListView.separated(
              itemCount: moradores.length,
              itemBuilder: (context, index) => _MoradorButton(
                morador: moradores[index],
                index: index,
                tag: 'morador-button-hero-' + index.toString(),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
  }
}

class _MoradorButton extends StatelessWidget {
  final Morador morador;
  final int index;
  final String tag;

  const _MoradorButton({
    required this.morador,
    required this.index,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return OpenPopupButton(
      popupCard: MoradorDetalhesPopup(morador: morador, index: index, tag: tag),
      tag: tag,
      child: Material(
        color: theme.brightness == Brightness.dark ? AppColors.dark_morador_button : AppColors.light_morador_button,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.moradorButtonBorderRadius)),
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 7.0, right: 14.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/memoji/' + morador.foto + '.png'),
                backgroundColor: theme.colorScheme.secondary,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    formatarParaDoisNomes(morador.nome),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontFamily: DefaultValues.fontFamily,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  morador.cargo == 'sindico' ? CupertinoIcons.bookmark_fill : null,
                  size: 18,
                  color: AppColors.white,
                ),
              ),
              Icon(
                morador.proprietario ? CupertinoIcons.doc_text_fill : null,
                size: 18,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
