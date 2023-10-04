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
      appBar: CustomAppBar(sTitulo: 'Login'),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextFormField(tecController: tecUsername, sLabel: 'Escribe tu usuario'),
          CustomTextFormField(tecController: tecPassword, sLabel: 'Escribe tu contraseña', blIsPassword: true),
        ],
      ),
    );
  }
}
