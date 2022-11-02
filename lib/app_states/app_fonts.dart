
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../functions/basic.dart';
import '../main.dart';
import 'app_colors.dart';

class AppFonts extends GetxController {
  double _appWidth = 0;
  double _appHeight = 0;
  late double _size1, _size2, _size3, _size4, _size5, _size6, _totalSize;
  final Map<String, double> _sizeRatios = {
    "xS": 0.005,
    "S": 0.007,
    "M": 0.009,
    "L": 0.012,
    "xL": 0.015,
    "mega": 0.020
  };
  final Map<String, double> _sizeRatiosMobile = {
    "xS": 0.009,
    "S": 0.012,
    "M": 0.015,
    "L": 0.020,
    "xL": 0.025,
    "mega": 0.030
  };
  final Map<String, double> _sizeIconRatios = {
    "xS": 0.009,
    "S": 0.012,
    "M": 0.015,
    "L": 0.020,
    "xL": 0.025,
    "mega": 0.032
  };
  final Map<String, double> _staticSizes = {
    "xS": 14,
    "S": 18,
    "M": 22,
    "L": 28,
    "xL": 36,
    "mega": 45
  };
  final Map<String, double> _staticIconSizes = {
    "xS": 12,
    "S": 20,
    "M": 30,
    "L": 45,
    "xL": 60,
    "mega": 80
  };

  double _iconRatio = 0.02, _staticIconSize = 20;
  late double _iconSize;
  final Map<String, double> _specificSizes = {};

  get iconRatio => _iconRatio;
  get staticIconSize => _staticIconSize;
  get iconSize => _iconSize;
  get appWidth => _appWidth;
  get appHeight => _appHeight;
  get totalSize => _totalSize;

  double specificSize(String name) {
    return _specificSizes[name]!;
  }

  double icon_xS({bool isStatic = false}) => appSettings.mobileMode || isStatic
      ? _staticIconSizes["xS"]!
      : _totalSize * _sizeIconRatios["xS"]!;
  double icon_S({bool isStatic = false}) => appSettings.mobileMode || isStatic
      ? _staticIconSizes["S"]!
      : _totalSize * _sizeIconRatios["S"]!;
  double icon_M({bool isStatic = false}) => appSettings.mobileMode || isStatic
      ? _staticIconSizes["M"]!
      : _totalSize * _sizeIconRatios["M"]!;
  double icon_L({bool isStatic = false}) => appSettings.mobileMode || isStatic
      ? _staticIconSizes["L"]!
      : _totalSize * _sizeIconRatios["L"]!;
  double icon_xL({bool isStatic = false}) => appSettings.mobileMode || isStatic
      ? _staticIconSizes["xL"]!
      : _totalSize * _sizeIconRatios["xL"]!;
  double icon_mega({bool isStatic = false}) =>
      appSettings.mobileMode || isStatic
          ? _staticIconSizes["mega"]!
          : _totalSize * _sizeIconRatios["mega"]!;
  void changeSizes(
      {required double width,
      required double height,
      bool isResposible = true}) {
    bool? anyMobile = _appWidth!=0?appSettings.anyMobile:null;
    _appWidth = width;
    _appHeight = height;
    if (width <= 1100) {
      if (width > 900) {
        appSettings.midMode = true;
        appSettings.mobileMode = false;
      } else {
        appSettings.midMode = false;
        appSettings.mobileMode = true;
      }
      if (_appWidth > _appHeight) {
        appSettings.landScape = true;
        _appHeight = _appWidth;
      } else {
        appSettings.landScape = false;
      }
    } else {
      appSettings.mobileMode = false;
      appSettings.landScape = false;
      appSettings.midMode = false;
    }
    if(anyMobile!=null&&appSettings.anyMobile!=anyMobile){
      pageState.disposeFunc();
    }
    _totalSize = _appWidth + _appHeight;
    _size1 = isResposible
        ? _totalSize *
            ((appSettings.isMobile)
                ? _sizeRatiosMobile["xS"]!
                : _sizeRatios["xS"]!)
        : _staticSizes["xS"]!;
    _size2 = isResposible
        ? _totalSize *
            ((appSettings.isMobile)
                ? _sizeRatiosMobile["S"]!
                : _sizeRatios["S"]!)
        : _staticSizes["S"]!;
    _size3 = isResposible
        ? _totalSize *
            ((appSettings.isMobile)
                ? _sizeRatiosMobile["M"]!
                : _sizeRatios["M"]!)
        : _staticSizes["M"]!;
    _size4 = isResposible
        ? _totalSize *
            ((appSettings.isMobile)
                ? _sizeRatiosMobile["L"]!
                : _sizeRatios["L"]!)
        : _staticSizes["L"]!;
    _size5 = isResposible
        ? _totalSize *
            ((appSettings.isMobile)
                ? _sizeRatiosMobile["xL"]!
                : _sizeRatios["xL"]!)
        : _staticSizes["xL"]!;
    _size6 = isResposible
        ? _totalSize *
            ((appSettings.isMobile)
                ? _sizeRatiosMobile["mega"]!
                : _sizeRatios["mega"]!)
        : _staticSizes["mega"]!;
    _iconSize = isResposible ? _totalSize * _iconRatio : _staticIconSize;
    update();
  }

