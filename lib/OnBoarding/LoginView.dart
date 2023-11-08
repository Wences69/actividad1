import 'package:actividad1/Custom/Widgets/CustomButton.dart';
import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomAppBar.dart';
import '../Custom/Widgets/CustomSnackBar.dart';
import '../Custom/Widgets/CustomTextFormField.dart';
import '../FiresotreObjets/FbUsuario.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Bienvenido al login'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(tecController: tecUsername, sLabel: 'Correo electrónico'),
            CustomTextFormField(tecController: tecPassword, sLabel: 'Contraseña', blIsPassword: true),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(sNombre: 'Registrar', onPressed: onClickRegistrar),
                  CustomButton(sNombre: 'Aceptar', onPressed: onClickAceptar),
                ]
            )
          ]
      ),
    );
  }

  void onClickAceptar() async {
    String errorMessage = checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(_context);
    }
    else if (errorMessage.isEmpty) {

        FbUsuario usuario = await DataHolder().fbadmin.inicioDeSesionCompleto(tecUsername, tecPassword);

        if (usuario != null) {
          Navigator.of(_context).popAndPushNamed("/homeview");
        }
        else {
          Navigator.of(_context).popAndPushNamed("/perfilview");
        }

    }
  }

  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed("/registerview");
  }

  String checkFields() {
    StringBuffer errorMessage = StringBuffer();

    if (tecUsername.text.isEmpty && tecPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    }

    else if (tecUsername.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    }

    else if (tecPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    }

    return errorMessage.toString();
  }
}