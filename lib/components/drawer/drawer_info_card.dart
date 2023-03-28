
import 'package:condo_plus/devpack.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerInfoCard extends StatelessWidget {
  final dynamic user;

  const DrawerInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.secondary,
        backgroundImage: AssetImage('assets/images/memoji/' + user.foto + '.png'),
        radius: 25,
      ),
      title: Text(
        formatarParaDoisNomes(user.nome),
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: DefaultValues.fontFamily,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            user.cargo == 'morador' || user.cargo == 'sindico' ? user.apartamento.bloco + ' ' + user.apartamento.numApto : 'Administração',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: DefaultValues.fontFamily,
            ),
          ),
          SizedBox(width: 5),
          Icon(
            user.cargo == 'sindico' ? CupertinoIcons.bookmark_fill : null,
            color: AppColors.white,
            size: 15,
          ),
        ],
      ),
    );
  }
}
