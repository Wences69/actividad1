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
                  CustomButton(sNombre: 'Cancelar', onPressed: onClickRegistrar),
                  CustomButton(sNombre: 'Aceptar', onPressed: onClickAceptar),
                ]
            )
          ]
      ),
    );
  }

  void onClickAceptar(){

  }
  void onClickRegistrar(){
    Navigator.of(_context).popAndPushNamed("/registerview");
  }
}