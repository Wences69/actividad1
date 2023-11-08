import 'package:actividad1/FiresotreObjets/FbUsuario.dart';
import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomAppBar.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomTextField.dart';
import '../Custom/Widgets/CustomTextFormField.dart';

class PerfilView extends StatelessWidget {
  late BuildContext _context;

  TextEditingController tecName=TextEditingController();
  TextEditingController tecAge=TextEditingController();
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecBio=TextEditingController();

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

    FbUsuario user = FbUsuario(name: tecName.text, age: int.parse(tecAge.text), username: tecUsername.text, bio: tecBio.text);

    await DataHolder().fbadmin.getFirestoreInstance().collection("Users").doc(DataHolder().fbadmin.getCurrentUserID()).set(user.toFirestore());

    Navigator.of(_context).popAndPushNamed("/homeview");

  }
  void onClickCancelar() {
    DataHolder().fbadmin.getFirebaseAuthInstance().signOut();
    Navigator.of(_context).popAndPushNamed("/loginview");
  }
}