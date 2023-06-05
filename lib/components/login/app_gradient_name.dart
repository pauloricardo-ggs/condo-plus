import 'package:flutter/cupertino.dart';

class AppGradientName extends StatelessWidget {
  const AppGradientName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [Color.fromRGBO(0, 98, 255, 1), Color.fromRGBO(201, 0, 255, 1)],
      ).createShader(bounds),
      child: Text(
        'condo+',
        style: TextStyle(fontSize: 54, fontFamily: 'Comfortaa'),
      ),
    );
  }
}
