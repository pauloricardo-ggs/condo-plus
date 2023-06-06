import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/dev_pack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerInfoCard extends StatelessWidget {
  final _devPack = const DevPack();
  final _authController = Get.put(AuthController());

  DrawerInfoCard();

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.secondary,
        backgroundImage: NetworkImage(_authController.perfil!.foto),
        radius: 25,
      ),
      title: Text(
        _devPack.formatarParaDoisNomes(_authController.perfil!.nomeCompleto),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _authController.perfil!.cargo == 'morador' || _authController.perfil!.cargo == 'sindico' ? _authController.perfil!.bloco + ' ' + _authController.perfil!.apartamento : 'Administração',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 5),
          Icon(
            _authController.perfil!.cargo == 'sindico' ? CupertinoIcons.bookmark_fill : null,
            color: Colors.white,
            size: 15,
          ),
        ],
      ),
    );
  }
}
