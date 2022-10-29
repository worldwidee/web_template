import 'package:flutter/material.dart';

import '../main.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({Key? key}) : super(key: key) {
    appBarHeight = appFonts.appHeight * 0.07;
    appBarHeight = appBarHeight < 50 ? 50 : appBarHeight;
  }

  late double appBarHeight;
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return AppBar(
      toolbarHeight: appBarHeight,
      backgroundColor: appColors.secondColor,
      flexibleSpace: Center(
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {
                pageState.changePage(page: "home", context: context);
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Image(
                image: AssetImage("assets/icon.png"),
                width: 100,
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
