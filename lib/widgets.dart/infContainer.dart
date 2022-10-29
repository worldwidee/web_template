import 'package:flutter/material.dart';

class InfContainer extends StatelessWidget {
  Widget child;
  Alignment alignment;
  BoxDecoration? decoration;
  EdgeInsetsGeometry? padding;
  InfContainer({required this.child,this.alignment=Alignment.center,this.decoration,this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: decoration,
      width: double.infinity,
      height: double.infinity,
      padding: padding,
      child: child,
    );
  }
}