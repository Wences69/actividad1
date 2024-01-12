import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<Widget> children;
  final String sName;
  final String sUsername;
  final void Function(int indice)? fOnItemTap;
  final void Function()? fOnProfilePictureTap;

  const CustomDrawer({
    Key? key,
    required this.fOnItemTap,
    this.fOnProfilePictureTap,
    this.children = const [],
    this.sName = "Invitado",
    this.sUsername = "Usuario Invitado",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(sName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              accountEmail: Text('@$sUsername',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
              ),
            ),

            Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(0),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(1),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'Buscar posts',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.sunny,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'El tiempo',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(3),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.map_sharp,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'Maps',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(4),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
