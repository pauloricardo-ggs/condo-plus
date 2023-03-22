import 'package:condo_plus/components/google_font_text.dart';
import 'package:condo_plus/configuracoes.dart';
import 'package:condo_plus/devPack.dart';
import 'package:flutter/material.dart';

class DrawerInfoCardComponent extends StatelessWidget {
  const DrawerInfoCardComponent({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final dynamic usuario;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: avatar_background_color_light,
        backgroundImage: AssetImage('assets/images/' + tipoAvatar + '/' + usuario.foto + '.png'),
        radius: 25,
      ),
      title: GoogleFontText(texto: formatarParaDoisNomes(usuario.nome), color: Colors.white, fontSize: 17),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GoogleFontText(
            texto: usuario.cargo == 'morador' || usuario.cargo == 'sindico' ? usuario.apartamento.bloco + ' ' + usuario.apartamento.numApto : 'Administração',
            color: Colors.white,
            fontSize: 14,
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
