import 'package:condo_plus/components/geral/blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/controllers/auth_controller.dart';
import 'package:condo_plus/controllers/moradores_controller.dart';
import 'package:condo_plus/models/perfil_usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoradorDetalhesPopup extends StatelessWidget {
  final PerfilUsuario morador;
  final int index;
  final String tag;
  final _authController = Get.put(AuthController());
  final _moradoresController = Get.put(MoradoresController());

  MoradorDetalhesPopup({
    required this.morador,
    required this.index,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    PerfilUsuario _morador = morador;
    double _fonte = 18;
    final colorScheme = Theme.of(context).colorScheme;
    final ehAdmin = _authController.ehAdministracao();

    return BlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Hero(
            tag: tag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: colorScheme.primary,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_morador.foto),
                          backgroundColor: colorScheme.secondary,
                          radius: 60,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Center(
                          child: Text(
                            morador.nomeCompleto,
                            style: TextStyle(fontSize: 28, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      Text('Email:', style: TextStyle(color: Colors.white, fontSize: _fonte)),
                      SizedBox(height: 8),
                      Text(_morador.email, style: TextStyle(color: Colors.white, fontSize: _fonte)),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      Text('Telefone:', style: TextStyle(color: Colors.white, fontSize: _fonte)),
                      SizedBox(height: 8),
                      Text(_morador.telefone, style: TextStyle(color: Colors.white, fontSize: _fonte)),
                      Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                      ehAdmin
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cpf:', style: TextStyle(color: Colors.white, fontSize: _fonte)),
                                SizedBox(height: 8),
                                Text(_morador.cpf, style: TextStyle(color: Colors.white, fontSize: _fonte)),
                                SizedBox(height: 8),
                                Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                                Text('Data de nascimento:', style: TextStyle(color: Colors.white, fontSize: _fonte)),
                                SizedBox(height: 8),
                                Text(_morador.dataNascimento, style: TextStyle(color: Colors.white, fontSize: _fonte)),
                                Divider(color: Colors.white.withOpacity(0.9), height: 20, thickness: 0.5),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: _morador.cargo != 'sindico'
                                        ? () async {
                                            await _moradoresController.promoverParaSindico(_morador.id);
                                          }
                                        : null,
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(colorScheme.secondary),
                                    ),
                                    child: Text('Promover a síndico'),
                                  ),
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: !_morador.proprietario
                                        ? () async {
                                            await _moradoresController.adicionarPostoProprietario(_morador.id, _morador.bloco, _morador.apartamento);
                                          }
                                        : null,
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(colorScheme.secondary),
                                    ),
                                    child: Text('Marcar como proprietário'),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
