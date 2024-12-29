import 'dart:convert';
import 'package:epitech/constants/constants.dart';
import 'package:epitech/pages/HomePage.dart';
import 'package:epitech/pages/RoomPage.dart';
import 'package:epitech/services/getFloorData.service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat("YYYY-MM-DD");
  String formattedDate = dateFormat.format(now);
  setPathUrlStrategy();
  final url = Uri.parse(urlApi(formattedDate));
  final response = await http.get(url);
  final Map<String, dynamic> jsonData = json.decode(response.body);
  runApp(MyApp(jsonData: jsonData));
}

class MyApp extends StatefulWidget {
  final Map<String, dynamic> jsonData;

  const MyApp({super.key, required this.jsonData});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FloorDataService.getFloorData(widget.jsonData['data']['room_activities']);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      title: "Oros",
      routes: {
        '/': (context) => HomePage(),
        '/home': (context) => HomePage(),
        '/room': (context) => RoomPage(),
      },
    );
  }
}
