import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/CustomAppBar.dart';
import '../Custom/CustomButton.dart';
import '../Custom/CustomTextField.dart';
import '../Custom/CustomTextFormField.dart';

class PerfilView extends StatelessWidget{
  late BuildContext _context;
  TextEditingController tecName=TextEditingController();
  TextEditingController tecAge=TextEditingController();
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecBio=TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Perfil'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(tecController: tecName, sLabel: 'Escribe tu nombre'),
            CustomTextFormField(tecController: tecAge, sLabel: 'Escribe tu edad'),
            CustomTextFormField(tecController: tecUsername, sLabel: 'Escribe tu nombre de usuario'),
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

  void onClickAceptar(){
    final user = <String, dynamic>{
      "name" : tecName.text,
      "age" : int.parse(tecAge.text),
      "username" : tecUsername.text,
      "bio" : tecBio.text
    };
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    db.collection("Users").doc(uidUser).set(user);
  }
  void onClickCancelar(){}
}