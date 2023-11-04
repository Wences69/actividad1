import 'package:actividad1/Custom/Views/PostGridCellView.dart';
import 'package:actividad1/Custom/Widgets/CustomAppBar.dart';
import 'package:actividad1/Custom/Views/PostCellView.dart';
import 'package:actividad1/Custom/Widgets/CustomBottomMenu.dart';
import 'package:actividad1/Custom/Widgets/CustomSnackBar.dart';
import 'package:actividad1/FiresotreObjets/FbPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomDrawer.dart';
import '../FiresotreObjets/FbUsuario.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late FbUsuario userProfile;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  bool bIsList=false;


  void onBottomMenuPressed(int indice) {
    setState(() {
      if(indice==0){
        bIsList=true;
      }
      else if (indice==1){
        bIsList=false;
      }
      /*else if (indice==2){
        exit(0);
      }*/
    });
  }

  void homeViewDrawerOnTap(int indice){
    if(indice==0){

    }
    else if(indice==1){

    }
    else if(indice==2){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

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
        sTitulo: 'Bienvenid@ ${userProfile?.username ?? 'Invitado'}',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      drawer: CustomDrawer(
        cColorFondo: Colors.black, // Personaliza el color de fondo del cajón
        onItemTap: homeViewDrawerOnTap,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userProfile?.name ?? 'Invitado'),
            accountEmail: Text(userProfile?.username ?? 'Usuario Invitado'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("resources/kyty_logo_fondo.png"),
            ),
          decoration: BoxDecoration(color: Colors.blue[900]), // Color de fondo parte de arriba
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text("Home", style: TextStyle(color: Colors.white)),
            onTap: () {Navigator.of(context).popAndPushNamed('/homeview');},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text("Settings", style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al hacer clic en Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
            onTap: _signOut,
          ),
        ],
      ),
      body: celdasOLista(bIsList),
      bottomNavigationBar: CustomBottomMenu(onBotonesClicked: onBottomMenuPressed),
    );
  }


  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].title,
      dFontSize: 20,
      iColorCode: 0,
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index){
    return PostGridCellView(sText: posts[index].title,
        iColorCode: 0,
        dFontSize: 20,
        dHeight: 400,
    );
  }
  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Column(
      children: [
        Divider(),
      ],
    );
  }

  Widget? celdasOLista(bool isList){
    if(isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    }
    else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemCount: posts.length,
          itemBuilder: creadorDeItemMatriz
      );
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).popAndPushNamed('/loginview');
    } catch (e) {
      CustomSnackbar(sMensaje: "Error al cerrar sesión");
    }
  }
}