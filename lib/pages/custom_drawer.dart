import 'package:condo_plus/components/drawer/drawer_info_card.dart';
import 'package:condo_plus/components/drawer/drawer_item.dart';
import 'package:condo_plus/components/drawer/drawer_logout_popup.dart';
import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/main.dart';
import 'package:condo_plus/pages/avisos_page.dart';
import 'package:condo_plus/pages/enquetes_page.dart';
import 'package:condo_plus/pages/moradores_page.dart';
import 'package:condo_plus/pages/reservas_page.dart';
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
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<DrawerItem> _itens = [];
  late int _selectedIndex;
  late double _drawerWidth;
  late bool _selectTheme;
  final _devPack = const DevPack();

  @override
  void initState() {
    super.initState();
    _drawerWidth = calcularTamanhoDrawer();
    _selectedIndex = widget.index;
    _selectTheme = false;
    _itens = [
      DrawerItem(
        texto: 'Avisos',
        icon: CupertinoIcons.exclamationmark_bubble_fill,
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AvisosPage(loggedUser: widget.usuarioLogado)));
        },
      ),
      DrawerItem(
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
      DrawerItem(
        texto: 'Enquetes',
        icon: Icons.assignment,
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => EnquetesPage(
                        usuarioLogado: widget.usuarioLogado,
                      )));
        },
      ),
      DrawerItem(
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
    return BlurredContainer(
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
                      //DrawerInfoCard(user: widget.usuarioLogado),
                      Divider(height: 40, color: colorScheme.secondary, thickness: 1, indent: 15, endIndent: 15),
                      DrawerItemList(items: _itens, selectedIndex: _selectedIndex),
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
                        popupCard: DrawerLogoutPopup(tag: 'logout-popup-hero'),
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      // SizedBox(
                      //   width: 30,
                      //   height: 20,
                      //   child: FittedBox(
                      //     fit: BoxFit.fill,
                      //     child: CupertinoSwitch(
                      //       trackColor: colorScheme.primary,
                      //       activeColor: colorScheme.primary,
                      //       value: themeManager.themeMode == ThemeMode.dark,
                      //       onChanged: (newValue) => themeManager.toggleTheme(newValue),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        child: Material(
                          color: colorScheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(_selectTheme ? Icons.close : Icons.palette, color: Colors.white, size: 23),
                          ),
                        ),
                        onTap: () => setState(() => _selectTheme = !_selectTheme),
                      ),
                      _selectTheme ? SelecaoTema(callback: () => setState(() => _selectTheme = false)) : SizedBox.shrink()
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
    final titleText = _devPack.formatarParaDoisNomes('widget.usuarioLogado.nome');
    final titleTextStyle = TextStyle(
      color: Colors.white,
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

class SelecaoTema extends StatelessWidget {
  final VoidCallback callback;

  const SelecaoTema({required this.callback});

  @override
  Widget build(BuildContext context) {
    List<ThemeData> themes = DefaultValues.themes;

    return Row(
      children: [
        ItemTema(
          theme: themes[0],
          callback: () {
            themeManager.alterarTema(themes[0], false);
            callback();
          },
        ),
        ItemTema(
          theme: themes[1],
          callback: () {
            themeManager.alterarTema(themes[1], true);
            callback();
          },
        ),
        ItemTema(
          theme: themes[2],
          callback: () {
            themeManager.alterarTema(themes[2], true);
            callback();
          },
        ),
        ItemTema(
          theme: themes[3],
          callback: () {
            themeManager.alterarTema(themes[3], true);
            callback();
          },
        ),
      ],
    );
  }
}

class ItemTema extends StatelessWidget {
  final VoidCallback callback;
  final ThemeData theme;

  const ItemTema({
    required this.callback,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Material(
        color: theme.colorScheme.primary,
        child: Icon(Icons.close),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
        elevation: 2,
      ),
    );
  }
}
