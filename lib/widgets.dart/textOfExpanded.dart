import 'package:flutter/material.dart';

import '../main.dart';

class TextOfExpanded extends StatelessWidget {
  String text;
  TextStyle? style;
  Alignment alignment;
  int flex;
  Color? bgColor;
  EdgeInsetsGeometry padding;
  Decoration? decoration;
  EdgeInsetsGeometry textPadding;
  TextOfExpanded(this.text,
      {this.style,
      this.alignment = Alignment.centerLeft,
      this.flex = 1,
      this.bgColor,
      this.decoration,
      this.padding = EdgeInsets.zero,
      this.textPadding = EdgeInsets.zero}) {
    style ??= appFonts.M();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: padding,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:decoration ,
            color: bgColor,
            alignment: alignment,
            child: Padding(
              padding: textPadding,
              child: Text(
                text,
                style: style,
              ),
            ),
          ),
        ));
  }
}
