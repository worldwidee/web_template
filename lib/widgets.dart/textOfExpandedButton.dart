import 'package:flutter/material.dart';

import '../main.dart';
import 'expandedButton.dart';

class TextOfExpandedButton extends StatelessWidget {
  String text;
  TextStyle? style;
  Alignment alignment;
  dynamic onPressed;
  int flex;
  TextOfExpandedButton(this.text,
      {this.style,
      this.alignment = Alignment.centerLeft,
      this.flex = 1,
      this.onPressed}) {
    style ??= appFonts.M();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedButton(
        onPressed: onPressed,
        flex: flex,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: alignment,
          child: Text(
            text,
            style: style,
          ),
        ));
  }
}
