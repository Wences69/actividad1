import 'package:actividad1/Custom/Widgets/CustomAppBar.dart';
import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:flutter/material.dart';

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(sTitulo: DataHolder().sPostTitle),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.title),
          Text(DataHolder().selectedPost.body),
          Image.network("img"),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red), // Icono de corazón para representar "like"
            onPressed: () {
              // Lógica para manejar el evento de "like" aquí
            },
          ),
        ],
      ),
    );
  }
}
