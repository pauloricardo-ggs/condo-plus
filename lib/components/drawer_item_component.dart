import 'package:condo_plus/components/google_font_text.dart';
import 'package:flutter/material.dart';

class DrawerItemComponent extends StatelessWidget {
  const DrawerItemComponent({
    Key? key,
    required this.texto,
    required this.callback,
    required this.icon,
    this.cor = Colors.white,
  }) : super(key: key);

  final String texto;
  final VoidCallback callback;
  final IconData icon;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: cor),
      title: GoogleFontText(texto: texto, color: cor),
      onTap: () async {
        Navigator.pop(context);
        callback();
      },
    );
  }
}
