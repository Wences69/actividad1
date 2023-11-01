import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {

  Function(int indice)? onBotonesClicked;

  CustomBottomMenu({
   Key? key, required this.onBotonesClicked
  }) : super (key : key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(onPressed: () => onBotonesClicked!(0), child: Icon(Icons.list, color: Colors.pink,)),
        TextButton(onPressed: () => onBotonesClicked!(1), child: Icon(Icons.grid_view, color: Colors.pink,)),
        IconButton(onPressed: () => onBotonesClicked!(2), icon: Image.asset("resources/kyty_logo_nofondo.png"))
      ],
    );
  }
  
}