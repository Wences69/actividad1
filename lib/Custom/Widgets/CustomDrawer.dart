import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Color cColorFondo;
  final List<Widget> children;
  final String name;
  final String username;

  void Function(int indice)? onItemTap;

  CustomDrawer({
    Key? key,
    required this.onItemTap,
    this.cColorFondo = Colors.black,
    this.children = const [],
    this.name="Invitado",
    this.username="Usuario Invitado"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: cColorFondo, // Utiliza el color de fondo personalizado
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text('@$username'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/${DataHolder().platformAdmin.getPlatform()}/img/kyty_logo_fondo.png'),
              ),
              decoration: BoxDecoration(color: Colors.blue[900]), // Color de fondo parte de arriba
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text("Home", style: TextStyle(color: Colors.white)),
              onTap: () => onItemTap!(0)
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text("Settings", style: TextStyle(color: Colors.white)),
              onTap: () => onItemTap!(1)
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
              onTap: () => onItemTap!(2)
            )
          ],
        ),
      ),
    );
  }
}
