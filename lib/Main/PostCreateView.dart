import 'package:actividad1/FiresotreObjets/FbPost.dart';
import 'package:actividad1/Singeltone/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomAppBar.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomTextField.dart';
import '../Custom/Widgets/CustomTextFormField.dart';

class PostCreateView extends StatelessWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitle = TextEditingController();
  TextEditingController tecBody = TextEditingController();
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: CustomAppBar(sTitulo: 'Crea un post'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextFormField(
            tecController: tecTitle,
            sLabel: 'Titulo del post',
          ),
          CustomTextField(
            tecController: tecBody,
            sLabel: '¿Qué está pasando?',
            iMaxLenght: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(sNombre: 'Cancelar', onPressed: cancelar),
              CustomButton(sNombre: 'Postear', onPressed: postear),
            ],
          )
        ],
      ),
    );
  }

  void postear() {
    FbPost postNuevo = FbPost(title: tecTitle.text, body: tecBody.text);
    DataHolder().insertPostEnFB(postNuevo);
  }

  void cancelar() {
    Navigator.of(_context).pop();
  }
}
