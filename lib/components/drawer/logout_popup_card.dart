import 'package:condo_plus/components/geral/custom_blurred_container.dart';
import 'package:condo_plus/components/popup/custom_rect_tween.dart';
import 'package:condo_plus/screens/login_page.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class LogoutPopupCard extends StatelessWidget {
  final String tag;

  const LogoutPopupCard({required this.tag});

  @override
  Widget build(BuildContext context) {
    return CustomBlurredContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Hero(
            tag: tag,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Color.fromRGBO(133, 0, 0, 1),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DefaultValues.borderRadius)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Você está prestes a sair,',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontFamily: DefaultValues.fontFamily,
                          )),
                      Text('deseja prosseguir?',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontFamily: DefaultValues.fontFamily,
                          )),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => {
                                  Navigator.pop(context),
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(193, 0, 0, 1),
                                  elevation: 4,
                                ),
                                child: Text(
                                  'Sair',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 18,
                                    fontFamily: DefaultValues.fontFamily,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox.shrink(),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[600],
                                  elevation: 4,
                                ),
                                child: Text('Cancelar',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontFamily: DefaultValues.fontFamily,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
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
