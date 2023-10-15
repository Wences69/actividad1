import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{

  String sLabel;
  TextEditingController tecController;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;
  int? iMaxLenght;
  final int? iMaxLines = null; //Siempre va a estar definido en nulo para que haga saltos de carro

  CustomTextField({Key? key,
    required this.tecController,
    this.sLabel="",
    this.blIsPassword=false,
    this.dPaddingH=60,
    this.dPaddingV=15,
    this.iMaxLenght,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: dPaddingH, vertical: dPaddingV),
      child: Row(children: [
        Flexible(
          child: TextField(
              controller: tecController,
              obscureText: blIsPassword,
              enableSuggestions: !blIsPassword,
              autocorrect: !blIsPassword,
              maxLength: iMaxLenght,
              maxLines: iMaxLines,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                labelText: sLabel,
              )),
        ),
      ],
      ),
    );
  }
}