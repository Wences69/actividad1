import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String sTitulo;
  final Color cColorFondo;
  final Color cColorTexto;
  final Color cColorSombra;
  final bool boolCentrarTitulo;
  final List<Widget> actions; // Lista de acciones (iconos) a la derecha del AppBar

  CustomAppBar({
    Key? key,
    required this.sTitulo,
    this.cColorFondo = Colors.blueAccent,
    this.cColorTexto = Colors.white,
    this.cColorSombra = Colors.deepOrange,
    this.boolCentrarTitulo = true,
    this.actions = const [], // Inicializa la lista de acciones vacía
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[900], // Utiliza el color de fondo personalizado
      shadowColor: cColorSombra, // Utiliza el color de sombra personalizado
      title: Text(
        sTitulo,
        style: TextStyle(
          color: cColorTexto, // Utiliza el color de texto personalizado
          fontSize: 22,
          fontWeight: FontWeight.bold, // Texto en negrita
        ),
      ),
      centerTitle: boolCentrarTitulo,
      actions: actions, // Agrega las acciones personalizadas a la derecha del AppBar
    );
  }
}
