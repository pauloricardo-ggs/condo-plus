import 'package:condo_plus/components/drawer/drawer_info_card.dart';
import 'package:condo_plus/components/drawer/drawer_item.dart';
import 'package:condo_plus/components/drawer/drawer_logout_popup.dart';
import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/open_popup_button.dart';
import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:condo_plus/pages/avisos_page.dart';
import 'package:condo_plus/pages/enquetes_page.dart';
import 'package:condo_plus/pages/moradores_page.dart';
import 'package:condo_plus/pages/reservas_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  final int index;

  const CustomDrawer({
    required this.index,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<DrawerItem> _itens = [];
  late int _selectedIndex;
  late double _drawerWidth;

  final _devPack = const DevPack();
  final _authController = Get.put(AuthController());

  @override
  void initState() {
    _drawerWidth = calcularTamanhoDrawer();
    _selectedIndex = widget.index;
    _itens.add(buildItemAvisos());
    _itens.add(buidItemReservas());
    _itens.add(buildItemEnquetes());

    if (_authController.ehAdministracao() || _authController.ehSindico()) {
      _itens.add(buildItemMoradores());
    }

    super.initState();
  }

  DrawerItem buildItemMoradores() {
    return DrawerItem(
      texto: 'Moradores',
      icon: CupertinoIcons.group_solid,
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MoradoresPage()));
      },
    );
  }

  DrawerItem buildItemEnquetes() {
    return DrawerItem(
      texto: 'Enquetes',
      icon: Icons.assignment,
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EnquetesPage()));
      },
    );
  }

  DrawerItem buidItemReservas() {
    return DrawerItem(
      texto: 'Reservas',
      icon: CupertinoIcons.calendar_today,
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReservasPage()));
      },
    );
  }

  DrawerItem buildItemAvisos() {
    return DrawerItem(
      texto: 'Avisos',
      icon: CupertinoIcons.exclamationmark_bubble_fill,
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AvisosPage()));
      },
    );
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
                      DrawerInfoCard(),
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
                            child: Icon(Icons.logout, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        child: Material(
                          color: colorScheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Get.isDarkMode ? CupertinoIcons.sun_min_fill : CupertinoIcons.moon_fill,
                                color: Colors.white,
                              )),
                        ),
                        onTap: () => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
                      ),
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
