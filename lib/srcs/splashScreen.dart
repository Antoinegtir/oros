// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
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
                          child: Image.asset(
                        "assets/epitech.png",
                      ))
                    ],
                  ))),
          FadeInUp(
              duration: const Duration(seconds: 2),
              child: const Text(
                "Oros",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 36),
              ))
        ],
      ),
    );
  }
}