  void changeStaticSize({required String name, required double size}) {
    _staticSizes[name] = size;
    update();
  }

  void changeStaticSizeRatio({required String name, required double ratio}) {
    _sizeRatios[name] = ratio;
    update();
  }

  void addSpecificSize({required double size, required String name}) {
    _specificSizes[name] = size;
  }

  void removeSpecificSize(String name) {
    _specificSizes.removeWhere((key, value) => key == name);
  }

  void changeStaticIconSize(double size) {
    _staticIconSize = size;
    update();
  }

  void listenState(State state) {
    void Function() setState = updateState(state);
    addListener(setState);
    pageState.setDispose = () {
      removeListener(setState);
    };
  }

  void changeStaticIconRatio(double ratio) {
    _iconRatio = ratio;
    update();
  }

  TextStyle specific(
      {required String specificType,
      Color? color,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal}) {
    color ??= Get.find<AppColors>().textColor;
    return TextStyle(
        fontSize: _specificSizes[specificType],
        color: color,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle mega(
      {Color? color,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal,
      bool isStatic = false}) {
    color ??= Get.find<AppColors>().textColor;
    return TextStyle(
        fontSize: !isStatic ? _size6 : _staticSizes["mega"]!,
        color: color,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle xL(
      {Color? color,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal,
      bool isStatic = false}) {
    color ??= Get.find<AppColors>().textColor;
    return TextStyle(
        fontSize: !isStatic ? _size5 : _staticSizes["xL"]!,
        color: color,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle L(
      {Color? color,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal,
      bool isStatic = false}) {
    color ??= Get.find<AppColors>().textColor;
    return TextStyle(
        fontSize: !isStatic ? _size4 : _staticSizes["L"]!,
        color: color,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle M(
      {Color? color,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal,
      bool isStatic = false}) {
    color ??= Get.find<AppColors>().textColor;
    return TextStyle(
        fontSize: !isStatic ? _size3 : _staticSizes["M"]!,
        color: color,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle S(
      {Color? color,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal,
      bool isStatic = false}) {
    color ??= Get.find<AppColors>().textColor;
    return TextStyle(
        fontSize: !isStatic ? _size2 : _staticSizes["S"]!,
        color: color,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }

  TextStyle xS(
      {Color? color,
      bool? isBold,
      FontWeight fontWeight = FontWeight.normal,
      bool isStatic = false}) {
    color ??= Get.find<AppColors>().textColor;
    return TextStyle(
        fontSize: !isStatic ? _size1 : _staticSizes["xS"]!,
        color: color,
        fontWeight: isBold == null
            ? fontWeight
            : isBold
                ? FontWeight.bold
                : FontWeight.normal);
  }
}
