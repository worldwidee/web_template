import 'package:get/get.dart';

class WarningText extends GetxController {
  late String text;
  setTexts(String language) {
    if (language == "English") {
      text = "text";
    }
    if (language == "Turkish") {
      text = "metin";
    }
  }
}
