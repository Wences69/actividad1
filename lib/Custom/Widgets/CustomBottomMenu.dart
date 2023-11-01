import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  Function(int indice)? onBotonesClicked;

  CustomBottomMenu({
    Key? key,
    required this.onBotonesClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[900], // Fondo en azul oscuro
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange, // Sombra en naranja
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () => onBotonesClicked!(0),
            icon: Icon(Icons.list, color: Colors.blue[200]), // Icono en azul claro
            label: Text("Lista", style: TextStyle(color: Colors.blue[200])), // Texto en azul claro
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.blue[200], // Texto en azul claro
              shadowColor: Colors.transparent,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => onBotonesClicked!(1),
            icon: Icon(Icons.grid_view, color: Colors.blue[200]), // Icono en azul claro
            label: Text("Cuadrícula", style: TextStyle(color: Colors.blue[200])), // Texto en azul claro
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onPrimary: Colors.blue[200], // Texto en azul claro
              shadowColor: Colors.transparent,
            ),
          ),
          ElevatedButton(
            onPressed: () => onBotonesClicked!(2),
            child: Image.asset("resources/kyty_logo_nofondo.png", height: 24), // Icono del perfil
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
