import 'package:flutter/material.dart';


class PostCellView extends StatelessWidget{

  final String sText;
  final int iPosicion;
  final int iColorCode;
  final double dFontSize;

  final Function(int indice)? onItemListClickedFun;

  const PostCellView ({super.key,
    required this.sText,
    required this.iPosicion,
    required this.iColorCode,
    required this.dFontSize,
    required this.onItemListClickedFun
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Container(
        color: Colors.amber[iColorCode],
        child: Row(
          children: [
            Image.asset('resources/kyty_logo_nofondo.png', width: 30, height: 45,),
            Text(sText)
          ],
        ),
      ),

      onTap: () => onItemListClickedFun!(iPosicion),
    );
  }

  
}