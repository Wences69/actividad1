import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Color cColorFondo;
  final List<Widget> children;

  Function(int indice)? onItemTap;

  CustomDrawer({
    Key? key,
    required this.onItemTap,
    this.cColorFondo = Colors.black,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: cColorFondo, // Utiliza el color de fondo personalizado
        child: ListView(
          padding: EdgeInsets.zero,
          children: children,
        ),
      ),
    );
  }
}
