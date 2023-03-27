import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/models/morador.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class DetalhesMoradorPopupCard extends StatelessWidget {
  final Morador morador;
  final int index;
  final String tag;

  const DetalhesMoradorPopupCard({
    required this.morador,
    required this.index,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    Morador _morador = morador;
    double _fonte = 18;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return CustomBlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(DefaultValues.moradorButtonHorizontalPadding - 3),
          child: Hero(
            tag: tag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: colorScheme.primary,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/memoji/' + _morador.foto + '.png'),
                          backgroundColor: colorScheme.secondary,
                          radius: 60,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Center(
                          child: Text(
                            morador.nome,
                            style: TextStyle(fontSize: 28, color: Colors.white, fontFamily: DefaultValues.fontFamily),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      Text('Cpf:', style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      SizedBox(height: 8),
                      Text(_morador.cpf, style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      SizedBox(height: 8),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      Text('Email:', style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      SizedBox(height: 8),
                      Text(_morador.email, style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      Text('Telefone:', style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      SizedBox(height: 8),
                      Text(_morador.telefone, style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      Text('Data de nascimento:', style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      SizedBox(height: 8),
                      Text(_morador.dataNascimento, style: TextStyle(color: Colors.white, fontSize: _fonte, fontFamily: DefaultValues.fontFamily)),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
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
