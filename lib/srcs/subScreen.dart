// ignore_for_file: file_names
import 'dart:io';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epitech/main.dart';
import 'package:epitech/model/localData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubPage extends StatefulWidget {
  final dynamic jsonData;
  const SubPage({Key? key, this.jsonData}) : super(key: key);
  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> escape() async {
    setState(() {
      trans = true;
      Navigator.of(context).pop();
    });
    return trans;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String name = args['name'];
    final int index = args['index'];
    Duration sub = const Duration(hours: 1);
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
    var activities = sortedData[index]['activities'];
    DateFormat dateFormat = DateFormat("HH':'mm");
    final url = name.toLowerCase();
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

      final colors =
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Color.fromARGB(255, 50, 50, 50)
              : Colors.white;
      final colorss =
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Color.fromARGB(255, 57, 57, 57)
              : Colors.white;
      return WillPopScope(
          onWillPop: () {
            return escape();
          },
          child: Scaffold(
              backgroundColor: lightmode,
              appBar: AppBar(
                title: Text(
                  name,
                  style: TextStyle(color: darkmode),
                ),
                leading: BackButton(
                  onPressed: () {
                    setState(() {
                      trans = true;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 1,
                        ))),
              ),
              extendBodyBehindAppBar: true,
              body: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 0) {
                      setState(() {
                        trans = true;
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          trans = true;
                          Navigator.of(context).pop();
                        });
                      },
                      child: NestedScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          headerSliverBuilder: (context, value) {
                            return [
                              SliverAppBar(
                                  leading: const SizedBox.shrink(),
                                  pinned: true,
                                  backgroundColor: lightmode,
                                  iconTheme:
                                      const IconThemeData(color: Colors.blue),
                                  stretch: true,
                                  onStretchTrigger: () {
                                    // Function callback for stretch
                                    return Future<void>.value();
                                  },
                                  expandedHeight: 300.0,
                                  flexibleSpace: FlexibleSpaceBar(
                                      stretchModes: const <StretchMode>[
                                        StretchMode.zoomBackground,
                                        StretchMode.blurBackground,
                                        StretchMode.fadeTitle,
                                      ],
                                      centerTitle: true,
                                      background: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Hero(
                                                tag: name.toLowerCase(),
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/room%2F${name.toLowerCase()}.png?alt=media&token=f19ff22d-8956-4137-8a0c-dc747c9c3bf3",
                                                    fit: BoxFit.cover)),
                                            FadeInUp(
                                                duration:
                                                    const Duration(seconds: 1),
                                                child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .topRight,
                                                            colors: [
                                                      lightmode.withOpacity(1),
                                                      lightmode.withOpacity(1),
                                                      lightmode
                                                          .withOpacity(0.5),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                      lightmode
                                                          .withOpacity(0.0),
                                                    ])))),
                                          ]))),
                            ];
                          },
                          body: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                TabBar(
                                  isScrollable: false,
                                  labelColor: darkmode,
                                  unselectedLabelColor: Colors.grey.shade600,
                                  indicatorColor: lightmode,
                                  indicatorWeight: 1,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  controller: _tabController,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  tabs: [
                                    const Tab(
                                      icon: Icon(
                                        Icons.calendar_month,
                                        size: 25,
                                      ),
                                    ),
                                    const Tab(
                                      icon: Icon(
                                        Icons.book,
                                        size: 25.0,
                                      ),
                                    ),
                                    const Tab(
                                      icon: Icon(
                                        Icons.map_rounded,
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    ListView(
                                      children: [
                                        activities.length == 0
                                            ? SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1,
                                                child: Center(
                                                    child: Text(
                                                  "Aucune activitée\n dans cette salle\n n'a été identifiée",
                                                  style: TextStyle(
                                                      fontSize: 35,
                                                      color: darkmode,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )))
                                            : const SizedBox.shrink(),
                                        for (int i = 0;
                                            i < activities.length;
                                            i++)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30,
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.1,
                                                  decoration: BoxDecoration(
                                                      color: lightmode,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: darkmode,
                                                          width: 1)),
                                                  child: ListTile(
                                                    subtitle: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              Platform.isIOS
                                                                  ? showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              CupertinoAlertDialog(
                                                                                title: const Text("Information"),
                                                                                content: const Text("Seulement une petite partie de la salle est occupé vous pouvez donc vous y installé sans deranger 😊 "),
                                                                                actions: [
                                                                                  // ignore: deprecated_member_use
                                                                                  CupertinoDialogAction(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: const Text(
                                                                                      "D'accord!",
                                                                                      style: TextStyle(
                                                                                        color: Color.fromARGB(255, 25, 191, 0),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ))
                                                                  : showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              AlertDialog(
                                                                        contentPadding: EdgeInsets.only(
                                                                            right:
                                                                                50,
                                                                            left:
                                                                                50,
                                                                            top:
                                                                                20,
                                                                            bottom:
                                                                                20),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(40))),
                                                                        backgroundColor:
                                                                            colors,
                                                                        title:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "Info",
                                                                              style: TextStyle(color: colorss, fontSize: 30, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        content:
                                                                            Text(
                                                                          'Seulement une petite partie de la salle est occupé vous pouvez donc vous y installé sans deranger 😊 ',
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 198, 198, 198),
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w100),
                                                                        ),
                                                                        actions: [
                                                                          // ignore: deprecated_member_use

                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text("Confirm\n", style: TextStyle(color: colorss, fontWeight: FontWeight.w700, fontSize: 14))
                                                                                ],
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    );
                                                            },
                                                            child: Shimmer
                                                                .fromColors(
                                                              period:
                                                                  const Duration(
                                                                      seconds:
                                                                          5),
                                                              baseColor: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  50,
                                                                  255,
                                                                  18),
                                                              highlightColor:
                                                                  Colors.red,
                                                              child: Text(
                                                                  // ignore: prefer_if_null_operators
                                                                  "${sortedData[index]['activities'][i]['oros_tags'].toString() != "[]" ? "Partiellement occupé" : ""}\n ",
                                                                  style: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      color:
                                                                          darkmode,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                            )),
                                                        Text(
                                                          // ignore: prefer_if_null_operators
                                                          "${sortedData[index]['activities'][i]['module_title'] == null ? "" : sortedData[index]['activities'][i]['module_title']} , ${sortedData[index]['activities'][i]['module_code'] == null ? "" : sortedData[index]['activities'][i]['module_code']} , ${sortedData[index]['activities'][i]['type'] == null ? "" : sortedData[index]['activities'][i]['type']}\n",
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              color: darkmode,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100),
                                                        ),
                                                      ],
                                                    ),
                                                    title: Text(
                                                      "\n${sortedData[index]['activities'][i]['activity_title']} : ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(sortedData[index]['activities'][i]['start_at']).subtract(sub))} - ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(sortedData[index]['activities'][i]['end_at']).subtract(sub))}\n",
                                                      style: TextStyle(
                                                          overflow:
                                                              TextOverflow.clip,
                                                          color: darkmode,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ))
                                            ],
                                          )
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.width /
                                                5,
                                            right: MediaQuery.of(context).size.width /
                                                5),
                                        child: name == "Bourg Palette"
                                            ? Text('Paysage Bourg Palette est un lieu de la série de jeux vidéo Pokémon. C\'est une petite ville située dans la région de Kanto, et c\'est le lieu de départ du personnage du joueur dans la première génération de jeux Pokémon. Dans les jeux Pokémon, Paysage Bourg Palette est représenté comme une ville pittoresque et paisible entourée de champs herbeux et de forêts.',
                                                style: TextStyle(
                                                    color: darkmode,
                                                    fontSize: 20))
                                            : name == "Gallifrey"
                                                ? Text('Gallifrey City est une ville fictive située sur la planète Gallifrey dans l\'univers de Doctor Who. Elle est la capitale de la planète et est le lieu de résidence des Time Lords, une race extraterrestre dotée de la capacité de voyage dans le temps et de l\'espace. La ville est décrite comme étant très avancée technologiquement et comme possédant de nombreux bâtiments imposants et des rues bordées de jardins luxuriants. Elle est également connue pour ses écoles de formation pour les Time Lords et pour son Panoptique, le siège du gouvernement de Gallifrey.',
                                                    style: TextStyle(
                                                        color: darkmode,
                                                        fontSize: 20))
                                                : name == "Mordor"
                                                    ? Text('Mordor est décrit comme étant une région sombre et sinistre, remplie de montagnes noires et de forges où sont forgées les armes et les armures des orcs. C\'est également le lieu où se trouve le Mont Doom, un volcan actif au cœur de Mordor, et le siège du pouvoir de Sauron, le principal antagoniste de l\'histoire de "L\'Anneau Unique" de Tolkien',
                                                        style: TextStyle(
                                                            color: darkmode,
                                                            fontSize: 20))
                                                    : name == "Poudlard"
                                                        ? Text(
                                                            'Poudlard est une école de magie située en Grande-Bretagne et qui accueille des élèves de la maternelle à la terminale. Elle a été fondée par Godric Gryffondor, Salazar Serpentard, Rowena Serdaigle et Helga Poufsouffle, quatre grands sorciers du Moyen Âge qui ont chacun donné leur nom à une maison de l\'école.',
                                                            style: TextStyle(
                                                                color: darkmode,
                                                                fontSize: 20))
                                                        : name == "Comté"
                                                            ? Text(
                                                                'Le paysage du Comté, tel qu\'il est décrit dans "Le Seigneur des Anneaux" de J.R.R. Tolkien, est un lieu idyllique et paisible situé dans le milieu de la Terre du Milieu. C\'est là que se trouve la demeure de Bilbon Sacquet, le protagoniste de l\'histoire. Le Comté est un endroit verdoyant, avec de nombreux champs et vergers, ainsi que de petits villages et hameaux dispersés ici et là.',
                                                                style: TextStyle(color: darkmode, fontSize: 20))
                                                            : name == "Tatooine"
                                                                ? Text('Tatooine est un monde désertique situé dans la Bordure Extérieure de la galaxie. Il est connu pour être le lieu de naissance de Luke Skywalker, l\'un des héros de la Guerre des Étoiles. Le paysage de Tatooine est principalement composé de vastes étendues de sable, de dunes et de montagnes rocheuses. Le soleil y brille en permanence et la température peut atteindre des records de chaleur, ce qui rend la vie sur cette planète très difficile pour les habitants.', style: TextStyle(color: darkmode, fontSize: 20))
                                                                : name == "Westeros"
                                                                    ? Text('Westeros est un pays imaginaire créé par l\'auteur George R.R. Martin pour sa série de livres "Le Trône de Fer". Il est situé sur un continent fictif et se compose de neuf royaumes, chacun ayant sa propre culture et ses propres coutumes. Le paysage de Westeros est diversifié, allant des verts pâturages du Val à la désolation glacée du Mur. Il y a des montagnes, des forêts, des prairies, des marais et des côtes rocheuses.', style: TextStyle(color: darkmode, fontSize: 20))
                                                                    : name == "Vogons"
                                                                        ? const Text('Le paysage de Vogons est caractérisé par des plaines désertiques et arides, parsemées de quelques collines rocheuses. La végétation est principalement composée de cactus et de buissons durs et résistants, adaptés aux conditions climatiques difficiles de cette région. La faune de Vogons est également très particulière, avec des espèces rares et endémiques comme le Vogon-ours, un animal robuste et agressif qui vit dans les montagnes et qui est réputé pour sa force et sa résistance.', style: TextStyle(color: Colors.white, fontSize: 20))
                                                                        : name == "Hub Innovation"
                                                                            ? const Text('...', style: TextStyle(color: Colors.white, fontSize: 20))
                                                                            : name == "Torvalds"
                                                                                ? Text('Linus Torvalds est un informaticien finlandais connu pour avoir créé le noyau Linux, un système d\'exploitation libre et open source utilisé dans de nombreux ordinateurs et appareils de tous types. Torvalds est né en 1969 à Helsinki, en Finlande. Il a grandi dans une famille où l\'informatique et les technologies de l\'information étaient très présentes. Son père travaillait pour l\'université de Helsinki et avait installé un ordinateur personnel à la maison dès le début des années 1980. ', style: TextStyle(color: darkmode, fontSize: 20))
                                                                                : Text('Gotham City est une ville fictive du monde de l\'univers DC Comics. Elle est principalement connue comme étant la ville natale de Batman et comme le lieu où se déroulent la plupart de ses aventures. Gotham City est décrite comme étant une grande ville industrielle et cosmopolite, située sur la côte est des États-Unis. Selon les différentes versions de l\'histoire, elle peut être située dans n\'importe quel État de la côte est, mais elle est souvent associée à New York. La ville est connue pour être sombre et menaçante, avec une criminalité élevée et des quartiers défavorisés.', style: TextStyle(color: darkmode, fontSize: 20))),
                                    settings.isSettingsTheme == true
                                        ? MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.dark
                                            ? Container(
                                                color: Colors.transparent,
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/dark_plan%2F${url == "compté" ? "comté" : url}.png?alt=media&token=e6a8bc6e-48fa-4359-9483-3d7aff3c1560",
                                                    fit: BoxFit.contain))
                                            : Container(
                                                color: Colors.transparent,
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/light_plan%2F$url.png?alt=media&token=c8508f29-6d28-481f-bccf-30d01fc1f3fa",
                                                    fit: BoxFit.contain))
                                        : mode.isModeTheme == false
                                            ? Container(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/dark_plan%2F${url == "compté" ? "comté" : url}.png?alt=media&token=e6a8bc6e-48fa-4359-9483-3d7aff3c1560",
                                                    fit: BoxFit.contain))
                                            : Container(
                                                color: Colors.transparent,
                                                child: CachedNetworkImage(
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            milliseconds: 50),
                                                    imageUrl:
                                                        "https://firebasestorage.googleapis.com/v0/b/oros-f490a.appspot.com/o/light_plan%2F$url.png?alt=media&token=c8508f29-6d28-481f-bccf-30d01fc1f3fa",
                                                    fit: BoxFit.contain))
                                  ],
                                ))
                              ]))))));
    });
  }
}
