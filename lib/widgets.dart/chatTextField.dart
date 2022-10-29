import 'package:flutter/material.dart';
import '../main.dart';
import 'expandedContainer.dart';

class ChatTextField extends StatefulWidget {
  Function() send;
  TextEditingController controller;
  Color bgColor;

  ChatTextField(
      {Key? key,
      required this.send,
      required this.controller,
      required this.bgColor})
      : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  late double textH, addingH;
  int rowLength = 1;
  @override
  Widget build(BuildContext context) {
    textH = appFonts.appHeight * 0.07;
    addingH = appFonts.appHeight * 0.025;

    return Container(
      height: textH + ((rowLength - 1) * addingH),
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.bgColor, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: widget.controller,
        style: appFonts.S(color: appColors.textColor),
        expands: true,
        textAlign: TextAlign.left,
        maxLines: null,
        decoration: InputDecoration(
            hintText: appText.typeMsg,
            contentPadding: EdgeInsets.symmetric(
                horizontal:
                    appFonts.appWidth * (appSettings.anyMobile ? 0.05 : 0.02),
                vertical: appFonts.appHeight * (rowLength == 1 ? 0.01 : 0.02)),
            hintStyle: TextStyle(color: Colors.grey.shade500),
            border: InputBorder.none),
        onChanged: (text) {
          int len = text.split("\n").length;
          if (len < 6 && len != rowLength) {
            rowLength = len;
            setState(() {});
          }
        },
      ),
    );
  }
}
