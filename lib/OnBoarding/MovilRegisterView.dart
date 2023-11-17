import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomAppBar.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomSnackBar.dart';
import '../Custom/Widgets/CustomTextFormField.dart';

class MovilRegisterView extends StatelessWidget {

  late BuildContext _context;
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecPassword=TextEditingController();
  TextEditingController tecRepass=TextEditingController();

  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Bienvendio al registro en movil'),
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
    String errorMessage = checkFields();

    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(_context);
    }

    else if (errorMessage.isEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text,
        );
        Navigator.of(_context).popAndPushNamed("/perfilview");
      }

      on FirebaseAuthException catch (e) {

        if (e.code == 'weak-password') {
          CustomSnackbar(sMensaje: 'La contraseña es muy débil').show(_context);
        }

        else if (e.code == 'email-already-in-use') {
          CustomSnackbar(sMensaje: 'Ya existe una cuenta con este correo').show(_context);
        }
      }
      catch (e) {
        print(e);
      }
    }
  }

  String checkFields() {
    StringBuffer errorMessage = StringBuffer();

    if (tecUsername.text.isEmpty && tecPassword.text.isEmpty && tecRepass.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    }

    else if (tecUsername.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    }

    else if (tecPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    }

    else if (tecRepass.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de confirmación de contraseña');
    }

    return errorMessage.toString();
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed("/loginview");
  }
}