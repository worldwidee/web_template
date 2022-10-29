import 'package:get/get.dart';

class AppText extends GetxController {
  late String hide,
      typeMsg,
      selectAll,
      thickness,
      mode,
      resetRotate,
      rotation,
      resetScale,
      scale,
      color,
      turkish,
      english;
  setTexts(String language) {
    if (language == "English") {
      hide = "Hide";
      typeMsg = "Type message...";
      selectAll = "Select All";
      thickness = "Thickness";
      mode = "Mode";
      resetRotate = "Reset Rotate";
      rotation = "Rotation";
      resetScale = "Reset scale";
      scale = "Scale";
      color = "Color";
      turkish = "Turkish";
      english = "English";
    }
    if (language == "Turkish") {
      hide = "Gizle";
      typeMsg = "Mesaj girin...";
      selectAll = "Hepsini Seç";
      thickness = "Kalınlık";
      mode = "Mod";
      resetRotate = "Döndürmeyi sıfırla";
      rotation = "Döndürme";
      resetScale = "Ölçeği sıfırla";
      scale = "Ölçek";
      color = "Renk";
      turkish = "Türkçe";
      english = "İngilizce";
    }
  }
}
