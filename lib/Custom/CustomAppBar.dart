import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String sTitulo;
  final MaterialColor cColorFondo;
  final Color cColorTexto;
  final Color cColorSombra;
  final bool boolCentrarTitulo = true;

  CustomAppBar({Key? key,
    required this.sTitulo,
    this.cColorFondo = Colors.blue,
    this.cColorTexto = Colors.white,
    this.cColorSombra = Colors.deepOrange,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent.shade100,
      shadowColor: cColorSombra,
      title: Text(sTitulo),
      titleTextStyle: TextStyle(color: cColorTexto, fontSize: 22),
      centerTitle: boolCentrarTitulo,
    );
  }
}
