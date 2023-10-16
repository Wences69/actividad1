import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    await Future.delayed(Duration(seconds: 4));

    if (FirebaseAuth.instance.currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> perfil = await db.collection("Users").doc(uid).get();

      if(perfil.exists){
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
                Image.asset("resources/kyty_logo.png", width: 300,
                    height: 450),
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