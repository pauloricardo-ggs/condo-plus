import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBlurredContainer extends StatelessWidget {
  final Widget child;

  const CustomBlurredContainer({required this.child});

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
        child,
      ],
    );
  }
}
