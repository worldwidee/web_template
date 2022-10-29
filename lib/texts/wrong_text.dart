import 'package:get/get.dart';

class WrongText extends GetxController {
  late String staticText, text;
  setTexts(String language) {
    if (language == "English") {
      staticText = "Something went wrong while ";
      text = "$staticText--";
    }
    if (language == "Turkish") {
      staticText = " bir şeyler yanlış gitti";
      text = "--$staticText";
    }
  }
}
