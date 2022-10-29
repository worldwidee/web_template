
import '../main.dart';
import 'package:flutter/material.dart';

import 'onHover.dart';

class ExpandedDropDown extends StatefulWidget {
  List<DropDownList> itemsData;
  String title, hintText;
  dynamic hintTextChanger;
  Alignment align;
  double radius;
  EdgeInsetsGeometry padding;
  int flex;
  ExpandedDropDown(
      {super.key, required this.itemsData,
      this.title = "",
      this.hintText = "",
      this.flex = 1,
      this.radius = 30,
      this.align = Alignment.centerLeft,
      this.padding = EdgeInsets.zero,
      required this.hintTextChanger});
  @override
  _ExpandedDropDownState createState() => _ExpandedDropDownState(
      itemsData, title, hintText, radius, padding, hintTextChanger);
}

class _ExpandedDropDownState extends State<ExpandedDropDown> {
  List<DropDownList> itemsData;
  String title;
  String hintText = "";
  dynamic hintTextChanger;
  double radius;
  EdgeInsetsGeometry padding;
  _ExpandedDropDownState(this.itemsData, this.title, this.hintText, this.radius,
      this.padding, this.hintTextChanger) {}
  void refListener() => setState(() => hintText = "");
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != "")
              Padding(
                padding: EdgeInsets.only(left: appFonts.appWidth * 0.03),
                child: Text(
                  title,
                  style: appFonts.M(),
                ),
              ),
            Expanded(
              child: OnHover(
                  doTransform: false,
                  builder: (isHovered) {
                    var color =
                        isHovered ? appColors.secondColor : Colors.transparent;
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: appColors.textColor),
                          borderRadius: BorderRadius.circular(radius),
                          color: color),
                      padding: EdgeInsets.symmetric(
                          horizontal: appFonts.appWidth * 0.01),
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: DropdownButton(
                              dropdownColor: appColors.secondColor,
                              isExpanded: true,
                              elevation: 0,
                              items: widget.itemsData
                                  .map((data) => DropdownMenuItem<String>(
                                        child: dropDownItem(data, appFonts.M()),
                                        value: data.value,
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  hintTextChanger(value);
                                  widget.hintText = value!;
                                });
                              },
                              hint: Padding(
                                padding: EdgeInsets.only(
                                    left: appFonts.appWidth * 0.01),
                                child: Align(
                                    alignment: widget.align,
                                    child: Text(widget.hintText,
                                        style: appFonts.M(
                                            color: appColors.textColor))),
                              )),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  dropDownItem(DropDownList data, TextStyle textStyle) {
    return Text(
      data.value,
      style: textStyle,
    );
  }
}

class DropDownList {
  String item;
  String value;
  DropDownList({required this.item, required this.value});
}
