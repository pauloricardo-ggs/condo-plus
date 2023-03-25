import 'package:condo_plus/screens/aviso_detalhes_page.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListaCardAvisos extends StatelessWidget {
  final List<dynamic> avisos;

  const ListaCardAvisos({required this.avisos});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: avisos.length,
        itemBuilder: (context, index) => CardAviso(aviso: avisos[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        padding: EdgeInsets.symmetric(vertical: 15.0),
      ),
    );
  }
}

class CardAviso extends StatelessWidget {
  final dynamic aviso;

  const CardAviso({required this.aviso});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
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
              border: Border.all(color: colorScheme.primary),
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
              color: colorScheme.primary,
              borderRadius: const BorderRadiusDirectional.vertical(
                top: Radius.circular(DefaultValues.borderRadius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  aviso.titulo,
                  style: TextStyle(fontSize: 20, color: AppColors.white, fontFamily: DefaultValues.fontFamily),
                ),
                SizedBox(height: 8),
                Text(
                  aviso.dataHora,
                  style: TextStyle(fontSize: 13, color: AppColors.white, fontFamily: DefaultValues.fontFamily),
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AvisoDetalhesPage(aviso: aviso)));
      },
    );
  }
}
