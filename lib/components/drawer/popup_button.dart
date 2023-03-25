import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/components/popup/hero_dialog_route.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class PopupButton extends StatelessWidget {
  final Widget popupCard;
  final String tag;
  final IconData icon;
  final Color color;

  const PopupButton({
    required this.popupCard,
    required this.tag,
    required this.icon,
    this.color = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return popupCard;
        }));
      },
      child: Hero(
        tag: tag,
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Material(
          color: color,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              icon,
              size: 23,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
