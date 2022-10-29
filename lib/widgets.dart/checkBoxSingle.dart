import '../main.dart';
import 'package:flutter/material.dart';

import 'CheckBoxList.dart';

class CheckBoxSingle extends StatefulWidget {
  CheckBoxItem item;
  void Function(CheckBoxItem item) fnc;
  dynamic unselectedColor, selectedColor;
  CheckBoxSingle({
    required this.item,
    required this.fnc,
    this.unselectedColor,
    this.selectedColor,
  }) {
    unselectedColor ??= appColors.textColor;
    if (selectedColor == null) unselectedColor = Color(0xFF6200EE);
  }

  @override
  _CheckBoxSingleState createState() =>
      _CheckBoxSingleState(item, fnc, unselectedColor, selectedColor);
}

class _CheckBoxSingleState extends State<CheckBoxSingle> {
  CheckBoxItem item;
  void Function(CheckBoxItem item) fnc;
  dynamic unselectedColor, selectedColor;

  _CheckBoxSingleState(
      this.item, this.fnc, this.unselectedColor, this.selectedColor);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        fnc(item);
        setState(() {
          item.isSelected = !item.isSelected;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: unselectedColor),
            child: Checkbox(
              onChanged: (bool? value) {
                fnc(item);
                setState(() {
                  item.isSelected = value!;
                });
              },
              value: item.isSelected,
              activeColor: selectedColor,
            ),
          ),
          item.child
        ],
      ),
    );
  }
}
