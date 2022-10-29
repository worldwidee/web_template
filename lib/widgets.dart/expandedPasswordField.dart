import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_states/app_fonts.dart';
import '../main.dart';

class ExpandedPasswordField extends StatefulWidget {
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
  Color? focusedColor, bacgroundColor, iconColor;
  dynamic onChanged;
  bool isPassword;
  bool isUnderline, isExpanded, noInputBorder;
  double? width, height;
  TextInputType textInputType;
  EdgeInsetsGeometry? padding;
  ExpandedPasswordField(
      {this.text = "",
      required this.hintText,
      required this.controller,
      this.singleLine = true,
      this.titleStyle,
      this.textStyle,
      this.hintStyle,
      this.color,
      this.iconColor,
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
      this.bacgroundColor,
      this.padding = EdgeInsets.zero,
      this.noInputBorder = false,
      this.flex = 1});

  @override
  _ExpandedPasswordFieldState createState() => _ExpandedPasswordFieldState(
      text,
      hintText,
      controller,
      singleLine,
      titleStyle,
      textStyle,
      hintStyle,
      color,
      borderColor,
      borderWidth,
      radius,
      onChanged,
      enabledColor,
      focusedColor,
      isPassword,
      labelText,
      labelStyle,
      isUnderline,
      isExpanded,
      width,
      height,
      textInputType,
      bacgroundColor,
      padding,
      noInputBorder,
      flex,
      iconColor);
}

class _ExpandedPasswordFieldState extends State<ExpandedPasswordField> {
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
  Color? focusedColor, bacgroundColor, iconColor;
  dynamic onChanged;
  bool isPassword;
  bool isUnderline, isExpanded, noInputBorder;
  double? width, height;
  TextInputType textInputType;
  EdgeInsetsGeometry? padding;
  bool showPw = false;
  _ExpandedPasswordFieldState(
      this.text,
      this.hintText,
      this.controller,
      this.singleLine,
      this.titleStyle,
      this.textStyle,
      this.hintStyle,
      this.color,
      this.borderColor,
      this.borderWidth,
      this.radius,
      this.onChanged,
      this.enabledColor,
      this.focusedColor,
      this.isPassword,
      this.labelText,
      this.labelStyle,
      this.isUnderline,
      this.isExpanded,
      this.width,
      this.height,
      this.textInputType,
      this.bacgroundColor,
      this.padding,
      this.noInputBorder,
      this.flex,
      this.iconColor) {
    iconColor ??= appColors.textColor;
    titleStyle ??= appFonts.M(isBold: true);
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
  void setStateHere() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  dynamic enabledBorder, focusedBorder;
  BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppFonts>(builder: (_) {
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
    });
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
              padding: padding,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: bacgroundColor,
                        borderRadius: BorderRadius.circular(radius),
                        border: border),
                    child: TextField(
                      controller: controller,
                      maxLines: singleLine ? 1 : null,
                      expands: singleLine ? false : true,
                      style: textStyle,
                      obscureText: showPw ? false : true,
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: appFonts.appWidth * 0.01),
                          hintStyle: hintStyle,
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          border: noInputBorder ? InputBorder.none : null,
                          labelText: labelText,
                          labelStyle: labelStyle),
                      onChanged: (text) {
                        if (onChanged != null) onChanged(text);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            showPw = !showPw;
                          });
                        },
                        icon: Icon(
                          showPw ? Icons.visibility_off : Icons.visibility,
                          color: iconColor,
                        )),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ExpandedPasswordFieldFull extends StatelessWidget {
  String text, hintText, errorText;
  int flex;
  bool? error;
  double paddingLeft;
  TextEditingController controller;
  dynamic color, borderColor;
  double radius, borderWidth;
  dynamic enabledColor;
  dynamic focusedColor;
  dynamic onChanged;
  TextStyle? hintStyle, textStyle, labelStyle;
  ExpandedPasswordFieldFull(
      {required this.text,
      required this.hintText,
      this.errorText = "",
      required this.controller,
      this.paddingLeft = 0,
      this.flex = 1,
      this.color,
      this.borderColor,
      this.borderWidth = 1,
      this.radius = 10.0,
      this.enabledColor,
      this.focusedColor,
      this.hintStyle,
      this.textStyle,
      this.labelStyle,
      this.onChanged,
      this.error});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandedPasswordField(
              text: text,
              hintText: hintText,
              controller: controller,
              color: color,
              borderColor: borderColor,
              borderWidth: borderWidth,
              radius: radius,
              enabledColor: enabledColor,
              focusedColor: focusedColor,
              textStyle:textStyle,
              labelStyle:labelStyle,
              hintStyle:hintStyle,
              onChanged: onChanged),
          if (error != null)
            if (error == true)
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(errorText, style: appFonts.M(color: Colors.red)))
        ],
      ),
    );
  }
}
