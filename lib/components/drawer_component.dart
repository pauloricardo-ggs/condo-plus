// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:condo_plus/components/drawer_info_card_component.dart';
import 'package:condo_plus/components/drawer_item_component.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/screens/avisos_page.dart';
import 'package:condo_plus/screens/login_page.dart';
import 'package:condo_plus/screens/moradores_page.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerComponent extends StatefulWidget {
  final dynamic usuarioLogado;
  final int selectedIndex;

  const DrawerComponent({
    Key? key,
    required this.selectedIndex,
    this.usuarioLogado,
  }) : super(key: key);

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  List<DrawerItemComponent> _drawerItems = [];
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.selectedIndex;

    _drawerItems = [
      DrawerItemComponent(
        texto: 'Avisos',
        callback: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AvisosPage(usuarioLogado: widget.usuarioLogado)));
        },
        icon: Icons.announcement,
      ),
      DrawerItemComponent(
        texto: 'Reservas',
        callback: () {},
        icon: Icons.edit_calendar,
      ),
      DrawerItemComponent(
        texto: 'Enquetes',
        callback: () {},
        icon: Icons.quiz,
      ),
      DrawerItemComponent(
        texto: 'Moradores',
        callback: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MoradoresPage(usuarioLogado: widget.usuarioLogado)));
        },
        icon: Icons.groups,
      ),
      DrawerItemComponent(
        texto: 'Configurações',
        callback: () {},
        icon: Icons.settings,
      ),
      DrawerItemComponent(
        texto: 'Sair',
        callback: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        icon: Icons.logout,
        cor: Color.fromARGB(255, 255, 49, 49),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 3.0,
            sigmaY: 3.0,
          ),
          child: const SizedBox.expand(),
        ),
        Drawer(
          backgroundColor: main_color,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DrawerInfoCardComponent(usuario: widget.usuarioLogado),
                  const Divider(height: 40, color: Color.fromARGB(255, 66, 66, 66), thickness: 1, indent: 15, endIndent: 15),
                  itens(),
                ],
              ),
            ),
          ),
          width: 270,
        ),
      ],
    );
  }

  Widget itens() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _drawerItems.length,
            separatorBuilder: (BuildContext context, int index) {
              if (index == 3) {
                return Divider(height: 40, color: Color.fromARGB(255, 66, 66, 66), thickness: 1, indent: 15, endIndent: 15);
              } else {
                return SizedBox.shrink();
              }
            },
            itemBuilder: (BuildContext context, int index) {
              final isSelected = _selectedIndex == index;

              return GestureDetector(
                onTap: () async {
                  if (_selectedIndex != index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    await Future.delayed(Duration(milliseconds: duracaoAnimacao));
                    _drawerItems[index].callback();
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: duracaoAnimacao),
                      curve: Curves.easeInOut,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(defaultBorderRadius)),
                        color: isSelected ? avatar_background_color_light : null,
                      ),
                      transform: Matrix4.translationValues(isSelected ? 0 : -100, 0, 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: duracaoAnimacao),
                            curve: Curves.easeInOut,
                            width: isSelected ? 31 : 22,
                            height: isSelected ? 31 : 22,
                            child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                final double iconSize = constraints.maxWidth;
                                return Icon(
                                  size: iconSize,
                                  _drawerItems[index].icon,
                                  color: _drawerItems[index].cor,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: duracaoAnimacao),
                            curve: Curves.easeInOut,
                            style: GoogleFonts.comfortaa(
                              color: _drawerItems[index].cor,
                              fontSize: isSelected ? 20 : 14,
                            ),
                            child: Text(
                              _drawerItems[index].texto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
