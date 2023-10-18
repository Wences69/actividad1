import 'package:flutter/material.dart';


class PostCellView extends StatelessWidget{

  final String sText;
  final int iColorCode;
  final double dFontSize;

  const PostCellView ({super.key,
    required this.sText,
    required this.iColorCode,
    required this.dFontSize
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.amber[iColorCode],
      child: Row(
        children: [
          Image.asset('resources/kyty_logo_nofondo.png', width: 30, height: 45,),
          Text(sText)
        ],
      ),
    );
  }

  
}