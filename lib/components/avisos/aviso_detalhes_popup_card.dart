import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/devpack.dart';
import 'package:condo_plus/models/aviso.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class AvisoDetalhesPopupCard extends StatelessWidget {
  final Aviso aviso;
  final String tag;

  const AvisoDetalhesPopupCard({
    required this.aviso,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return CustomBlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DefaultValues.horizontalPadding, vertical: 100),
          child: Hero(
            tag: tag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: colorScheme.primary,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.primary),
                        image: DecorationImage(
                          image: aviso.imagem,
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.center,
                        ),
                        borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(DefaultValues.borderRadius)),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: DefaultValues.horizontalPadding),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  formatarParaDoisNomes(aviso.funcionario.nome) + ", " + aviso.funcionario.cargo,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: DefaultValues.fontFamily,
                                    color: AppColors.white,
                                  ),
                                ),
                                flex: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Align(
                                  child: Text(
                                    aviso.dataHora,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: DefaultValues.fontFamily,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            aviso.descricao,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: DefaultValues.fontFamily,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}