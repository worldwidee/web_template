import 'package:flutter/material.dart';

import '../main.dart';

class DDButton extends StatelessWidget {
  late bool isExpanded;
  double? width, height;
  String text;
  int flex;
  List<String> names;
  Color? color;
  void Function(String item)? onChanged;
  TextStyle? style;
  DDButton(
      {this.width,
      this.height,
      this.text = "",
      required this.names,
      this.color,
      this.style,
      this.flex = 1,
      this.onChanged}) {
    if (width == null || height == null) {
      isExpanded = true;
    } else {
      isExpanded = false;
    }
    style ??= appFonts.M();
    color ??= appColors.secondColor;
  }
  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Expanded(
        flex: flex,
        child: dropdown(),
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
        child: dropdown(),
      );
    }
  }

  Widget dropdown() {
    return Stack(
      children: [
        Center(
          child: Text(
            text,
            style: style,
          ),
        ),
        SizedBox(
          width: width,
          height: height,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: appColors.secondColor,
              items: names.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: style,
                  ),
                );
              }).toList(),
              onChanged: (item) {
                if (onChanged != null) onChanged!(item!);
              },
            ),
          ),
        ),
      ],
    );
  }
}
