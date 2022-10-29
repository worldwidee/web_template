import 'package:get/get.dart';

class QuestionText extends GetxController {
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
