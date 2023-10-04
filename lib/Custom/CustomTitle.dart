import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget{
  final String sTitulo;
  final double dFontSize;
  final Color cColorTexto;
  double dPaddingH;
  double dPaddingV;

  CustomTitle({Key? key,
    required this.sTitulo,
    this.dFontSize = 25,
    this.cColorTexto = Colors.black,
    this.dPaddingH=60,
    this.dPaddingV=15
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: dPaddingH, vertical: dPaddingV),
      child: Row(children: [
        Flexible(
          child: Text(sTitulo,
        style: TextStyle(
          fontSize: dFontSize,
          color: cColorTexto),
          textAlign: TextAlign.center),
        ),
      ],
      ),
    );
  }

}