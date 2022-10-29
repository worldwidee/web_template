import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_design/control_panel.dart';
import 'app_states/app_colors.dart';
import 'app_states/app_fonts.dart';
import 'app_states/app_settings.dart';
import 'app_states/page_state.dart';
import 'pages/about/about.dart';
import 'pages/home/home.dart';
import 'pages/projects/projects.dart';
import 'pages/services/services.dart';
import 'smart_route/models.dart';
import 'smart_route/widgets/smart_material.dart';
import 'texts/app_text.dart';
import 'texts/error_text.dart';
import 'texts/question_text.dart';
import 'texts/success_text.dart';
import 'texts/title_text.dart';
import 'texts/warning_text.dart';
import 'texts/wrong_text.dart';

late AppSettings appSettings;
late AppColors appColors;
late AppFonts appFonts;
late AppText appText;
late WrongText wrongText;
late SuccessText successText;
late ErrorText errorText;
late TitleText titleText;
late QuestionText questionText;
late WarningText warningText;
late PageState pageState;

void main() async {
  appSettings = Get.put(AppSettings());
  appColors = Get.put(AppColors());
  appText = Get.put(AppText());
  appFonts = Get.put(AppFonts());
  wrongText = Get.put(WrongText());
  successText = Get.put(SuccessText());
  errorText = Get.put(ErrorText());
  titleText = Get.put(TitleText());
  questionText = Get.put(QuestionText());
  warningText = Get.put(WarningText());
  pageState = Get.put(PageState());
  appSettings.changeLang("English");
  List<SmartRoute> pages = [
    SmartRoute(
      name: "about",
      route: "/about",
      page: About(),
    ),
    SmartRoute(
      name: "services",
      route: "/services",
      page: Services(),
    ),
    SmartRoute(
      name: "projects",
      route: "/projects",
      page: Projects(),
    ),
    SmartRoute(
      name: "home",
      route: "/home",
      title: "Homepage",
      redirectFrom: ["/"],
      page: Home(),
    ),
  ];
  pageState.initPages(pages: pages, initPageName: "home");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartMaterial(errorBuilder: (c, s) {
      return ControlPanel(
        route: s.path!,
      );
    });
  }
}
