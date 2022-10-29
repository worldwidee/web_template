import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_states/page_state.dart';
import '../../main.dart';
import '../../widgets.dart/textOfExpanded.dart';
import '../models.dart';

class ViewChildrenMenu extends StatefulWidget {
  List<ChildrenRoute> children;
  ViewChildrenMenu({Key? key, required this.children}) : super(key: key);

  @override
  _ViewChildrenMenuState createState() => _ViewChildrenMenuState(children);
}

class _ViewChildrenMenuState extends State<ViewChildrenMenu> {
  List<ChildrenRoute> children;
  _ViewChildrenMenuState(this.children);
  final controller = Get.find<PageState>();

  @override
  void initState() {
    initControllers(children);
    super.initState();
  }

  @override
  void dispose() {
    //disposeControllers(children);
    super.dispose();
  }

  void initControllers(List<ChildrenRoute> children) {
    for (var page in children) {
      Get.put(MenuController(page.children), tag: page.fullRoute);
      if (page.children != null) {
        initControllers(page.children!);
      }
    }
  }

  void disposeControllers(List<ChildrenRoute> children) {
    for (var page in children) {
      GetInstance().delete<MenuController>(tag: page.fullRoute);
      if (page.children != null) {
        disposeControllers(page.children!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var page in widget.children)
          MenuBtn(
            route: page,
            index: widget.children.indexOf(page),
            showNum: false,
            isMainMenu: true,
            depth: 0,
          )
      ],
    );
  }
}

class MenuBtn extends StatelessWidget {
  ChildrenRoute route;
  int index;
  bool showNum, isMainMenu;
  int depth;
  late MenuController controller;
  MenuBtn(
      {Key? key,
      required this.route,
      required this.index,
      required this.depth,
      this.isMainMenu = false,
      this.showNum = true})
      : super(key: key) {
    controller = Get.find<MenuController>(tag: route.fullRoute);
  }

  @override
  Widget build(BuildContext context) {
    double paddingW = appFonts.appWidth * 0.01;
    double width =
        appSettings.isMobile ? appFonts.appWidth : appFonts.appWidth * 0.2;
    TextStyle style = isMainMenu ? appFonts.M() : appFonts.S();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            if (route.children != null) {
              controller.changeStatus();
            } else {
              pageState.changePage(page: route.name, context: context);
            }
          },
          child: Container(
            width: (width) - (depth * paddingW),
            height: style.fontSize! * 2.5,
            child: Row(
              children: [
                TextOfExpanded(
                  (showNum ? "${index + 1}-" : "") + route.title!,
                  style: style,
                ),
                if (route.children != null)
                  GetBuilder<MenuController>(
                    tag: route.fullRoute,
                    builder: (_) {
                      return Icon(
                        controller.view
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: appFonts.icon_M(),
                      );
                    },
                  )
              ],
            ),
          ),
        ),
        route.children != null
            ? GetBuilder<MenuController>(
                tag: route.fullRoute,
                builder: (controller) {
                  return controller.view
                      ? Padding(
                          padding: EdgeInsets.only(left: paddingW),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var page in route.children!)
                                MenuBtn(
                                  route: page,
                                  index: route.children!.indexOf(page),
                                  depth: depth++,
                                )
                            ],
                          ),
                        )
                      : const SizedBox();
                },
              )
            : const SizedBox()
      ],
    );
  }
}

