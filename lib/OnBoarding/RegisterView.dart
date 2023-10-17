import 'package:actividad1/Custom/CustomSnackBar.dart';
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
            CustomTextFormField(tecController: tecUsername, sLabel: 'Correo electrónico'),
            CustomTextFormField(tecController: tecPassword, sLabel: 'Contraseña', blIsPassword: true),
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
    if(tecUsername.text==null&&tecPassword.text==null&&tecRepass.text==null);
    if (tecPassword.text==tecRepass.text) {
      try {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text,
        );
        Navigator.of(_context).popAndPushNamed("/perfilview");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomSnackbar(sMensaje: 'La contraseña es muy débil').show(_context);
        } else if (e.code == 'email-already-in-use') {
          CustomSnackbar(sMensaje: 'Ya existe una cuenta con este correo').show(_context);
        }
      } catch (e) {
        print(e);
      }
    }
    else {
      CustomSnackbar(sMensaje: 'Las contraseñas no coinciden').show(_context);
    }
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed("/loginview");
  }
}