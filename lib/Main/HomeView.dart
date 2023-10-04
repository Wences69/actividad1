import 'package:actividad1/Custom/CustomAppBar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(sTitulo: 'Bienvenido al Home'),
    );
  }
}