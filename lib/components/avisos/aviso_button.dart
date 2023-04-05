import 'package:condo_plus/components/avisos/aviso_detalhes_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/main.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class AvisoButtonList extends StatelessWidget {
  final List<dynamic> avisos;

  const AvisoButtonList({required this.avisos});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: avisos.length,
        itemBuilder: (context, index) => _AvisoButton(
          aviso: avisos[index],
          tag: 'card-aviso-' + index.toString() + '-hero',
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        padding: EdgeInsets.symmetric(vertical: 15.0),
      ),
    );
  }
}

class _AvisoButton extends StatelessWidget {
  final dynamic aviso;
  final String tag;

  const _AvisoButton({
    required this.aviso,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return OpenPopupButton(
      popupCard: AvisoDetalhesPopup(aviso: aviso, tag: tag),
      tag: tag,
      child: Material(
        color: themeManager.appColor.morador_button,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.moradorButtonBorderRadius)),
        child: Container(
          child: Stack(
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 250,
                  borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
                ),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.primary),
                  image: DecorationImage(
                    image: aviso.imagem,
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                  ),
                  borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadiusDirectional.vertical(
                    top: Radius.circular(DefaultValues.borderRadius),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      aviso.titulo,
                      style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: DefaultValues.fontFamily),
                    ),
                    SizedBox(height: 8),
                    Text(
                      aviso.dataHora,
                      style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: DefaultValues.fontFamily),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
