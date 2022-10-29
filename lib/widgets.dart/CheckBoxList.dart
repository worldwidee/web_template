import 'package:flutter/material.dart';
import '../main.dart';
import 'expandedText.dart';

class CheckBoxList extends StatefulWidget {
  List<CheckBoxItem> items = [];
  dynamic unselectedColor, selectedColor;
  int columnCount;
  dynamic fnc;
  CheckBoxList(
      {super.key, required this.items,
      this.unselectedColor,
      this.selectedColor,
      required this.fnc,
      this.columnCount = 1}) {
    unselectedColor ??= appColors.textColor;
    if (selectedColor == null) unselectedColor = Color(0xFF6200EE);
  }
  @override
  _CheckBoxListState createState() => _CheckBoxListState(
      items, unselectedColor, selectedColor, fnc, columnCount);
}

class _CheckBoxListState extends State<CheckBoxList> {
  List<CheckBoxItem> items = [];

  dynamic fnc;
  dynamic unselectedColor, selectedColor;
  int columnCount;
  _CheckBoxListState(this.items, this.unselectedColor, this.selectedColor,
      this.fnc, this.columnCount) {
    if (items.any((element) => !element.isSelected))
      selectAll = false;
    else
      selectAll = true;
  }
  bool selectAll = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
      controller: ScrollController(),
        children: [
          TextButton(
            onPressed: () {
              selectAllItems();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  data: ThemeData(unselectedWidgetColor: unselectedColor),
                  child: Checkbox(
                    onChanged: (bool? value) {
                      selectAllItems();
                    },
                    value: selectAll,
                    activeColor: selectedColor,
                  ),
                ),
                Text(
                  appText.selectAll,
                  style: appFonts.M(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < items.length; i += columnCount)
            Row(
              children: [
                for (int j = i; j < i + columnCount; j++)
                  if (j < items.length)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          items[j].isSelected = !items[j].isSelected;
                        });
                        fnc(items);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData(
                                unselectedWidgetColor: unselectedColor),
                            child: Checkbox(
                              onChanged: (bool? value) {
                                setState(() {
                                  items[j].isSelected = value!;
                                });
                                fnc(items);
                              },
                              value: items[j].isSelected,
                              activeColor: selectedColor,
                            ),
                          ),
                          items[i].child
                        ],
                      ),
                    )
              ],
            )
        ],
      ),
    );
  }

  void selectAllItems() {
    selectAll = !selectAll;
    for (int i = 0; i < items.length; i++) {
      if (items[i].isSelected != selectAll) items[i].isSelected = selectAll;
    }
    setState(() {});
    fnc(items);
  }
}

class CheckBoxItem {
  bool isSelected;
  Widget child;
  dynamic item;
  CheckBoxItem({required this.child, this.isSelected = false, this.item});
}
