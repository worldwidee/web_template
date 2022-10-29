import 'package:flutter/material.dart';

class ExpandedLine extends StatelessWidget {
  double width,height;
  bool isVertical;
  Color? color;
  ExpandedLine({this.width=1,this.height=1,this.isVertical=false,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical?width:double.infinity,
      height: isVertical?double.infinity:height,
      color: color,
    );
  }
}