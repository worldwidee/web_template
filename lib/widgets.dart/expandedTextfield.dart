import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class ExpandedTextField extends StatelessWidget {
  String text;
  String hintText;
  String? labelText;
  int flex;
  TextEditingController controller;
  bool singleLine;
  TextStyle? textStyle, labelStyle;
  TextStyle? titleStyle, hintStyle;
  double radius, borderWidth;
  Color? color, borderColor;
  Color? enabledColor;
  Color? focusedColor, bacgroundColor;
  dynamic onChanged;
  bool isPassword;
  bool isUnderline, isExpanded, noInputBorder;
  double? width, height;
  TextInputType textInputType;
  Widget? prefixIcon;
  EdgeInsetsGeometry? padding;
  EdgeInsets? innerPadding;
  ExpandedTextField(
      {this.text = "",
      required this.hintText,
      required this.controller,
      this.singleLine = true,
      this.titleStyle,
      this.textStyle,
      this.hintStyle,
      this.color,
      this.borderColor,
      this.borderWidth = 1,
      this.radius = 10.0,
      this.onChanged,
      this.enabledColor,
      this.focusedColor,
      this.isPassword = false,
      this.labelText,
      this.labelStyle,
      this.isUnderline = true,
      this.isExpanded = true,
      this.width,
      this.height,
      this.textInputType = TextInputType.text,
      this.prefixIcon,
      this.bacgroundColor,
      this.padding = EdgeInsets.zero,
      this.innerPadding,
      this.noInputBorder = false,
      this.flex = 1}) {
    innerPadding ??= EdgeInsets.symmetric(horizontal: appFonts.appWidth * 0.01);
    titleStyle ??= appSettings.anyMobile
        ? appFonts.S(fontWeight: FontWeight.w600)
        : appFonts.M(fontWeight: FontWeight.w600);
    textStyle ??= appFonts.M();
    labelStyle ??= appFonts.M();
    hintStyle ??= appFonts.M(color: appColors.hintColor);
    enabledColor ??= appColors.textColor;
    focusedColor ??= Colors.cyan;
    if (!noInputBorder) {
      if (isUnderline) {
        enabledBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: enabledColor!),
        );
        focusedBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: focusedColor!),
        );
      } else {
        enabledBorder = OutlineInputBorder(
            borderSide: BorderSide(color: enabledColor!),
            borderRadius: BorderRadius.circular(radius));
        focusedBorder = OutlineInputBorder(
            borderSide: BorderSide(color: focusedColor!),
            borderRadius: BorderRadius.circular(radius));
      }
    }
    border = borderColor != null
        ? Border.all(width: borderWidth, color: borderColor!)
        : null;
  }
  dynamic enabledBorder, focusedBorder;
  BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(
            flex: flex,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: viewTextField(),
            ),
          )
        : Container(
            width: width,
            height: height,
            child: viewTextField(),
          );
  }

  Widget viewTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text != "")
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              text,
              style: titleStyle,
            ),
          ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  color: bacgroundColor,
                  borderRadius: BorderRadius.circular(radius),
                  border: border),
              padding: padding,
              child: TextField(
                controller: controller,
                maxLines: singleLine ? 1 : null,
                expands: singleLine ? false : true,
                style: textStyle,
                scrollPadding: EdgeInsets.zero,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: singleLine == false
                    ? TextInputType.multiline
                    : textInputType,
                inputFormatters: <TextInputFormatter>[
                  if (textInputType == TextInputType.number)
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: innerPadding,
                    hintStyle: hintStyle,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    border: noInputBorder ? InputBorder.none : null,
                    prefixIcon: prefixIcon,
                    labelText: labelText,
                    labelStyle: labelStyle),
                onChanged: (text) {
                  if (onChanged != null) onChanged(text);
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ExpandedTextFieldFull extends StatelessWidget {
  String text;
  String hintText;
  String? labelText;
  int flex;
  TextEditingController controller;
  bool singleLine;
  TextStyle? textStyle, labelStyle;
  TextStyle? titleStyle, hintStyle;
  double radius, borderWidth;
  Color? color, borderColor;
  Color? enabledColor;
  Color? focusedColor, bacgroundColor;
  dynamic onChanged;
  bool isUnderline, noInputBorder;
  TextInputType textInputType;
  Widget? prefixIcon;
  EdgeInsetsGeometry? padding;
  String errorText;
  bool? error;
  double paddingLeft;
  ExpandedTextFieldFull(
      {required this.text,
      required this.hintText,
      this.labelText,
      this.flex = 1,
      required this.controller,
      this.singleLine = true,
      this.textStyle,
      this.labelStyle,
      this.titleStyle,
      this.hintStyle,
      this.radius = 10,
      this.borderWidth = 1,
      this.color,
      this.borderColor,
      this.enabledColor,
      this.focusedColor,
      this.bacgroundColor,
      this.onChanged,
      this.isUnderline = true,
      this.noInputBorder = false,
      this.textInputType = TextInputType.text,
      this.prefixIcon,
      this.padding,
      this.errorText = "",
      this.paddingLeft = 0,
      this.error});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandedTextField(
            text: text,
            hintText: hintText,
            labelText: labelText,
            flex: flex,
            controller: controller,
            singleLine: singleLine,
            textStyle: textStyle,
            labelStyle: labelStyle,
            titleStyle: titleStyle,
            hintStyle: hintStyle,
            radius: radius,
            borderWidth: borderWidth,
            color: color,
            borderColor: borderColor,
            enabledColor: enabledColor,
            focusedColor: focusedColor,
            bacgroundColor: bacgroundColor,
            onChanged: onChanged,
            isUnderline: isUnderline,
            noInputBorder: noInputBorder,
            textInputType: textInputType,
            prefixIcon: prefixIcon,
            padding: padding,
            isExpanded: true,
          ),
          if (error != null)
            if (error == true)
              Text(errorText, style: appFonts.S(color: Colors.red))
        ],
      ),
    );
  }
}
