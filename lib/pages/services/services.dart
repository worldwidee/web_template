import 'package:flutter/material.dart';
import 'package:furkanirmak/main.dart';
import 'package:furkanirmak/widgets.dart/dropDown.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
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
            titleText.services,
            style: appFonts.L(color: Colors.red),
          )
        ],
      ),
    );
  }
}
