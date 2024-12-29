import 'package:epitech/model/floor.module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

double dh(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double dw(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

Widget sh(double height) {
  return Container(height: height);
}

Widget sw(double width) {
  return Container(width: width);
}

List<FloorModel> floors = [];

String urlApi(String formattedDate) {
  return '${kIsWeb? "https://oros.vercel.app/api" : "https://api.oros.dahobul.com"}/rooms-activities?from=$formattedDate&to=$formattedDate';
}
