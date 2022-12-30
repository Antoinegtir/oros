// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:io';
import 'dart:ui';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:epitech/utilities/utility.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final darkmode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? const Color(0xfff2f2f6)
            : Colors.black;
    final lightmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.white
            : Colors.black;
    final darkmodes =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : const Color(0xff1c1c1e);
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
            tag: 'about',
            child: Text('About Oros',
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
          child: !Platform.isIOS
              ? ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, bottom: 20, top: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          width: 50,
                          height: 261,
                          color: darkmodes,
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                Utility.launchURL(
                                    "https://github.com/Antoinegtir");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 60,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              color: Color.fromARGB(
                                                  255, 60, 60, 60),
                                              child: Icon(
                                                FontAwesomeIcons.github,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Github',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                        ],
                                      ))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 0.2,
                                  color: Colors.grey,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Utility.launchURL(
                                    "https://www.instagram.com/antoine.gtier/");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 60,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              color: Colors.purpleAccent,
                                              child: Icon(
                                                FontAwesomeIcons.instagram,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Instagram',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                        ],
                                      ))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 0.2,
                                  color: Colors.grey,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Utility.launchURL(
                                    "https://www.linkedin.com/in/antoine-gonthier-029a32242");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 60,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              color: Colors.blue,
                                              child: Icon(
                                                FontAwesomeIcons.linkedin,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Linkedin',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                        ],
                                      ))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 0.2,
                                  color: Colors.grey,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // Utility.launchURL(
                                //     "https://kams-17c7d.web.app/#/");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 60,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              color: Color(0xff65c466),
                                              child: Icon(
                                                FontAwesomeIcons.globeAmericas,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Blog',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                        ],
                                      ))),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Author Page",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                )
              : ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, bottom: 20, top: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 50,
                          height: 201,
                          color: darkmodes,
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                Utility.launchURL(
                                    "${'https://github.com/Antoinegtir'}");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 50,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              width: 27,
                                              height: 27,
                                              color: Color.fromARGB(
                                                  255, 60, 60, 60),
                                              child: Icon(
                                                FontAwesomeIcons.github,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Github',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, left: 211),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color: Colors.grey,
                                              ))
                                        ],
                                      ))),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 0.2,
                                  color: darkmodes,
                                  width: MediaQuery.of(context).size.width / 7,
                                ),
                                Container(
                                  height: 0.2,
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width / 1,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Utility.launchURL(
                                    "https://www.instagram.com/antoine.gtier/");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 50,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              width: 27,
                                              height: 27,
                                              color: Colors.purpleAccent,
                                              child: Icon(
                                                FontAwesomeIcons.instagram,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Instagram',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, left: 182),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color: Colors.grey,
                                              ))
                                        ],
                                      ))),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 0.2,
                                  color: darkmodes,
                                  width: MediaQuery.of(context).size.width / 7,
                                ),
                                Container(
                                  height: 0.2,
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width / 1,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Utility.launchURL(
                                    "https://www.linkedin.com/in/antoine-gonthier-029a32242");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 50,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              width: 27,
                                              height: 27,
                                              color: Colors.blue,
                                              child: Icon(
                                                FontAwesomeIcons.linkedin,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Linkedin',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, left: 197),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color: Colors.grey,
                                              ))
                                        ],
                                      ))),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 0.2,
                                  color: darkmodes,
                                  width: MediaQuery.of(context).size.width / 7,
                                ),
                                Container(
                                  height: 0.2,
                                  color: Colors.grey,
                                  width: MediaQuery.of(context).size.width / 1,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // Utility.launchURL(
                                //     "https://kams-17c7d.web.app/#/");
                              },
                              child: Container(
                                  color: darkmodes,
                                  width: 500,
                                  height: 50,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              width: 27,
                                              height: 27,
                                              color: Color(0xff65c466),
                                              child: Icon(
                                                FontAwesomeIcons.globeAmericas,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12),
                                              child: Text(
                                                'Blog',
                                                style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                    color: lightmode),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, left: 229),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                                color: Colors.grey,
                                              ))
                                        ],
                                      ))),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Author Page",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
        ));
  }
}
