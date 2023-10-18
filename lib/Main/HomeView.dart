import 'package:actividad1/Custom/CustomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FiresotreObjets/FBUsuario.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late FBUsuario userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = FBUsuario(name: '', age: 0, username: '', bio: '');
    cargarPerfil();
  }

  void cargarPerfil() async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> perfil = await db.collection("Users").doc(uid).get();

      setState(() {
        userProfile = FBUsuario.fromFirestore(perfil, null);
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Bienvenid@ ${userProfile?.username ?? 'Invitado'}'),
    );
  }
}
