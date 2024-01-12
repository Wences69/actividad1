import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../FiresotreObjets/FbUsuario.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    await Future.delayed(Duration(seconds: 4));
    if (DataHolder().fbadmin.getCurrentUserID() != null) {
      FbUsuario? usuario = await DataHolder().loadFbUsuario();
      DataHolder().usuario = usuario;

      if (usuario!=null) {
        Navigator.of(context).popAndPushNamed("/homeview");
      }

      else {
        Navigator.of(context).popAndPushNamed("/perfilview");
      }

    }
    else {
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {

    Scaffold scaffold = Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
            child: Column(
              children: [
                Image.asset('assets/${DataHolder().platformAdmin.getPlatform()}/img/kyty_logo_nofondo.png', width: 200,
                    height: 350),
                CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  strokeWidth: 6.0,
                )
              ],
            )
        )
    );
    return scaffold;
  }
}