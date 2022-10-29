
import 'package:flutter/material.dart';

import 'infContainer.dart';

class ExpandedContainer extends StatelessWidget {
  Widget child;
  int flex;
  Alignment alignment;
  BoxDecoration? decoration;
  EdgeInsetsGeometry padding,innerPadding;
  ExpandedContainer(
      {super.key, required this.child,
      this.alignment = Alignment.center,
      this.flex = 1,
      this.padding=EdgeInsets.zero,
      this.innerPadding=EdgeInsets.zero,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: padding,
          child: InfContainer(
            decoration: decoration,
            child: child,
            alignment: alignment,
            padding: innerPadding,
          ),
        ));
  }
}
