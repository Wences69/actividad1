import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostGridCellView extends StatelessWidget{

  final String sText;
  final int iColorCode;
  final double dFontSize;
  final double dHeight;

  const PostGridCellView({super.key,
    required this.sText,
    required this.iColorCode,
    required this.dFontSize,
    required this.dHeight
  });

    @override
    Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: Container(
        height: dHeight,
          decoration: BoxDecoration(
          image: DecorationImage(
          opacity: 0.3,
          image: NetworkImage("https://media.tenor.com/zBc1XhcbTSoAAAAC/nyan-cat-rainbow.gif"),
          fit: BoxFit.cover
        )
      ),
          color: Colors.amber[iColorCode],
      child: Column(
        children: [
          Text(sText,style: TextStyle(fontSize: dFontSize)),
          TextButton(onPressed: null, child: Text("+",style: TextStyle(fontSize: dFontSize)))
          ],
        )
      ),
    );
  }
}