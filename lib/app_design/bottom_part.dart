import 'package:flutter/material.dart';
import '../functions/basic.dart';

import 'package:go_router/go_router.dart';
import '../main.dart';
import '../widgets.dart/expandedButton.dart';

class BottomPart extends StatelessWidget {
  BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          SizedBox(
            width: appFonts.appWidth * 0.1,
          ),
          Expanded(
            child: Column(
              children: [
                for (int i = 0; i < pageState.pageNames.length; i++)
                  ExpandedButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      pageState.changePage(
                          page: pageState.pageNames[i], context: context);
                    },
                    child: Text(
                      pageState.pageNames[i].capitalizeFirstofEach,
                      style:
                          appSettings.mobileMode ? appFonts.xS() : appFonts.S(),
                    ),
                  )
              ],
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: appColors.hintColor,
          ),
          Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }
}
