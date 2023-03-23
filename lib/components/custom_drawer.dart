import 'dart:ui';

import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/devpack.dart';
import 'package:flutter/material.dart';

import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/screens/avisos_page.dart';
import 'package:condo_plus/screens/login_page.dart';
import 'package:condo_plus/screens/moradores_page.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatefulWidget {
  final dynamic usuarioLogado;
  final int selectedIndex;

  const CustomDrawer({
    Key? key,
    required this.selectedIndex,
    this.usuarioLogado,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<_Item> _drawerItems = [];
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _drawerItems = [
      _Item(
        texto: 'Avisos',
        callback: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AvisosPage(usuarioLogado: widget.usuarioLogado)));
        },
        icon: Icons.announcement,
      ),
      _Item(
        texto: 'Reservas',
        callback: () {},
        icon: Icons.edit_calendar,
      ),
      _Item(
        texto: 'Enquetes',
        callback: () {},
        icon: Icons.quiz,
      ),
      _Item(
        texto: 'Moradores',
        callback: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MoradoresPage(usuarioLogado: widget.usuarioLogado)));
        },
        icon: Icons.groups,
      ),
      _Item(
        texto: 'Configurações',
        callback: () {},
        icon: Icons.settings,
      ),
      _Item(
        texto: 'Sair',
        callback: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        icon: Icons.logout,
        cor: Color.fromARGB(255, 255, 0, 0),
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
                  _InfoCard(usuario: widget.usuarioLogado),
                  const Divider(height: 40, color: avatar_background_color_light, thickness: 1, indent: 15, endIndent: 15),
                  _ItemList(drawerItems: _drawerItems, selectedIndex: _selectedIndex),
                ],
              ),
            ),
          ),
          width: 270,
        ),
      ],
    );
  }
}

class _ItemList extends StatefulWidget {
  _ItemList({
    required this.drawerItems,
    required this.selectedIndex,
  });

  final List<_Item> drawerItems;
  int selectedIndex;

  @override
  State<_ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<_ItemList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.drawerItems.length,
            separatorBuilder: (BuildContext context, int index) {
              if (index == 3) {
                return Divider(height: 40, color: avatar_background_color_light, thickness: 1, indent: 15);
              } else {
                return SizedBox.shrink();
              }
            },
            itemBuilder: (BuildContext context, int index) {
              final isSelected = widget.selectedIndex == index;

              return GestureDetector(
                onTap: () async {
                  if (widget.selectedIndex != index) {
                    setState(() {
                      widget.selectedIndex = index;
                    });
                    await Future.delayed(Duration(milliseconds: duracaoAnimacao));
                    widget.drawerItems[index].callback();
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
                                  widget.drawerItems[index].icon,
                                  color: widget.drawerItems[index].cor,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Stack(
                            children: [
                              AnimatedDefaultTextStyle(
                                duration: Duration(milliseconds: duracaoAnimacao),
                                curve: Curves.easeInOut,
                                style: GoogleFonts.comfortaa(
                                  fontSize: isSelected ? 20 : 14,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..color = Colors.black
                                    ..strokeWidth = 0.5,
                                ),
                                child: Text(
                                  widget.drawerItems[index].texto,
                                ),
                              ),
                              AnimatedDefaultTextStyle(
                                duration: Duration(milliseconds: duracaoAnimacao),
                                curve: Curves.easeInOut,
                                style: GoogleFonts.comfortaa(
                                  color: widget.drawerItems[index].cor,
                                  fontSize: isSelected ? 20 : 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: Text(
                                  widget.drawerItems[index].texto,
                                ),
                              ),
                            ],
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final dynamic usuario;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: avatar_background_color_light,
        backgroundImage: AssetImage('assets/images/memoji/' + usuario.foto + '.png'),
        radius: 25,
      ),
      title: GoogleFontText(
        texto: formatarParaDoisNomes(usuario.nome),
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.bold,
        outlined: true,
        strokeWidth: 0.5,
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GoogleFontText(
            texto: usuario.cargo == 'morador' || usuario.cargo == 'sindico' ? usuario.apartamento.bloco + ' ' + usuario.apartamento.numApto : 'Administração',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            outlined: true,
            strokeWidth: 0.5,
          ),
          SizedBox(width: 5),
          usuario.cargo == 'sindico'
              ? Icon(
                  Icons.workspace_premium_outlined,
                  color: Colors.white,
                  size: 14,
                )
              : Icon(null)
        ],
      ),
    );
  }
}

class _Item {
  const _Item({
    required this.texto,
    required this.callback,
    required this.icon,
    this.cor = Colors.white,
  });

  final String texto;
  final VoidCallback callback;
  final IconData icon;
  final Color cor;
}
