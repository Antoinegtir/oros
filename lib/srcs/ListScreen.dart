// ignore_for_file: file_names, prefer_const_constructors

import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:epitech/main.dart';
import 'package:epitech/model/localData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../utilities/utility.dart';

class MyHomePage extends StatefulWidget {
  final dynamic jsonData;
  const MyHomePage({Key? key, this.jsonData}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (trans == false) {
      Future.delayed(const Duration(seconds: 2)).then((trans) {
        setState(() {
          trans = true;
        });
      });
    }

    // ignore: no_leading_underscores_for_local_identifiers
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("HH'h'mm");
    Duration sub = const Duration(hours: 1);

    List<Map<String, dynamic>> rooms = [];
    List<Map<String, dynamic>> libreItems = [];
    List<Map<String, dynamic>> nonLibreItems = [];

    for (int i = 0; i < widget.jsonData.length; i++) {
      if (widget.jsonData[i]['activities'].toString() == "[]" ||
          widget.jsonData[i]['activities'] == null) {
        libreItems.add(widget.jsonData[i]);
      } else {
        nonLibreItems.add(widget.jsonData[i]);
      }
    }
    libreItems.sort((a, b) => a['name'].length.compareTo(b['name'].length));
    nonLibreItems.sort((a, b) => a['name'].length.compareTo(b['name'].length));

    List<Map<String, dynamic>> sortedData = libreItems + nonLibreItems;

    for (Map<String, dynamic> element in sortedData) {
      bool foundActivity = false;
      if (element['activities'].length > 0) {
        for (Map<String, dynamic> activity in element['activities']) {
          if (DateTime.fromMillisecondsSinceEpoch(activity['end_at'])
                      .subtract(sub)
                      .millisecondsSinceEpoch >
                  now.millisecondsSinceEpoch &&
              DateTime.fromMillisecondsSinceEpoch(activity['start_at'])
                      .subtract(sub)
                      .millisecondsSinceEpoch <
                  now.millisecondsSinceEpoch) {
            rooms.add({
              'name': element['name'],
              'activity':
                  "Occupé jusqu'à: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activity['end_at']).subtract(sub))}",
              'activity_title': 'En cours : ${activity['activity_title']}',
              'module_title': '${activity['module_title']}',
              'module_code': '${activity['module_code']}',
              'type': '${activity['type']}',
              'status': '0',
              'icon': '0'
            });
            foundActivity = true;
            break;
          }
          if (activity['end_at'] > now.millisecondsSinceEpoch) {
            rooms.add({
              'name': element['name'],
              'activity':
                  "Libre jusqu'à: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activity['start_at']).subtract(sub))}",
              'activity_title': 'Bientôt : ${activity['activity_title']}',
              'module_title': '${activity['module_title']}',
              'module_code': '${activity['module_code']}',
              'type': '${activity['type']}',
              'status': '1',
              'icon': '1'
            });
            foundActivity = true;
            break;
          }
        }
      }
      if (!foundActivity) {
        rooms.add({
          'name': element['name'],
          'activity': "Libre jusqu'à la fin de la journée",
          'activity_title': '',
          'module_title': '',
          'module_code': '',
          'status': '1',
          'icon': '2',
          'type': ''
        });
      }
    }
    bool isweb = true;
    downLoad(url) {
      AnchorElement anchorElement = new AnchorElement(href: url);
      anchorElement.download = "Oros.exe";
      anchorElement.click();
    }

    return Consumer2<MyThemeModeModel, MyThemeSettingsModel>(
        builder: (context, mode, settings, child) {
      final lightmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == false
              ? Colors.black
              : Colors.white;

      final darkmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == true
              ? Colors.black
              : Colors.white;
      final lightmodes = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == false
              ? Colors.white
              : Colors.black;
      return Scaffold(
          backgroundColor: lightmode,
          body: Row(
            children: [
              isweb
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(31),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(31),
                      ),
                      child: Container(
                        color: settings.isSettingsTheme == true
                            ? MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? Colors.white
                                : Color(0xff1c1c1e)
                            : mode.isModeTheme == true
                                ? Colors.white
                                : Color(0xff1c1c1e),
                        height: 550,
                        width: 100,
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Utility.launchURL(
                                      "https://play.google.com/store/apps/details?id=com.oros.epitech");
                                },
                                child: Icon(
                                  FontAwesomeIcons.googlePlay,
                                  size: 40,
                                  color: lightmodes,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Utility.launchURL(
                                      "https://play.google.com/store/apps/details?id=com.oros.epitech");
                                },
                                child: Text(
                                  "Android",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: lightmodes,
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Utility.launchURL(
                                      "https://apps.apple.com/us/app/oros/id1661996262");
                                },
                                child: Icon(
                                  FontAwesomeIcons.appStoreIos,
                                  size: 40,
                                  color: lightmodes,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Utility.launchURL(
                                      "https://apps.apple.com/us/app/oros/id1661996262");
                                },
                                child: Text(
                                  "iOS, MacOS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: lightmodes,
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isweb = false;
                                  });
                                },
                                child: Icon(
                                  FontAwesomeIcons.globeAmericas,
                                  size: 40,
                                  color: lightmodes,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isweb = false;
                                  });
                                },
                                child: Text(
                                  "Web",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: lightmodes,
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  downLoad("/assets/Oros.exe");
                                },
                                child: Icon(
                                  FontAwesomeIcons.microsoft,
                                  size: 40,
                                  color: lightmodes,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  downLoad("/assets/Oros.exe");
                                },
                                child: Text(
                                  "Windows",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: lightmodes,
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Utility.launchURL(
                                      "https://github.com/Antoinegtir/Oros");
                                },
                                child: Icon(
                                  FontAwesomeIcons.github,
                                  size: 40,
                                  color: lightmodes,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Utility.launchURL(
                                      "https://github.com/Antoinegtir/Oros");
                                },
                                child: Text(
                                  "Repo",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: lightmodes,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Expanded(
                  child: ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      trans = false;
                                    });
                                    Navigator.of(context)
                                        .pushNamed('/info', arguments: {
                                      'name': sortedData[index]['name'],
                                      'index': index,
                                      'trans': trans,
                                    });
                                  },
                                  child: Hero(
                                      tag: rooms[index]['name'],
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            "assets/rooms/${rooms[index]['name'].toLowerCase()}.png",
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 250,
                                          )))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Text(
                                        "${rooms[index]['name'] == "Hub Innovation" ? "Hub Innov'" : rooms[index]['name']}",
                                        style: TextStyle(
                                            color: darkmode,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Shimmer.fromColors(
                                      period: const Duration(seconds: 5),
                                      baseColor: const Color.fromARGB(
                                          255, 152, 171, 180),
                                      highlightColor: darkmode,
                                      child: Text(
                                        "${rooms[index]['activity']}",
                                        style: TextStyle(
                                            color: darkmode,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                55,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          color: rooms[index]['icon'] == "0"
                                              ? const Color.fromARGB(
                                                  255, 255, 0, 0)
                                              : const Color.fromRGBO(
                                                  0, 255, 8, 1)))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${rooms[index]['activity_title']}",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey.shade600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ))))
            ],
          ));
    });
  }
}
