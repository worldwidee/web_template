import 'package:flutter/material.dart';
import '../functions/basic.dart';

import '../main.dart';
import '../widgets.dart/expandedButton.dart';
import '../widgets.dart/infContainer.dart';
import '../widgets.dart/middleOfExpanded.dart';
import '../widgets.dart/sizedButton.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: appColors.backGroundColor,
      child: ListView(
        controller: ScrollController(),
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: appFonts.appHeight * 0.2,
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: appFonts.appWidth * 0.02,
                ),
                ExpandedButton(
                  onPressed: () {
                    pageState.changePage(page: "home", context: context);
                  },
                  flex: 3,
                  child: Image(
                    image: AssetImage("assets/icon.png"),
                    height: appFonts.appHeight * 0.06,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                MiddleOfExpanded(
                    scrollDirection: Axis.vertical,
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: InfContainer(
                          decoration: BoxDecoration(
                              color: appColors.btnColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.close,
                            size: appFonts.icon_M(),
                            color: appColors.textColor,
                          )),
                    ))
              ],
            ),
          ),
          for (int i = 0; i < pageState.pageNames.length; i++)
            ListTile(
              title: Text(
                pageState.pageNames[i].capitalizeFirstofEach,
                style: appFonts.M(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                if (i == 1) {
                  pageState.changePage(page: pageState.pageNames[i], context: context);
                }
              },
            ),
          SizedBox(
            height: appFonts.appHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appFonts.appWidth * 0.02),
            child: SizedButton(
              width: double.infinity,
              height: appFonts.appHeight * 0.1,
              color: appColors.btnColor,
              onPressed: () {
                pageState.changePage(page: "signIn", context: context);
              },
              child: Text(
                "SIGN IN",
                style: appFonts.S(isBold: true, isStatic: true),
              ),
            ),
          ),
          SizedBox(
            height: appFonts.appHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: appFonts.appWidth * 0.02),
            child: SizedButton(
              width: double.infinity,
              height: appFonts.appHeight * 0.1,
              color: Colors.lightBlueAccent,
              onPressed: () {
                pageState.changePage(page: "signUp", context: context);
              },
              child: Text(
                "TRY FOR FREE",
                style: appFonts.S(
                    isBold: true, color: Colors.white, isStatic: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
