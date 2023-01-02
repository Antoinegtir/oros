// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:epitech/model/localData.dart';
import 'package:epitech/settings/about.dart';
import 'package:epitech/settings/apparence.dart';
import 'package:epitech/srcs/ListScreen.dart';
import 'package:epitech/srcs/homeScreen.dart';
import 'package:epitech/srcs/splashScreen.dart';
import 'package:epitech/srcs/subScreen.dart';
import 'package:epitech/utilities/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:http/http.dart' as http;
import 'settings/device.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String formattedDate = dateFormat.format(now);

  setPathUrlStrategy();
  // Make a GET request to the URL and retrieve the response
  final url = Uri.parse(
      'https://api.oros.dahobul.com/rooms-activities?from=$formattedDate&to=$formattedDate');
  final response = await http.get(url);
  // Check that the request was successful
  // Parse the response body as JSON

  final dynamic jsonData = json.decode(response.body);

  // Now you can use the `jsonData` variable in your appM
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(jsonData: jsonData, sharedPreferences: sharedPreferences));
}

bool trans = true;

class MyApp extends StatefulWidget {
  final dynamic jsonData;
  final SharedPreferences sharedPreferences;

  const MyApp({Key? key, this.jsonData, required this.sharedPreferences})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  MyThemeModel(sharedPreferences: widget.sharedPreferences)),
                  ChangeNotifierProvider(
              create: (context) =>
                  MyThemeSettingsModel(sharedPreferences: widget.sharedPreferences)),
                  ChangeNotifierProvider(
              create: (context) =>
                  MyThemeModeModel(sharedPreferences: widget.sharedPreferences))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute:"/",
          title: "Oros",
          routes: {
            '/': (context) => kIsWeb?MyHomePage(jsonData: widget.jsonData): SplashScreen(jsonData: widget.jsonData),
            '/home': (context) => MyHomePages(jsonData: widget.jsonData),
            '/info': (context) => SubPage(jsonData: widget.jsonData),
            '/device': (context) => const InformationsPage(),
            '/about': (context) => const AboutPage(),
            '/apparence': (context) => const Apparence(),
          },
        ));
  }
}
