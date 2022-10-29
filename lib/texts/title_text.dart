import 'package:get/get.dart';

class TitleText extends GetxController {
  late String home,about,projects,services;
  setTexts(String language) {
    if (language == "English") {
      home = "Homepage Title";
      about="About me";
      services="Services";
      projects="Projects";
    }
    if (language == "Turkish") {
      home = "Anasayfa Başlık";
      about="Hakkımda";
      services="Hizmetler";
      projects="Projeler";
    }
  }
}