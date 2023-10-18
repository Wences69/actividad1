import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{

  String sLabel;
  TextEditingController tecController;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;
  int? iMaxLenght;

  CustomTextFormField({Key? key,
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
          child: TextFormField(
              controller: tecController,
              obscureText: blIsPassword,
              enableSuggestions: !blIsPassword,
              autocorrect: !blIsPassword,
              maxLength: iMaxLenght,
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