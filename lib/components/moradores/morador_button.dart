import 'package:condo_plus/components/moradores/morador_detalhes_popup.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/models/morador.dart';
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
  final _devPack = const DevPack();

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
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
                    _devPack.formatarParaDoisNomes(morador.nome),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  morador.cargo == 'sindico' ? CupertinoIcons.bookmark_fill : null,
                  size: 18,
                  color: Colors.white,
                ),
              ),
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
