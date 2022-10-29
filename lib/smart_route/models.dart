
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartRoute {
  String name;
  String route;
  Widget page;
  List<String>? redirectFrom;
  String? redirect, title;
  String? Function()? checkRedirect;
  List<ChildrenRoute>? children;
  SmartRoute(
      {required this.name,
      required this.route,
      required this.page,
      this.checkRedirect,
      this.redirect,
      this.title,
      this.children,
      this.redirectFrom});
}

class ChildrenRoute {
  String name;
  String route;
  List<dynamic>? _fathers;
  ChildrenRoute? _forward;
  ChildrenRoute? _behind;
  List<ChildrenRoute>? children;
  String? redirect, title, _fullRoute;
  String? Function()? checkRedirect;
  Widget? childPage;

  get fullRoute => _fullRoute;
  get fathers => _fathers;
  get forward => _forward;
  get behind => _behind;

  set setFullRoute(String route) {
    _fullRoute = route;
  }

  set setFathers(List<dynamic> fathers) {
    _fathers = fathers;
  }

  set setForward(ChildrenRoute forward) {
    _forward = forward;
  }

  set setBehind(ChildrenRoute behind) {
    _behind = behind;
  }

  ChildrenRoute(
      {required this.name,
      required this.route,
      this.redirect,
      this.children,
      this.checkRedirect,
      this.title,
      this.childPage});
}


class MenuController extends GetxController {
  bool view = false;
  List<ChildrenRoute>? children;
  MenuController(this.children);
  void changeStatus() {
    if (view) {
      close();
    } else {
      open();
    }
  }

  void close() {
    if (view == true) {
      if (children != null) {
        for (var child in children!) {
          Get.find<MenuController>(tag: child.fullRoute).close();
        }
      }
      view = !view;
      update();
    }
  }

  void open() {
    if (view == false) {
      view = !view;
      update();
    }
  }
}