// ignore_for_file: file_names
import 'dart:io';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:epitech/animation/animation.dart';
import 'package:epitech/main.dart';
import 'package:epitech/model/localData.dart';
import 'package:epitech/srcs/ListScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../utilities/utility.dart';

class MyHomePages extends StatefulWidget {
  final dynamic jsonData;
  const MyHomePages({Key? key, this.jsonData}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePagesState createState() => _MyHomePagesState();
}

class _MyHomePagesState extends State<MyHomePages> {
  int _current = 0;

  void openBottomSheet(
    BuildContext context,
    double height,
    Widget child,
  ) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: child,
                )));
      },
    );
  }

  Future<bool> escape() async {
    return true;
  }

  bool isHeart = true;

  void openDarkModeSettings(BuildContext context) {
    openBottomSheet(
      context,
      1000,
      Consumer2<MyThemeModeModel, MyThemeSettingsModel>(
          builder: (context, mode, settings, child) {
        final lightmode = settings.isSettingsTheme == true
            ? MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.black
                : Colors.white
            : mode.isModeTheme == true
                ? Colors.black
                : Colors.white;

        final darkmodes = settings.isSettingsTheme == true
            ? MediaQuery.of(context).platformBrightness == Brightness.dark
                ? const Color(0xff1c1c1e)
                : Colors.white
            : mode.isModeTheme == false
                ? const Color(0xff1c1c1e)
                : Colors.white;
        return ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: MediaQuery.of(context).size.width / 2.3),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: Colors.grey,
                      height: 5,
                      width: 10,
                    ))),
            !Platform.isIOS
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                color: lightmode,
                                fontWeight: FontWeight.w200,
                                fontSize: 35),
                          ))
                    ],
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          color: lightmode,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    )),
            !Platform.isIOS
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                            width: 50,
                            color: darkmodes,
                            child: Column(children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/apparence',
                                    );
                                  },
                                  child: Container(
                                    color: darkmodes,
                                    width: 500,
                                    height: 70,
                                    child: Row(children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        color: Colors.blue,
                                                        child: const Icon(
                                                          Icons.color_lens,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Text(
                                                    "Apparence",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: lightmode,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                            ],
                                          )),
                                    ]),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 0.2,
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width /
                                        1.31,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 0.2,
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width /
                                        1.31,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/about',
                                    );
                                  },
                                  child: Container(
                                    color: darkmodes,
                                    width: 500,
                                    height: 70,
                                    child: Row(children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 0, 224, 30),
                                                        child: const Icon(
                                                          Icons.info,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12),
                                                child: Text(
                                                  "About",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: lightmode,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontFamily: 'Outfit',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ]),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 0.2,
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width /
                                        1.31,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    showLicensePage(
                                      context: context,
                                      applicationName: 'Oros',
                                      applicationVersion: '1.0.0',
                                      useRootNavigator: true,
                                    );
                                  },
                                  child: Container(
                                      color: darkmodes,
                                      width: 500,
                                      height: 70,
                                      child: Row(children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          color: Colors.red,
                                                          child: const Icon(
                                                            Icons.book,
                                                            color: Colors.white,
                                                            size: 25,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Text(
                                                    "License",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: lightmode,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ])))
                            ]))))
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                            width: 50,
                            height: 181,
                            color: darkmodes,
                            child: Column(children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/apparence',
                                    );
                                  },
                                  child: Container(
                                    color: darkmodes,
                                    width: 500,
                                    height: 60,
                                    child: Row(children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        color: Colors.blue,
                                                        child: const Icon(
                                                          Icons.color_lens,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Text(
                                                    "Apparence",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: lightmode,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                            ],
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.35,
                                      ),
                                      Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                Color.fromARGB(255, 92, 92, 92),
                                            size: 15,
                                          )
                                        ],
                                      )
                                    ]),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 0.2,
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width /
                                        1.31,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 0.2,
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width /
                                        1.31,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '/about',
                                    );
                                  },
                                  child: Container(
                                    color: darkmodes,
                                    width: 500,
                                    height: 60,
                                    child: Row(children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 0, 224, 30),
                                                        child: const Icon(
                                                          Icons.info,
                                                          color: Colors.white,
                                                          size: 25,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12),
                                                child: Hero(
                                                  tag: 'About',
                                                  child: Text(
                                                    "About",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: lightmode,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.93,
                                      ),
                                      Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                Color.fromARGB(255, 92, 92, 92),
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ]),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 0.2,
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width /
                                        1.31,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    showLicensePage(
                                      context: context,
                                      applicationName: 'Oros',
                                      applicationVersion: '1.0.0',
                                      useRootNavigator: true,
                                    );
                                  },
                                  child: Container(
                                      color: darkmodes,
                                      width: 500,
                                      height: 60,
                                      child: Row(children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          color: Colors.red,
                                                          child: const Icon(
                                                            Icons.book,
                                                            color: Colors.white,
                                                            size: 25,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Text(
                                                    "License",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: lightmode,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.06,
                                        ),
                                        Row(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color.fromARGB(
                                                  255, 92, 92, 92),
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ])))
                            ]))))
          ],
        );
      }),
    );
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
    final CarouselController _carouselController = CarouselController();
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("HH':'mm");
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
              'oros_tags': '${activity['oros_tags']}',
              'status': '0',
              'icon': '0'
            });
            foundActivity = true;
            break;
          }
          if (activity['start_at'] > now.millisecondsSinceEpoch) {
           activity['activity_title'].toString().contains("Matheo") 
                    ? rooms
                    : rooms.add({
                        'name': element['name'],
                        'activity':
                            "Libre jusqu'à: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activity['start_at']).subtract(sub))}",
                        'activity_title':
                            'Bientôt : ${activity['activity_title']}',
                        'module_title': '${activity['module_title']}',
                        'module_code': '${activity['module_code']}',
                        'type': '${activity['type']}',
                        'oros_tags': '${activity['oros_tags']}',
                        'status': '1',
                        'icon': activity['oros_tags'].toString() == "[]"
                            ? "2"
                            : "3",
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
          'icon': '1',
          'type': ''
        });
      }
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
      final url = rooms[_current]['name'].toString().toLowerCase();
      return WillPopScope(
          onWillPop: () {
            return escape();
          },
          child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              AwesomePageRoute(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  exitPage: widget,
                                  enterPage: MyHomePage(
                                    jsonData: sortedData,
                                  ),
                                  transition: ZoomOutSlideTransition()));
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.menu,
                              color: darkmode,
                              size: 30,
                            )))
                  ],
                  leading: kIsWeb
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            openDarkModeSettings(context);
                          },
                          child: Icon(
                            Icons.settings,
                            color: darkmode,
                            size: 30,
                          ))),
              backgroundColor: lightmode,
              body: FadeInDown(
                duration: const Duration(microseconds: 100),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      SizedBox(
                          height: 500,
                          width: MediaQuery.of(context).size.width / 1,
                          child: Hero(
                              tag: rooms[_current]['name']!.toLowerCase(),
                              child: CachedNetworkImage(
                                  placeholderFadeInDuration:
                                      const Duration(milliseconds: 50),
                                  imageUrl:
                                      "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/room%2F$url.png?alt=media&token=f19ff22d-8956-4137-8a0c-dc747c9c3bf3",
                                  fit: BoxFit.cover))),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                lightmode.withOpacity(1),
                                lightmode.withOpacity(1),
                                lightmode.withOpacity(1),
                                lightmode.withOpacity(1),
                                lightmode.withOpacity(0.0),
                                lightmode.withOpacity(0.0),
                                lightmode.withOpacity(0.0),
                                lightmode.withOpacity(0.0),
                              ])),
                        ),
                      ),
                      Consumer<MyThemeModel>(
                          builder: (context, theme, child) => Positioned(
                                bottom: 0,
                                height: MediaQuery.of(context).size.width / 1 >
                                        MediaQuery.of(context).size.height / 1
                                    ? MediaQuery.of(context).size.height * 0.9
                                    : MediaQuery.of(context).size.height *
                                        0.775,
                                width: MediaQuery.of(context).size.width,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay:
                                        theme.isAnimated == true ? true : false,
                                    height: MediaQuery.of(context).size.height /
                                        0.5,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    aspectRatio: 16 / 9,
                                    viewportFraction:
                                        MediaQuery.of(context).size.width / 1 >
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1
                                            ? 0.6
                                            : 0.70,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    },
                                  ),
                                  carouselController: _carouselController,
                                  items: rooms.map((movie) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        int index = rooms.indexOf(movie);
                                        final urls = rooms[index]['name']
                                            .toString()
                                            .toLowerCase();
                                        return AnimatedOpacity(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            opacity: trans ? 1.0 : 0.0,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 30, sigmaY: 30),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  2.5,
                                                              margin: EdgeInsets.only(
                                                                  top: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      30,
                                                                  left: 10,
                                                                  right: 10),
                                                              clipBehavior:
                                                                  Clip.hardEdge,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child:
                                                                  AnimatedOpacity(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              1000),
                                                                      opacity: _current ==
                                                                              rooms.indexOf(movie)
                                                                          ? 1.0
                                                                          : 0.5,
                                                                      child: GestureDetector(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              trans = false;
                                                                            });
                                                                            Navigator.of(context).pushNamed('/info', arguments: {
                                                                              'name': sortedData[index]['name'],
                                                                              'index': _current,
                                                                              'trans': trans,
                                                                            });
                                                                          },
                                                                          child: Hero(tag: rooms[index]['name'], child: CachedNetworkImage(placeholderFadeInDuration: const Duration(milliseconds: 50), imageUrl: "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/room%2F$urls.png?alt=media&token=f19ff22d-8956-4137-8a0c-dc747c9c3bf3", fit: BoxFit.cover))))),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${rooms[rooms.indexOf(movie)]['name'] == "Hub Innovation" ? "Hub Innov'" : rooms[rooms.indexOf(movie)]['name']}",
                                                                style: TextStyle(
                                                                    color:
                                                                        darkmode,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child: Container(
                                                                      child: rooms[index]['icon'] == "3" ? Image.asset("assets/dalll.png") : SizedBox.shrink(),
                                                                      height: MediaQuery.of(context).size.width / 20,
                                                                      width: MediaQuery.of(context).size.width / 20,
                                                                      color: rooms[index]['icon'] == "2"
                                                                          ? Color.fromARGB(255, 255, 255, 0)
                                                                          : rooms[index]['icon'] == "0"
                                                                              ? const Color.fromARGB(255, 255, 0, 0)
                                                                              : const Color.fromRGBO(0, 255, 8, 1)))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Shimmer
                                                                  .fromColors(
                                                                      period: const Duration(
                                                                          seconds:
                                                                              5),
                                                                      baseColor: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          152,
                                                                          171,
                                                                          180),
                                                                      highlightColor:
                                                                          darkmode,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(500),
                                                                        child:
                                                                            Text(
                                                                          "${rooms[index]['activity']}",
                                                                          style: TextStyle(
                                                                              color: darkmode,
                                                                              fontSize: MediaQuery.of(context).size.width / 35,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          AnimatedOpacity(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            opacity: _current ==
                                                                    rooms.indexOf(
                                                                        movie)
                                                                ? 1.0
                                                                : 0.0,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                rooms[index]['activity_title']
                                                                            .toString() ==
                                                                        ""
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            trans =
                                                                                false;
                                                                          });
                                                                          Navigator.of(context).pushNamed(
                                                                              '/info',
                                                                              arguments: {
                                                                                'name': sortedData[index]['name'],
                                                                                'index': _current,
                                                                              });
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .info,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600,
                                                                          size: MediaQuery.of(context).size.width /
                                                                              40,
                                                                        ))
                                                                    // ignore: prefer_const_constructors
                                                                    : SizedBox
                                                                        .shrink(),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                rooms[index]['activity_title']
                                                                            .toString() ==
                                                                        ""
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            trans =
                                                                                false;
                                                                          });
                                                                          Navigator.of(context).pushNamed(
                                                                              '/info',
                                                                              arguments: {
                                                                                'name': sortedData[index]['name'],
                                                                                'index': _current,
                                                                              });
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "info",
                                                                          style: TextStyle(
                                                                              fontSize: 14.0,
                                                                              color: Color.fromARGB(255, 117, 117, 117)),
                                                                        ))
                                                                    : const SizedBox
                                                                        .shrink(),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                rooms[index]['activity_title']
                                                                            .toString() !=
                                                                        ""
                                                                    ? Icon(
                                                                        Icons
                                                                            .access_time,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        size: MediaQuery.of(context).size.width /
                                                                            40,
                                                                      )
                                                                    : const SizedBox
                                                                        .shrink(),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "${rooms[index]['activity_title']}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.0,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ))));
                                      },
                                    );
                                  }).toList(),
                                ),
                              )),
                    ],
                  ),
                ),
              )));
    });
  }
}
