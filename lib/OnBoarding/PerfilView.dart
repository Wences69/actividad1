import 'package:actividad1/FiresotreObjets/FBUsuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/CustomAppBar.dart';
import '../Custom/CustomButton.dart';
import '../Custom/CustomTextField.dart';
import '../Custom/CustomTextFormField.dart';

class PerfilView extends StatelessWidget {
  late BuildContext _context;

  TextEditingController tecName=TextEditingController();
  TextEditingController tecAge=TextEditingController();
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecBio=TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Perfil'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(tecController: tecName, sLabel: 'Nombre completo'),
            CustomTextFormField(tecController: tecAge, sLabel: 'Edad'),
            CustomTextFormField(tecController: tecUsername, sLabel: 'Nombre de usuario'),
            CustomTextField(tecController: tecBio, sLabel: 'Biografía...', iMaxLenght: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(sNombre: 'Cancelar', onPressed: onClickCancelar),
                  CustomButton(sNombre: 'Aceptar', onPressed: onClickAceptar),
                ]
            )
          ]
      ),
    );
  }

  Future<void> onClickAceptar() async {

    FBUsuario user = FBUsuario(name: tecName.text, age: int.parse(tecAge.text), username: tecUsername.text, bio: tecBio.text);

    await db.collection("Users").doc(uid).set(user.toFirestore());

    Navigator.of(_context).popAndPushNamed("/homeview");

  }
  void onClickCancelar() {
    FirebaseAuth.instance.signOut();
    Navigator.of(_context).popAndPushNamed("/loginview");
  }
}