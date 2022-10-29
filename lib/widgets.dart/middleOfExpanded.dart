// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MiddleOfExpanded extends StatelessWidget {
  Widget child;
  int flex;
  int childFlex;
  Axis scrollDirection;
  MiddleOfExpanded(
      {required this.child,
      this.flex = 1,
      this.childFlex = 1,
      this.scrollDirection = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: scrollDirection == Axis.horizontal
          ? Row(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: childFlex,
                  child: child,
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: childFlex,
                  child: child,
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
    );
  }
}
