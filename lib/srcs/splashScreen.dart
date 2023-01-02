// ignore_for_file: file_names
import 'package:animate_do/animate_do.dart';
import 'package:epitech/model/localData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final dynamic jsonData;
  const SplashScreen({Key? key, this.jsonData}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

bool splash = false;

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    if (splash == false) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        setState(() {
          splash = true;
        });
        Navigator.pushNamed(context, '/home');
      });
    }
    return Consumer2<MyThemeModeModel, MyThemeSettingsModel>(
        builder: (context, mode, settings, child) {
      final lightmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == true
              ? Colors.black
              : Colors.white;

      final darkmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == false
              ? Colors.black
              : Colors.white;
      return Scaffold(
        backgroundColor: darkmode,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                            child: Image.asset(settings.isSettingsTheme == true
                                ? MediaQuery.of(context).platformBrightness !=
                                        Brightness.light
                                    ? "assets/epitech.png"
                                    : "assets/logo.png"
                                : mode.isModeTheme == false
                                    ? "assets/epitech.png"
                                    : "assets/logo.png"))
                      ],
                    ))),
            FadeInUp(
                duration: const Duration(seconds: 2),
                child: Text(
                  "Oros",
                  style: TextStyle(
                      color: lightmode,
                      fontWeight: FontWeight.w600,
                      fontSize: 36),
                ))
          ],
        ),
      );
    });
  }
}
