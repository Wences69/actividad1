import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String sNombre;
  final Color cColorTexto;
  final double dFontSize;
  final Color cColorFondo;
  final VoidCallback onPressed;

  CustomButton({Key? key,
    required this.sNombre,
    this.cColorTexto = Colors.white,
    this.dFontSize = 16,
    this.cColorFondo = Colors.cyan,
    required this.onPressed,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(sNombre,
        style: TextStyle(
          color: cColorTexto,
          fontSize: dFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}