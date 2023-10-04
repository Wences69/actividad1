import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{

  String sLabel;
  TextEditingController tecController;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;

  CustomTextFormField({Key? key,
    this.sLabel="",
    required this.tecController,
    this.blIsPassword=false,
    this.dPaddingH=60,
    this.dPaddingV=15
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                labelText: sLabel,
              )),
        ),
      ],
      ),
    );
  }
}