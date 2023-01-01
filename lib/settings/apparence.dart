// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations
import 'dart:io';
import 'dart:ui';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:epitech/model/localData.dart';
import 'package:epitech/utilities/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Apparence extends StatefulWidget {
  const Apparence({Key? key}) : super(key: key);

  @override
  State<Apparence> createState() => _ApparenceState();
}

class _ApparenceState extends State<Apparence> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MyThemeModeModel, MyThemeSettingsModel>(
        builder: (context, mode, settings, child) {
      final darkmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.light
              ? Color(0xfff2f2f6)
              : Colors.black
          : mode.isModeTheme == true
              ? Color(0xfff2f2f6)
              : Colors.black;

      final lightmode = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.black
              : Colors.white
          : mode.isModeTheme == false
              ? Colors.white
              : Colors.black;

      final darkmodes = settings.isSettingsTheme == true
          ? MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Color(0xff1c1c1e)
          : mode.isModeTheme == true
              ? Colors.white
              : Color(0xff1c1c1e);
      return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: darkmode,
          appBar: AppBar(
            elevation: 0,
            flexibleSpace: ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                      width: MediaQuery.of(context).size.width / 1,
                      height: 200,
                    ))),
            leading: const BackButton(color: Colors.blue),
            backgroundColor: Colors.transparent,
            centerTitle: false,
            title: const Hero(
              tag: 'apparence',
              child: Text('Apparence Oros',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                      decoration: TextDecoration.none,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500)),
            ),
          ),
          body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                setState(() {
                  Navigator.pop(context);
                });
              }
            },
            child: Platform.isIOS
                ? ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: <Widget>[
                      Consumer2<MyThemeModeModel, MyThemeSettingsModel>(
                          builder: (context, mode, settings, child) => Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 0, top: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 50,
                                    height: 251,
                                    color: settings.isSettingsTheme == true
                                        ? MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Color(0xff1c1c1e)
                                        : mode.isModeTheme == true
                                            ? Colors.white
                                            : Color(0xff1c1c1e),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          color: settings.isSettingsTheme ==
                                                  true
                                              ? MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Color(0xff1c1c1e)
                                              : mode.isModeTheme == true
                                                  ? Colors.white
                                                  : Color(0xff1c1c1e),
                                          width: 500,
                                          height: 50,
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      color: Colors.blue,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        child: Icon(
                                                          Icons
                                                              .play_circle_fill_rounded,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        'AutoPlay',
                                                        style: TextStyle(
                                                          fontFamily: 'Outfit',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 17,
                                                          color: settings
                                                                      .isSettingsTheme ==
                                                                  true
                                                              ? MediaQuery.of(context)
                                                                          .platformBrightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? Colors.white
                                                                  : Colors.black
                                                              : mode.isModeTheme ==
                                                                      false
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      )),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.55,
                                                  ),
                                                  Consumer<MyThemeModel>(
                                                      builder: (context, theme,
                                                              child) =>
                                                          CupertinoSwitch(
                                                              value:
                                                                  theme.isAnimated ==
                                                                          true
                                                                      ? true
                                                                      : false,
                                                              onChanged:
                                                                  ((value) {
                                                                theme
                                                                    .changeTheme();
                                                              })))
                                                ],
                                              )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 0.2,
                                              color: Colors.grey,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.25,
                                            ),
                                          ],
                                        ),
                                        Container(
                                            color: settings.isSettingsTheme ==
                                                    true
                                                ? MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : Color(0xff1c1c1e)
                                                : mode.isModeTheme == true
                                                    ? Colors.white
                                                    : Color(0xff1c1c1e),
                                            width: 500,
                                            height: 60,
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        color: Colors.grey,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: Icon(
                                                            Icons.settings,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets
                                                                .only(left: 12),
                                                        child: Text(
                                                            'Settings mode',
                                                            style: TextStyle(
                                                                color: settings
                                                                            .isSettingsTheme ==
                                                                        true
                                                                    ? MediaQuery.of(context).platformBrightness ==
                                                                            Brightness
                                                                                .dark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black
                                                                    : mode.isModeTheme ==
                                                                            false
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 17))),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                left: 103),
                                                        child: Consumer2<
                                                                MyThemeSettingsModel,
                                                                MyThemeModeModel>(
                                                            builder: (context,
                                                                    settings,
                                                                    mode,
                                                                    child) =>
                                                                CupertinoSwitch(
                                                                    value: settings.isSettingsTheme ==
                                                                            true
                                                                        ? true
                                                                        : false,
                                                                    onChanged:
                                                                        (value) {
                                                                      settings
                                                                          .changeThemesSettings();
                                                                    }))),
                                                  ],
                                                ))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 0.2,
                                              color: Colors.grey,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.25,
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    color: settings
                                                                .isSettingsTheme ==
                                                            true
                                                        ? MediaQuery.of(context)
                                                                    .platformBrightness ==
                                                                Brightness.light
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e)
                                                        : mode.isModeTheme ==
                                                                true
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e),
                                                    width: 500,
                                                    height: 60,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child: Container(
                                                                width: 30,
                                                                height: 30,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        236,
                                                                        213,
                                                                        0),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  child: Icon(
                                                                    Icons
                                                                        .light_mode,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            12),
                                                                child: Text(
                                                                    'Lightmode',
                                                                    style: TextStyle(
                                                                        color: settings.isSettingsTheme == true
                                                                            ? MediaQuery.of(context).platformBrightness == Brightness.dark
                                                                                ? Colors.white
                                                                                : Colors.black
                                                                            : mode.isModeTheme == false
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                        fontFamily: 'Outfit',
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 17))),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 0,
                                                                        left:
                                                                            134),
                                                                child: CupertinoSwitch(
                                                                    value: mode.isModeTheme == true
                                                                        ? settings.isSettingsTheme == true
                                                                            ? false
                                                                            : true
                                                                        : false,
                                                                    onChanged: ((value) {
                                                                      setState(
                                                                          () {
                                                                        if (mode.isModeTheme !=
                                                                            true) {
                                                                          mode.changeThemesMode();
                                                                        }

                                                                        if (settings.isSettingsTheme ==
                                                                            true) {
                                                                          settings
                                                                              .changeThemesSettings();
                                                                        }
                                                                      });
                                                                    }))),
                                                          ],
                                                        ))),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 0.2,
                                                      color: Colors.grey,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.25,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    color: settings
                                                                .isSettingsTheme ==
                                                            true
                                                        ? MediaQuery.of(context)
                                                                    .platformBrightness ==
                                                                Brightness.light
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e)
                                                        : mode.isModeTheme ==
                                                                true
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e),
                                                    width: 500,
                                                    height: 60,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child: Container(
                                                                width: 30,
                                                                height: 30,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        16,
                                                                        11,
                                                                        112),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  child: Icon(
                                                                    Icons
                                                                        .dark_mode,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            12),
                                                                child: Text(
                                                                    'Darkmode',
                                                                    style: TextStyle(
                                                                        color: settings.isSettingsTheme == true
                                                                            ? MediaQuery.of(context).platformBrightness == Brightness.dark
                                                                                ? Colors.white
                                                                                : Colors.black
                                                                            : mode.isModeTheme == false
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                        fontFamily: 'Outfit',
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 17))),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 0,
                                                                        left:
                                                                            138),
                                                                child: CupertinoSwitch(
                                                                    value: mode.isModeTheme != true
                                                                        ? settings.isSettingsTheme == true
                                                                            ? false
                                                                            : true
                                                                        : false,
                                                                    onChanged: ((value) {
                                                                      setState(
                                                                          () {
                                                                        if (mode.isModeTheme ==
                                                                            true) {
                                                                          mode.changeThemesMode();
                                                                        }

                                                                        if (settings.isSettingsTheme ==
                                                                            true) {
                                                                          settings
                                                                              .changeThemesSettings();
                                                                        }
                                                                      });
                                                                    }))),
                                                          ],
                                                        ))),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ],
                  )
                : ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: <Widget>[
                      Consumer2<MyThemeModeModel, MyThemeSettingsModel>(
                          builder: (context, mode, settings, child) => Padding(
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, bottom: 0, top: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    width: 50,
                                    height: 251,
                                    color: settings.isSettingsTheme == true
                                        ? MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Color(0xff1c1c1e)
                                        : mode.isModeTheme == true
                                            ? Colors.white
                                            : Color(0xff1c1c1e),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          color: settings.isSettingsTheme ==
                                                  true
                                              ? MediaQuery.of(context)
                                                          .platformBrightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Color(0xff1c1c1e)
                                              : mode.isModeTheme == true
                                                  ? Colors.white
                                                  : Color(0xff1c1c1e),
                                          width: 500,
                                          height: 50,
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .play_circle_fill_rounded,
                                                    color: Colors.blue,
                                                    size: 25,
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        'AutoPlay',
                                                        style: TextStyle(
                                                          fontFamily: 'Outfit',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 17,
                                                          color: settings
                                                                      .isSettingsTheme ==
                                                                  true
                                                              ? MediaQuery.of(context)
                                                                          .platformBrightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? Colors.white
                                                                  : Colors.black
                                                              : mode.isModeTheme ==
                                                                      false
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      )),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.9,
                                                  ),
                                                  Consumer<MyThemeModel>(
                                                      builder: (context, theme,
                                                              child) =>
                                                          Switch(
                                                              value:
                                                                  theme.isAnimated ==
                                                                          true
                                                                      ? true
                                                                      : false,
                                                              onChanged:
                                                                  ((value) {
                                                                theme
                                                                    .changeTheme();
                                                              })))
                                                ],
                                              )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 0.2,
                                              color: Colors.grey,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                            ),
                                          ],
                                        ),
                                        Container(
                                            color: settings.isSettingsTheme ==
                                                    true
                                                ? MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : Color(0xff1c1c1e)
                                                : mode.isModeTheme == true
                                                    ? Colors.white
                                                    : Color(0xff1c1c1e),
                                            width: 500,
                                            height: 60,
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.settings,
                                                      color: Colors.grey,
                                                      size: 25,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets
                                                                .only(left: 12),
                                                        child: Text(
                                                            'Settings mode',
                                                            style: TextStyle(
                                                                color: settings
                                                                            .isSettingsTheme ==
                                                                        true
                                                                    ? MediaQuery.of(context).platformBrightness ==
                                                                            Brightness
                                                                                .dark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black
                                                                    : mode.isModeTheme ==
                                                                            false
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 17))),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                left: 83),
                                                        child: Consumer2<
                                                                MyThemeSettingsModel,
                                                                MyThemeModeModel>(
                                                            builder: (context,
                                                                    settings,
                                                                    mode,
                                                                    child) =>
                                                                Switch(
                                                                    value: settings.isSettingsTheme ==
                                                                            true
                                                                        ? true
                                                                        : false,
                                                                    onChanged:
                                                                        (value) {
                                                                      settings
                                                                          .changeThemesSettings();
                                                                    }))),
                                                  ],
                                                ))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 0.2,
                                              color: Colors.grey,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                    color: settings
                                                                .isSettingsTheme ==
                                                            true
                                                        ? MediaQuery.of(context)
                                                                    .platformBrightness ==
                                                                Brightness.light
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e)
                                                        : mode.isModeTheme ==
                                                                true
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e),
                                                    width: 500,
                                                    height: 60,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.light_mode,
                                                              color: settings
                                                                          .isSettingsTheme ==
                                                                      true
                                                                  ? MediaQuery.of(context)
                                                                              .platformBrightness ==
                                                                          Brightness
                                                                              .dark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black
                                                                  : mode.isModeTheme ==
                                                                          false
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                              size: 25,
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            12),
                                                                child: Text(
                                                                    'Lightmode',
                                                                    style: TextStyle(
                                                                        color: settings.isSettingsTheme == true
                                                                            ? MediaQuery.of(context).platformBrightness == Brightness.dark
                                                                                ? Colors.white
                                                                                : Colors.black
                                                                            : mode.isModeTheme == false
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                        fontFamily: 'Outfit',
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 17))),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 0,
                                                                        left:
                                                                            118),
                                                                child: Switch(
                                                                    value: mode.isModeTheme ==
                                                                            true
                                                                        ? settings.isSettingsTheme ==
                                                                                true
                                                                            ? false
                                                                            : true
                                                                        : false,
                                                                    onChanged:
                                                                        ((value) {
                                                                      setState(
                                                                          () {
                                                                        if (mode.isModeTheme !=
                                                                            true) {
                                                                          mode.changeThemesMode();
                                                                        }

                                                                        if (settings.isSettingsTheme ==
                                                                            true) {
                                                                          settings
                                                                              .changeThemesSettings();
                                                                        }
                                                                      });
                                                                    }))),
                                                          ],
                                                        ))),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 0.2,
                                                      color: Colors.grey,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    color: settings
                                                                .isSettingsTheme ==
                                                            true
                                                        ? MediaQuery.of(context)
                                                                    .platformBrightness ==
                                                                Brightness.light
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e)
                                                        : mode.isModeTheme ==
                                                                true
                                                            ? Colors.white
                                                            : Color(0xff1c1c1e),
                                                    width: 500,
                                                    height: 60,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 30),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.dark_mode,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      16,
                                                                      11,
                                                                      112),
                                                              size: 25,
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            12),
                                                                child: Text(
                                                                    'Darkmode',
                                                                    style: TextStyle(
                                                                        color: settings.isSettingsTheme == true
                                                                            ? MediaQuery.of(context).platformBrightness == Brightness.dark
                                                                                ? Colors.white
                                                                                : Colors.black
                                                                            : mode.isModeTheme == false
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                        fontFamily: 'Outfit',
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 17))),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 0,
                                                                        left:
                                                                            120),
                                                                child: Switch(
                                                                    value: mode.isModeTheme !=
                                                                            true
                                                                        ? settings.isSettingsTheme ==
                                                                                true
                                                                            ? false
                                                                            : true
                                                                        : false,
                                                                    onChanged:
                                                                        ((value) {
                                                                      setState(
                                                                          () {
                                                                        if (mode.isModeTheme ==
                                                                            true) {
                                                                          mode.changeThemesMode();
                                                                        }

                                                                        if (settings.isSettingsTheme ==
                                                                            true) {
                                                                          settings
                                                                              .changeThemesSettings();
                                                                        }
                                                                      });
                                                                    }))),
                                                          ],
                                                        ))),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ],
                  ),
          ));
    });
  }
}
