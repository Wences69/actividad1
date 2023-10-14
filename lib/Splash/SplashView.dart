import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  late BuildContext _context;

  void checkSession() async {}

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("resources/kyty_logo.png", width: 300, height: 450),
        CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.cyanAccent,
          strokeWidth: 6.0, // Ajusta el grosor del indicador
        )
      ],
    );

    return Center(child: column);
  }
}
