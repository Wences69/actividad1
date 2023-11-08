import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../FiresotreObjets/FbPost.dart';
import '../Singeltone/DataHolder.dart';

class PostView extends StatefulWidget{
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost _datosPost = FbPost(title: "XXXX",body: "XXXX");
  bool blPostLoaded=false;

  @override
  void initState(){
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async{
    var temp1=await DataHolder().loadFbPost();
    setState(() {

      _datosPost=temp1!;
      blPostLoaded=true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: blPostLoaded ? Column(
        children: [
          Text(_datosPost.title),
          Text(_datosPost.body),
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.red), // Icono de corazón para representar "like"
          onPressed: () => null
          )
        ],
      )
          :
      CircularProgressIndicator(),
    );

  }
}