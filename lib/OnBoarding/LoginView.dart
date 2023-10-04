import 'package:actividad1/Custom/CustomButton.dart';
import 'package:actividad1/Custom/CustomTextFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/CustomAppBar.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Bienvenido al login'),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextFormField(tecController: tecUsername, sLabel: 'Escribe tu usuario'),
          CustomTextFormField(tecController: tecPassword, sLabel: 'Escribe tu contraseña', blIsPassword: true),
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

  void onClickAceptar() async{

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );
      Navigator.of(_context).popAndPushNamed("/homeview");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }

  void onClickRegistrar(){
    Navigator.of(_context).pushNamed("/registerview");
  }
}
