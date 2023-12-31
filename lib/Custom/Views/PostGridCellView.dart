import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostGridCellView extends StatelessWidget {
  final String sText;
  final int iColorCode;
  final double dFontSize;
  final double dHeight;
  final int iPosicion;
  final Function(int indice) onItemListClickedFun;

  const PostGridCellView({
    Key? key,
    required this.sText,
    required this.iColorCode,
    required this.dFontSize,
    required this.dHeight,
    required this.iPosicion,
    required this.onItemListClickedFun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemListClickedFun!(iPosicion),
      child: FractionallySizedBox(
        child: Container(
          height: dHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5
            ),
            image: DecorationImage(
              opacity: 0.3,
              image: NetworkImage("https://media.tenor.com/zBc1XhcbTSoAAAAC/nyan-cat-rainbow.gif"),
              fit: BoxFit.cover,
            ),
          ),
          color: Colors.amber[iColorCode],
          child: Column(
            children: [
              Text(sText, style: TextStyle(fontSize: dFontSize)),
            ],
          ),
        ),
      ),
    );
  }
}
