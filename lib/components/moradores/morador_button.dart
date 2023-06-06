import 'package:condo_plus/components/moradores/morador_detalhes_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/models/perfil_usuario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoradorButton extends StatelessWidget {
  final PerfilUsuario morador;
  final int index;
  final String tag;
  final _devPack = const DevPack();

  const MoradorButton({
    required this.morador,
    required this.index,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OpenPopupButton(
      popupCard: MoradorDetalhesPopup(morador: morador, index: index, tag: tag),
      tag: tag,
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 7.0, right: 14.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(morador.foto),
                backgroundColor: colorScheme.secondary,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  _devPack.formatarParaDoisNomes(morador.nomeCompleto),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Icon(
                morador.cargo == 'sindico' ? CupertinoIcons.bookmark_fill : null,
                size: 18,
                color: Colors.white,
              ),
              const SizedBox(width: 5.0),
              Icon(
                morador.proprietario ? CupertinoIcons.doc_text_fill : null,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
