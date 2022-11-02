import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../functions/basic.dart';
import '../main.dart';

class AppSettings extends GetxController {
  bool _isInitilazed = false;
  String _language = "English";
  bool _darkMode = false;
  late bool _mobileMode, _isMobile, _landScape,_midMode;
  BuildContext? context;
  bool get darkMode => _darkMode;
  String get language => _language;
  bool get isInitilazed => _isInitilazed;
  bool get mobileMode => _mobileMode;
  bool get isMobile => _isMobile;
  bool get landScape => _landScape;
  bool get midMode => _midMode;
  bool get anyMobile => mobileMode || midMode || isMobile ? true : false;
  set mobileMode(bool status) {
    _mobileMode = status;
    //update();
  }

  set midMode(bool status) {
    _midMode = status;
    //update();
  }
  set isMobile(bool status) {
    _isMobile = status;
    //update();
  }

  set landScape(bool status) {
    _landScape = status;
  }

  void changeInitialLoaded(bool status) {
    _isInitilazed = status;
    update();
  }

  void listenState(State state) {
    void Function() setState = updateState(state);
    addListener(setState);
    pageState.setDispose = () {
      removeListener(setState);
    };
  }

  void changeLang(String lang) {
    _language = lang;
    appText.setTexts(language);
    wrongText.setTexts(language);
    errorText.setTexts(language);
    successText.setTexts(language);
    titleText.setTexts(language);
    questionText.setTexts(language);
    warningText.setTexts(language);
    update();
  }

  void changeDarkMode() {
    _darkMode = !_darkMode;
    update();
  }
}
