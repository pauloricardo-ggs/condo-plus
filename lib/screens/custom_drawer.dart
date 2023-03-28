import 'package:condo_plus/components/drawer/info_card.dart';
import 'package:condo_plus/components/drawer/item_list.dart';
import 'package:condo_plus/components/drawer/logout_popup_card.dart';
import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/devpack.dart';
import 'package:condo_plus/main.dart';
import 'package:condo_plus/screens/avisos_page.dart';
import 'package:condo_plus/screens/enquetes_page.dart';
import 'package:condo_plus/screens/moradores_page.dart';
import 'package:condo_plus/screens/reservas_page.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final dynamic usuarioLogado;
  final int index;

  const CustomDrawer({
    required this.index,
    required this.usuarioLogado,
  });

  @override
  State<CustomDrawer> createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  List<Item> _itens = [];
  late int _selectedIndex;
  late double _drawerWidth;

  @override
  void initState() {
    super.initState();
    _drawerWidth = calcularTamanhoDrawer();
    _selectedIndex = widget.index;
    _itens = [
      Item(
        texto: 'Avisos',
        icon: CupertinoIcons.exclamationmark_bubble_fill,
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AvisosPage(loggedUser: widget.usuarioLogado)));
        },
      ),
      Item(
        texto: 'Reservas',
        icon: CupertinoIcons.calendar_today,
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ReservasPage(
                        usuarioLogado: widget.usuarioLogado,
                      )));
        },
      ),
      Item(
        texto: 'Enquetes',
        icon: Icons.quiz,
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => EnquetesPage(
                        usuarioLogado: widget.usuarioLogado,
                      )));
        },
      ),
      Item(
        texto: 'Moradores',
        icon: CupertinoIcons.group_solid,
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MoradoresPage(usuarioLogado: widget.usuarioLogado)));
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return CustomBlurredContainer(
      child: Drawer(
        width: _drawerWidth,
        backgroundColor: colorScheme.primary,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InfoCard(user: widget.usuarioLogado),
                      Divider(height: 40, color: colorScheme.secondary, thickness: 1, indent: 15, endIndent: 15),
                      ItemList(items: _itens, selectedIndex: _selectedIndex),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: colorScheme.secondary,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OpenPopupButton(
                        popupCard: LogoutPopupCard(tag: 'logout-popup-hero'),
                        tag: 'logout-popup-hero',
                        child: Material(
                          color: Color.fromARGB(75, 255, 0, 0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.logout,
                              size: 23,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Switch(
                        value: themeManager.themeMode == ThemeMode.dark,
                        onChanged: (newValue) => themeManager.toggleTheme(newValue),
                        activeThumbImage: AssetImage('assets/images/icons/theme-mode-dark.png'),
                        inactiveThumbImage: AssetImage('assets/images/icons/theme-mode-on.png'),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double calcularTamanhoDrawer() {
    final titleText = formatarParaDoisNomes(widget.usuarioLogado.nome);
    final titleTextStyle = TextStyle(
      color: AppColors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: titleText,
        style: titleTextStyle,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final drawerWidth = textPainter.width + 118;

    return drawerWidth > 270 ? 270 : drawerWidth;
  }
}
