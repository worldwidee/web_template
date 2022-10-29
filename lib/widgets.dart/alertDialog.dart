import '../main.dart';
import "package:flutter/material.dart";

Future<dynamic> myDialog(
    {required Widget child,
    String title = "",
    bool noAction = false,
    bool zeroPadding = false,
    bool barrierDismissible = true,
    Color? bgColor,
    required BuildContext context}) {

  return showDialog(
      context: context,
      barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        Widget? titleWidget = title != ""
            ? Text(
                title,
                style: appFonts.L(isBold: true),
              )
            : null;
        List<Widget>? actions;
        if (noAction == false) {
          actions = [
            TextButton(
              child: Text(appText.hide, style: appFonts.M(color: appColors.hintColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ];
        }
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            contentPadding: zeroPadding
                ? EdgeInsets.zero
                : const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            title: titleWidget,
            backgroundColor: bgColor ?? appColors.alertBgColor,
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[child]),
            ),
            actions: actions,
          );
        });
      });
}
