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
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: cColorTexto), // Utiliza el color de texto personalizado
          onPressed: () {
            // Agregar acción de búsqueda
          },
        ),
        IconButton(
          icon: Icon(Icons.settings, color: cColorTexto), // Utiliza el color de texto personalizado
          onPressed: () {
            // Agregar acción de configuración
          },
        ),
      ],
    );
  }
}
