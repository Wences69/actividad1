import 'package:actividad1/Custom/CustomAppBar.dart';
import 'package:actividad1/Custom/PostCellView.dart';
import 'package:actividad1/FiresotreObjets/FbPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FiresotreObjets/FbUsuario.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late FbUsuario userProfile;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];

  @override
  void initState() {
    super.initState();
    userProfile = FbUsuario(name: '', age: 0, username: '', bio: '');
    cargarPerfil();
    descargarPosts();
  }

  void cargarPerfil() async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> perfil = await db.collection(
          "Users").doc(uid).get();

      setState(() {
        userProfile = FbUsuario.fromFirestore(perfil, null);
      });
    } catch (e) {}
  }

  void descargarPosts() async {
    CollectionReference<FbPost> ref = db.collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore());


    QuerySnapshot<FbPost> querySnapshot = await ref.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: CustomAppBar(
            sTitulo: 'Bienvenid@ ${userProfile?.username ?? 'Invitado'}'),
        body: ListView.builder(
          itemBuilder: creadorDeItemLista,
          itemCount: posts.length,
        )
    );
  }

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].title,
      dFontSize: 20,
      iColorCode: 0,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Column(
      children: [
        Divider(),
      ],
    );
  }
}