import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../pages/error_screen.dart';
import '../smart_route/models.dart';
import '../smart_route/widgets/viewChildrenMenu.dart';

class PageState extends GetxController {
  List<SmartRoute> _pages = [];

  String _currentPage = "";
  String? _currentRoute;
  ChildrenRoute? _childRoute;
  SmartRoute? _mainRoute;
  List<dynamic> _disposeFuncs = [];
  Widget? _errorPage;
  dynamic _deliveringItem;

  get deliverinItem => _deliveringItem;
  String get currentPage => _currentPage;
  get currentRoute => _currentRoute;
  get mainRoute => _mainRoute;
  get childRoute => _childRoute;
  get errorPage => _errorPage;

  set setDispose(dynamic dispose) {
    _disposeFuncs.add(dispose);
  }

  void initRoute(String? route) {
    String pageName = "";
    SmartRoute? mainRoute;
    ChildrenRoute? childRoute;
    if(route!=null){
      for (var page in _pages) {
      if (page.route == route) {
        mainRoute = page;
        pageName = page.name;
      } else if (page.children != null) {
        ChildrenRoute? routeItem = searchChildRoute(
            pages: page.children!, searchRoute: route, route: page.route);
        if (routeItem != null) {
          pageName = routeItem.name;
          mainRoute = page;
          childRoute = routeItem;
        }
      }
    }
    }
    _currentRoute = route;
    _currentPage = pageName;
    _childRoute = childRoute;
    _mainRoute = mainRoute;
  }

  ChildrenRoute? searchChildRoute(
      {required List<ChildrenRoute> pages,
      required String searchRoute,
      required String route}) {
    ChildrenRoute? routeItem;
    for (var page in pages) {
      String path = route + page.route;
      if (path == searchRoute) {
        routeItem = page;
        return routeItem;
      } else if (page.children != null) {
        routeItem = searchChildRoute(
            pages: page.children!, searchRoute: searchRoute, route: path);
      }
    }
    return routeItem;
  }

  void setChildRoutes(
      {required List<ChildrenRoute> pages,
      required String route,
      required List<dynamic> fathers}) {
    for (var page in pages) {
      int index = pages.indexOf(page);
      String path = route + page.route;
      if (index != 0) {
        page.setBehind = pages[index - 1];
      }
      if (index != (pages.length - 1)) {
        page.setForward = pages[index + 1];
      }
      page.setFullRoute = path;
      page.setFathers = fathers;
      if (page.children != null) {
        setChildRoutes(
            pages: page.children!, route: path, fathers: [...fathers, page]);
      }
    }
  }

  void initPages(
      {required List<SmartRoute> pages, required String initPageName,required Widget errorPage}) {
    _pages = pages;
    _currentPage = initPageName;
    _errorPage=errorPage;
    for (var page in _pages) {
      if (page.children != null) {
        setChildRoutes(
            pages: page.children!,
            route: page.route,
            fathers: page.redirect == null ? [page] : []);
      }
    }
  }

  void disposeFunc() {
    if (_disposeFuncs.isNotEmpty) {
      for (var func in _disposeFuncs) {
        func();
      }
    }
    _disposeFuncs.clear();
  }

  List<SmartRoute> get pages => _pages;
  List<String> get pageNames => _pages.map((e) => e.name).toList();
  void changePage(
      {required String page,
      dynamic item = "",
      required BuildContext context}) {
    if (page != _currentPage) {
      _deliveringItem = item;
      _currentPage = page;
      disposeFunc();
      context.goNamed(page);
    }
  }

  Widget getPage() {
    if (_mainRoute != null) {
      return _mainRoute!.page;
    } else {
      return _errorPage!;
    }
  }

  Widget viewChildrenMenus() {
    return ViewChildrenMenu(
      children: _mainRoute!.children!,
    );
  }
}
