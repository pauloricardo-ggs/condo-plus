import 'package:condo_plus/components/avisos/aviso_detalhes_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/models/aviso.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class AvisoButton extends StatelessWidget {
  final Aviso aviso;
  final String tag;

  const AvisoButton({
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
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          child: Stack(
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 250,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.primary),
                  image: DecorationImage(
                    image: NetworkImage(aviso.imagem),
                    fit: BoxFit.fill,
                    alignment: FractionalOffset.center,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadiusDirectional.vertical(
                    top: Radius.circular(15.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      aviso.titulo,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      aviso.dataCadastro,
                      style: TextStyle(fontSize: 13, color: Colors.white),
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
