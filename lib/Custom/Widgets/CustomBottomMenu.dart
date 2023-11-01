import 'package:actividad1/Interfaces/BottomMenuEvents.dart';
import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {

  late BottomMenuEvents events;

  CustomBottomMenu({
   Key? key, required this.events
  }) : super (key : key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(onPressed: () => events.onBottomMenuPressed(0), child: Icon(Icons.list, color: Colors.pink,)),
        TextButton(onPressed: () => events.onBottomMenuPressed(1), child: Icon(Icons.grid_view, color: Colors.pink,)),
        IconButton(onPressed: () => events.onBottomMenuPressed(2), icon: Image.asset("resources/kyty_logo_nofondo.png"))
      ],
    );
  }
  
}