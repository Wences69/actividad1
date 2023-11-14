import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String sTitulo;
  final Color? cColorFondo;
  final Color? cColorTexto;
  final Color? cColorSombra;
  final bool boolCentrarTitulo;
  final List<Widget> actions; // Lista de acciones (iconos) a la derecha del AppBar

  CustomAppBar({
    Key? key,
    required this.sTitulo,
    this.cColorFondo,
    this.cColorTexto,
    this.cColorSombra,
    this.boolCentrarTitulo = true,
    this.actions = const [], // Inicializa la lista de acciones vacía
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shadowColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        sTitulo,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: boolCentrarTitulo,
      actions: actions,
    );
  }
}