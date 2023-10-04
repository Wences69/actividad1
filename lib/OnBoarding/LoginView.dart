import 'package:actividad1/Custom/CustomButton.dart';
import 'package:actividad1/Custom/CustomTextFormField.dart';
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
      appBar: CustomAppBar(sTitulo: 'Bienvendio al login'),
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

  void onClickAceptar(){}

  void onClickRegistrar(){}
}
