import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/components/reservas/detalhes_reserva_popup_card.dart';
import 'package:condo_plus/models/reserva.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class ReservaButtonList extends StatelessWidget {
  final List<String> filtros;
  final List<dynamic> reservas;
  final int filtroSelecionado;

  const ReservaButtonList({
    required this.reservas,
    required this.filtroSelecionado,
    required this.filtros,
  });

  @override
  Widget build(BuildContext context) {
    List<Reserva> reservasFiltradas = reservas.cast<Reserva>();

    if (filtroSelecionado != 0) reservasFiltradas = reservasFiltradas.where((reserva) => reserva.status == filtros[filtroSelecionado]).toList();

    return reservasFiltradas.isEmpty
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 0),
                child: Text(
                  textAlign: TextAlign.center,
                  filtroSelecionado == 0 ? 'Parece que você ainda não fez reservas.' : 'Não foi encontrada nenhuma reserva com o filtro selecionado.',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: DefaultValues.fontFamily,
                  ),
                ),
              ),
            ],
          )
        : Expanded(
            child: ListView.separated(
              itemCount: reservasFiltradas.length,
              itemBuilder: (context, index) {
                return ReservaButton(
                  reserva: reservasFiltradas[index],
                  index: index,
                  tag: 'reserva-button-hero-' + index.toString(),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8),
            ),
          );
  }
}

class ReservaButton extends StatelessWidget {
  final Reserva reserva;
  final int index;
  final String tag;

  const ReservaButton({
    required this.reserva,
    required this.index,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int icon = int.parse(reserva.icon);

    return Container(
      constraints: BoxConstraints(minHeight: 43),
      child: OpenPopupButton(
        popupCard: DetalhesReservaPopupCard(reserva: reserva, index: index, tag: tag),
        tag: tag,
        child: Material(
          color: theme.brightness == Brightness.dark ? AppColors.dark_morador_button : AppColors.light_morador_button,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.moradorButtonBorderRadius)),
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 7.0, right: 14.0),
            child: Row(
              children: [
                Icon(IconData(icon, fontFamily: 'MaterialIcons'), color: AppColors.white),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(reserva.areaReservada.nome, style: TextStyle(fontSize: 16, fontFamily: DefaultValues.fontFamily, color: AppColors.white)),
                ),
                Spacer(),
                Text(reserva.data, style: TextStyle(fontSize: 16, fontFamily: DefaultValues.fontFamily, color: AppColors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
