import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../functions/basic.dart';
import '../main.dart';
import 'app_settings.dart';

class AppColors extends GetxController {
  late ColorItem _backGroundColor, _alertBgColor, _alertTextColor;
  late ColorItem _secondColor;
  late ColorItem _textColor, _btnColor;
  late ColorItem _secondTextColor, _hintColor;

  AppColors() {
    setItems();
  }

  Color get backGroundColor {
    return Get.find<AppSettings>().darkMode == true
        ? _backGroundColor.darkColor
        : _backGroundColor.lightColor;
  }

  Color get btnColor {
    return Get.find<AppSettings>().darkMode == true
        ? _btnColor.darkColor
        : _btnColor.lightColor;
  }

  Color get secondColor {
    return Get.find<AppSettings>().darkMode == true
        ? _secondColor.darkColor
        : _secondColor.lightColor;
  }

  Color get textColor {
    return Get.find<AppSettings>().darkMode == true
        ? _textColor.darkColor
        : _textColor.lightColor;
  }

  Color get secondTextColor {
    return Get.find<AppSettings>().darkMode == true
        ? _secondTextColor.darkColor
        : _secondTextColor.lightColor;
  }

  Color get hintColor {
    return Get.find<AppSettings>().darkMode == true
        ? _hintColor.darkColor
        : _hintColor.lightColor;
  }
  Color get alertBgColor {
    return Get.find<AppSettings>().darkMode == true
        ? _alertBgColor.darkColor
        : _alertBgColor.lightColor;
  }
  Color get alertTextColor {
    return Get.find<AppSettings>().darkMode == true
        ? _alertTextColor.darkColor
        : _alertTextColor.lightColor;
  }

  Map<String, ColorItem> _specificColors = {};

  void listenState(State state) {
    void Function() setState = updateState(state);
    addListener(setState);
    pageState.setDispose = () {
      removeListener(setState);
    };
  }

  void addSpecificColor({required ColorItem color, required String name}) {
    _specificColors[name] = color;
  }

  void removeSpecificColor(String name) {
    _specificColors.removeWhere((key, value) => key == name);
  }

  Color specific(String name) {
    return Get.find<AppSettings>().darkMode == true
        ? _specificColors[name]!.darkColor
        : _specificColors[name]!.lightColor;
  }

  void setItems() {
    _backGroundColor = ColorItem(
        darkColor: const Color(0xFF181818),
        lightColor: const Color(0xFFf6fcf7));
    _secondColor =
        ColorItem(darkColor: Colors.black, lightColor: const Color(0xFF696c6e));
    _textColor = ColorItem(darkColor: Colors.white, lightColor: Colors.black);
    _secondTextColor =
        ColorItem(darkColor: Colors.white, lightColor: Colors.white);
    _hintColor = ColorItem(darkColor: Colors.white, lightColor: Colors.white);
    _btnColor =
        ColorItem(darkColor: Color(0xFF333333), lightColor: Color(0xFF333333));
    _alertBgColor =
        ColorItem(darkColor: Color(0xFF333333), lightColor: Color(0xFF333333));
    _alertTextColor =
        ColorItem(darkColor: Colors.white, lightColor: Colors.black);
  }
}

class ColorItem {
  Color darkColor;
  Color lightColor;
  ColorItem({required this.darkColor, required this.lightColor});
}
