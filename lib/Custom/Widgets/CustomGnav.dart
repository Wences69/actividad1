import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomGnav extends StatelessWidget {
  Function(int indice)? onBotonesClicked;

  CustomGnav({
    Key? key,
    required this.onBotonesClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(8),
            onTabChange: (index) => onBotonesClicked!(index),
            tabs: [
              GButton(
                  icon: Icons.list,
                  text: "Lista",
              ),
              GButton(
                  icon: Icons.grid_view,
                  text: "Cuadricula",
              ),
              GButton(
                  icon: Icons.home,
                  text: "Home",
              )
            ]),
      ),
    );
  }
}
