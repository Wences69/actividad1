import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (FirebaseAuth.instance.currentUser != null) {

      String uid=FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<FbUsuario> ref=db.collection("Users")
          .doc(uid)
          .withConverter(fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);

      DocumentSnapshot<FbUsuario> docSnap=await ref.get();
      FbUsuario usuario=docSnap.data()!;

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
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
              children: [
                Image.asset("resources/kyty_logo_nofondo.png", width: 200,
                    height: 350),
                CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.cyanAccent,
                  strokeWidth: 6.0,
                )
              ],
            )
        )
    );
    return scaffold;
  }
}