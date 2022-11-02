import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets.dart/dropDown.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    appSettings.listenState(this);
    appFonts.listenState(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: appFonts.appWidth,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DDButton(
            names: [appText.turkish, appText.english],
            width: 200,
            height: 50,
            text: appSettings.language,
            onChanged: (text) {
              appSettings.changeLang(text == "İngilizce"
                  ? "English"
                  : text == "Türkçe"
                      ? "Turkish"
                      : text);
            },
          ),
          const SizedBox(height: 20,),
          Text(
            titleText.about,
            style: appFonts.L(color: Colors.red),
          )
        ],
      ),
    );
  }
}
