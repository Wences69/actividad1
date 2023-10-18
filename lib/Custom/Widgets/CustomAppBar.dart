import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String sTitulo;
  final Color cColorFondo;
  final Color cColorTexto;
  final Color cColorSombra;
  final bool boolCentrarTitulo;

  CustomAppBar({
    Key? key,
    required this.sTitulo,
    this.cColorFondo = Colors.blueAccent,
    this.cColorTexto = Colors.white,
    this.cColorSombra = Colors.deepOrange,
    this.boolCentrarTitulo = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: cColorFondo,
      shadowColor: cColorSombra,
      title: Text(sTitulo, style: TextStyle(color: cColorTexto, fontSize: 22)), // Aplica el estilo al texto del título
      centerTitle: boolCentrarTitulo,
    );
  }
}
