import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart';
import '../app_states/page_state.dart';
import 'appbar.dart';
import 'bottom_part.dart';
import 'drawer.dart';

class ControlPanel extends StatefulWidget {
  String route;
  ControlPanel({Key? key, required this.route}) : super(key: key);

  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  _ControlPanelState();
  int? errPageNum;
  String? changingPage;
  void checkRoute() {
    if (pageState.currentRoute != widget.route) {
      pageState.initRoute(widget.route);
      if (pageState.currentPage != "") {
        pageState.disposeFunc();
      } else {
        pageState.disposeFunc();
        List<String> routes = widget.route.split("/");
        if (routes.any((element) => element == "healthassistant")) {
          errPageNum = 1;
        } else if (routes.any((element) => element == "docassistant")) {
          errPageNum = 2;
        } else {
          errPageNum = 0;
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appSettings.context = context;
    checkRoute();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.android ||
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.fuchsia) {
      appSettings.isMobile = true;
      appFonts.changeSizes(width: width, height: height, isResposible: true);
    } else {
      appSettings.isMobile = false;
      appFonts.changeSizes(width: width, height: height, isResposible: true);
    }
    return Scaffold(
      backgroundColor: appColors.backGroundColor,
      appBar: MyAppBar(),
      endDrawer:
          appSettings.mobileMode && widget.route != "/" ? MyDrawer() : null,
      body: Theme(
        data: appSettings.darkMode ? ThemeData.dark() : ThemeData.light(),
        child: SizedBox(
          width: appFonts.appWidth,
          child: ListView(
            children: [
              GetBuilder<PageState>(
                builder: (controller) {
                  return controller.getPage(widget.route);
                },
              ),
              BottomPart()
            ],
          ),
        ),
      ),
    );
  }
}
