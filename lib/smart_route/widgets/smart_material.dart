import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../app_design/control_panel.dart';
import '../../app_states/page_state.dart';
import '../models.dart';

class SmartMaterial extends StatelessWidget {
  late GoRouter router;
  SmartMaterial(
      {Key? key})
      : super(key: key) {
    router = GoRouter(
      routes: [
        for (var page in Get.find<PageState>().pages) ...[
          if (page.children != null) ...[
            GoRoute(
              path: page.route,
              name: page.name,
              redirect: (context, state) =>
                  (page.checkRedirect != null && page.checkRedirect!() != null)
                      ? page.checkRedirect!()
                      : page.redirect != null
                          ? (page.route + page.redirect!)
                          : null,
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                key: state.pageKey,
                child: ControlPanel(
                  key: state.pageKey,
                  route: page.route,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
            ...getRoutes(
                children: page.children!, route: page.route, page: page.page)
          ] else
            GoRoute(
                path: page.route,
                name: page.name,
                redirect: (context, state) => (page.checkRedirect != null &&
                        page.checkRedirect!() != null)
                    ? page.checkRedirect!()
                    : page.redirect,
                pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ControlPanel(
                        key: state.pageKey,
                        route: page.route,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    )),
          if (page.redirectFrom != null)
            for (var redirect in page.redirectFrom!)
              GoRoute(
                  path: redirect,
                  redirect: (context, state) => (page.checkRedirect != null &&
                          page.checkRedirect!() != null)
                      ? page.checkRedirect!()
                      : page.route),
        ]
      ],
      errorPageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ControlPanel(
                        key: state.pageKey,
                        route: null,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
    );
  }
  List<GoRoute> getRoutes(
      {required List<ChildrenRoute> children,
      required String route,
      required Widget page}) {
    List<GoRoute> routes = [];
    for (var child in children) {
      String path = route + child.route;
      GoRoute? routeItem;
      if (child.redirect != null) {
        routeItem = GoRoute(
            path: path,
            name: child.name,
            redirect: (context, state) =>
                (child.checkRedirect != null && child.checkRedirect!() != null)
                    ? child.checkRedirect!()
                    : path + child.redirect!);
      } else {
        routeItem = GoRoute(
            path: path,
            name: child.name,
            redirect: (context, state) =>
                (child.checkRedirect != null && child.checkRedirect!() != null)
                    ? child.checkRedirect!()
                    : null,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: ControlPanel(
                    key: state.pageKey,
                    route: path,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                ));
      }

      routes.add(routeItem);
      if (child.children != null) {
        routes = routes +
            getRoutes(children: child.children!, route: path, page: page);
      }
    }
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,);
  }
}
