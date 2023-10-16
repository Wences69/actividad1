import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/CustomAppBar.dart';
import '../Custom/CustomButton.dart';
import '../Custom/CustomTextFormField.dart';

class RegisterView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecPassword=TextEditingController();
  TextEditingController tecRepass=TextEditingController();

  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Bienvendio al registro'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(tecController: tecUsername, sLabel: 'Escribe tu correo'),
            CustomTextFormField(tecController: tecPassword, sLabel: 'Escribe tu contraseña', blIsPassword: true),
            CustomTextFormField(tecController: tecRepass, sLabel: 'Vuelva a escribir su contraseña', blIsPassword: true),
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

  void onClickAceptar() async {
    if(tecPassword.text==tecRepass.text) {
      try {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text,
        );
        Navigator.of(_context).popAndPushNamed("/perfilview");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    else{
      print('Las contraseñas no coinciden');
    }
  }

  void onClickCancelar(){
    Navigator.of(_context).popAndPushNamed("/loginview");
  }
}