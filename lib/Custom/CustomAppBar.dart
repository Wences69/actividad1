import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final Color colorFondo;
  final Color colorTexto;
  final bool centrarTitulo = true;

  CustomAppBar({
    required this.titulo,
    this.colorFondo = Colors.blue,
    this.colorTexto = Colors.white,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorFondo,
      title: Text(
        titulo,
        style: TextStyle(
            color: colorTexto),
      ),
      centerTitle: centrarTitulo,
    );
  }
}
