import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DevPack {
  final conectores = const ['da', 'das', 'do', 'dos', 'de', 'e'];
  final duracaoBase = const Duration(seconds: 3);

  const DevPack();

  String formatarParaTresNomes(String nome) {
    var nomeCompleto = nome.split(' ');
    var nomeSelecionado = [];

    if (nomeCompleto.length <= 3) {
      return nomeCompleto.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
    }

    nomeSelecionado.add(nomeCompleto.first);
    nomeSelecionado.add(nomeCompleto[1]);
    if (conectores.contains(nomeCompleto[1])) {
      nomeSelecionado.add(nomeCompleto[2]);
    }

    if (conectores.contains(nomeCompleto[nomeCompleto.length - 2])) {
      nomeSelecionado.add(nomeCompleto[nomeCompleto.length - 2]);
    }
    nomeSelecionado.add(nomeCompleto.last);

    return nomeSelecionado.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
  }

  String formatarParaDoisNomes(String nome) {
    var nomeCompleto = nome.split(' ');
    var nomeSelecionado = [];

    if (nomeCompleto.length < 3) {
      return nomeCompleto.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
    }

    nomeSelecionado.add(nomeCompleto.first);

    if (conectores.contains(nomeCompleto[nomeCompleto.length - 2])) {
      nomeSelecionado.add(nomeCompleto[nomeCompleto.length - 2]);
    }
    nomeSelecionado.add(nomeCompleto.last);

    return nomeSelecionado.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '');
  }

  void notificaoErro({String titulo = 'Oops!', required String mensagem, Duration? duracao}) {
    Get.snackbar(
      titulo,
      '',
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      duration: duracao ?? duracaoBase,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 3),
          Text(
            mensagem,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 10),
          AnimatedLinearProgressIndicator(duration: duracao ?? duracaoBase),
        ],
      ),
    );
  }

  void notificaoSucesso({String titulo = 'Oba!', required String mensagem, Duration? duracao}) {
    Get.snackbar(
      titulo,
      '',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: duracao ?? duracaoBase,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 3),
          Text(
            mensagem,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 10),
          AnimatedLinearProgressIndicator(duration: duracao ?? duracaoBase),
        ],
      ),
    );
  }

  String formatarParaMoeda(double valor) {
    var formatter = NumberFormat.currency(decimalDigits: 2, symbol: 'R\$');
    return formatter.format(valor).replaceAll('.', ':').replaceAll(',', '.').replaceAll(':', ',');
  }

  double formatarParaDuasCasas(double valor) {
    double valorArredondado = valor.floorToDouble();
    String valorString = valorArredondado.toStringAsFixed(2);
    double valorFormatado = double.parse(valorString);

    return valorFormatado;
  }

  String gerarSenha() {
    final rand = Random();
    final StringBuffer stringBuffer = StringBuffer();
    for (var i = 0; i < 18; i++) {
      final int randAlph = rand.nextInt(26) + 97;
      final int randNum = rand.nextInt(10);
      if (i == 0 || i == 6 || i == 12) {
        stringBuffer.writeCharCode(randAlph - 32);
      } else if (i == 5 || i == 11 || i == 17) {
        stringBuffer.write(randNum);
        if (i == 5 || i == 11) {
          stringBuffer.write("-");
        }
      } else {
        stringBuffer.writeCharCode(randAlph);
      }
    }
    debugPrint(stringBuffer.toString());
    return stringBuffer.toString();
  }
}

class AnimatedLinearProgressIndicator extends StatefulWidget {
  final Duration duration;

  const AnimatedLinearProgressIndicator({super.key, required this.duration});

  @override
  State<AnimatedLinearProgressIndicator> createState() => _AnimatedLinearProgressIndicatorState();
}

class _AnimatedLinearProgressIndicatorState extends State<AnimatedLinearProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.3)),
          backgroundColor: Colors.transparent,
          value: _animation.value,
        );
      },
    );
  }
}
