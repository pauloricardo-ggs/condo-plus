import 'package:condo_plus/components/geral/expansion_list.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/models/reserva.dart';
import 'package:condo_plus/theme/themes.dart';

class ReservaDetalhesPopup extends StatelessWidget {
  final Reserva reserva;
  final int index;
  final String tag;

  const ReservaDetalhesPopup({
    required this.reserva,
    required this.index,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    int icon = int.parse(reserva.icon);

    return BlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(DefaultValues.moradorButtonHorizontalPadding - 3),
          child: Hero(
            tag: tag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Material(
                color: colorScheme.primary,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(icon, fontFamily: 'MaterialIcons'),
                              color: AppColors.white,
                              size: 30,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  reserva.areaReservada.nome,
                                  style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: DefaultValues.fontFamily),
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Data:', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily)),
                            Text(reserva.data, style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily)),
                          ],
                        ),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Horário:', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily)),
                            Text(reserva.horaEntrada + ' às ' + reserva.horaSaida, style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily)),
                          ],
                        ),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status:', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily)),
                            Text(reserva.status, style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily)),
                          ],
                        ),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                        ExpansionList(
                          title: 'Convidados',
                          child: _ReservaConvidadosExpansionList(convidados: reserva.convidados),
                          duration: Duration(milliseconds: 300),
                        ),
                        Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      ],
                    ),
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

class _ReservaConvidadosExpansionList extends StatelessWidget {
  final List<dynamic> convidados;

  const _ReservaConvidadosExpansionList({required this.convidados});

  @override
  Widget build(BuildContext context) {
    convidados.sort((a, b) => a.nome.compareTo(b.nome));

    return Column(
        children: List<Widget>.generate(
      convidados.length,
      (index) => SizedBox(
        height: 23,
        child: ListTile(
          visualDensity: VisualDensity(vertical: -4),
          dense: true,
          title: Text(
            convidados[index].nome,
            style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily),
          ),
        ),
      ),
    ));
  }
}
