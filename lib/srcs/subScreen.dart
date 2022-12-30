// ignore_for_file: file_names

import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:epitech/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    final lightmode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : Colors.black;
    final darkmode =
        MediaQuery.of(context).platformBrightness != Brightness.light
            ? Colors.white
            : Colors.black;
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
    DateFormat dateFormat = DateFormat("HH'h'mm");

    return Scaffold(
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
              Navigator.of(context).pushNamed(
                '/home',
              );
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
                  Navigator.pop(context);
                });
              }
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
                        iconTheme: const IconThemeData(color: Colors.blue),
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
                            background:
                                Stack(fit: StackFit.expand, children: <Widget>[
                              Hero(
                                  tag: name.toLowerCase(),
                                  child: Image.asset(
                                      "assets/rooms/${name.toLowerCase()}.png",
                                      fit: BoxFit.cover)),
                              FadeInUp(
                                  duration: const Duration(seconds: 1),
                                  child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomRight,
                                              end: Alignment.topRight,
                                              colors: [
                                        lightmode.withOpacity(1),
                                        lightmode.withOpacity(1),
                                        lightmode.withOpacity(0.5),
                                        lightmode.withOpacity(0.0),
                                        lightmode.withOpacity(0.0),
                                        lightmode.withOpacity(0.0),
                                        lightmode.withOpacity(0.0),
                                        lightmode.withOpacity(0.0),
                                      ])))),
                            ]))),
                  ];
                },
                body: Column(
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
                      Container(
                        height: 20,
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: _tabController,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 20,
                              ),
                              activities.length == 0
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1,
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      child: Center(
                                          child: Text(
                                        "Aucune activitée\n dans cette salle\n n'a été identifié",
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: darkmode,
                                            fontWeight: FontWeight.w600),
                                      )))
                                  : const SizedBox.shrink(),
                              for (int i = 0; i < activities.length; i++)
                                Column(
                                  children: [
                                    Text(
                                      "${sortedData[index]['activities']}" !=
                                              "[]"
                                          ? ""
                                          : "${sortedData[index]['activities'][i]['activity_title']} : ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(sortedData[index]['activities'][i]['start_at']).subtract(sub))} - ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(sortedData[index]['activities'][i]['end_at']).subtract(sub))}",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: darkmode,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      "${sortedData[index]['activities']}" !=
                                              "[]"
                                          ? ""
                                          : "${sortedData[index]['activities'][i]['module_title']} , ${sortedData[index]['activities'][i]['module_code'] == 'null' ? "" : sortedData[index]['activities'][i]['module_code']} , ${sortedData[index]['activities'][i]['type'] == 'null' ? "" : sortedData[index]['activities'][i]['type']}",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: darkmode,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 5,
                                  right: MediaQuery.of(context).size.width / 5),
                              child: name == "Bourg Palette"
                                  ? Text('Paysage Bourg Palette est un lieu de la série de jeux vidéo Pokémon. C\'est une petite ville située dans la région de Kanto, et c\'est le lieu de départ du personnage du joueur dans la première génération de jeux Pokémon. Dans les jeux Pokémon, Paysage Bourg Palette est représenté comme une ville pittoresque et paisible entourée de champs herbeux et de forêts.',
                                      style: TextStyle(
                                          color: darkmode, fontSize: 20))
                                  : name == "Gallifrey"
                                      ? Text('Gallifrey City est une ville fictive située sur la planète Gallifrey dans l\'univers de Doctor Who. Elle est la capitale de la planète et est le lieu de résidence des Time Lords, une race extraterrestre dotée de la capacité de voyage dans le temps et de l\'espace. La ville est décrite comme étant très avancée technologiquement et comme possédant de nombreux bâtiments imposants et des rues bordées de jardins luxuriants. Elle est également connue pour ses écoles de formation pour les Time Lords et pour son Panoptique, le siège du gouvernement de Gallifrey.',
                                          style: TextStyle(
                                              color: darkmode, fontSize: 20))
                                      : name == "Mordor"
                                          ? Text('Mordor est décrit comme étant une région sombre et sinistre, remplie de montagnes noires et de forges où sont forgées les armes et les armures des orcs. C\'est également le lieu où se trouve le Mont Doom, un volcan actif au cœur de Mordor, et le siège du pouvoir de Sauron, le principal antagoniste de l\'histoire de "L\'Anneau Unique" de Tolkien',
                                              style: TextStyle(
                                                  color: darkmode,
                                                  fontSize: 20))
                                          : name == "Poudlard"
                                              ? Text('Poudlard est une école de magie située en Grande-Bretagne et qui accueille des élèves de la maternelle à la terminale. Elle a été fondée par Godric Gryffondor, Salazar Serpentard, Rowena Serdaigle et Helga Poufsouffle, quatre grands sorciers du Moyen Âge qui ont chacun donné leur nom à une maison de l\'école.',
                                                  style: TextStyle(
                                                      color: darkmode,
                                                      fontSize: 20))
                                              : name == "Comté"
                                                  ? Text('Le paysage du Comté, tel qu\'il est décrit dans "Le Seigneur des Anneaux" de J.R.R. Tolkien, est un lieu idyllique et paisible situé dans le milieu de la Terre du Milieu. C\'est là que se trouve la demeure de Bilbon Sacquet, le protagoniste de l\'histoire. Le Comté est un endroit verdoyant, avec de nombreux champs et vergers, ainsi que de petits villages et hameaux dispersés ici et là.',
                                                      style: TextStyle(
                                                          color: darkmode,
                                                          fontSize: 20))
                                                  : name == "Tatooine"
                                                      ? Text(
                                                          'Tatooine est un monde désertique situé dans la Bordure Extérieure de la galaxie. Il est connu pour être le lieu de naissance de Luke Skywalker, l\'un des héros de la Guerre des Étoiles. Le paysage de Tatooine est principalement composé de vastes étendues de sable, de dunes et de montagnes rocheuses. Le soleil y brille en permanence et la température peut atteindre des records de chaleur, ce qui rend la vie sur cette planète très difficile pour les habitants.',
                                                          style: TextStyle(
                                                              color: darkmode,
                                                              fontSize: 20))
                                                      : name == "Westeros"
                                                          ? Text(
                                                              'Westeros est un pays imaginaire créé par l\'auteur George R.R. Martin pour sa série de livres "Le Trône de Fer". Il est situé sur un continent fictif et se compose de neuf royaumes, chacun ayant sa propre culture et ses propres coutumes. Le paysage de Westeros est diversifié, allant des verts pâturages du Val à la désolation glacée du Mur. Il y a des montagnes, des forêts, des prairies, des marais et des côtes rocheuses.',
                                                              style: TextStyle(
                                                                  color: darkmode,
                                                                  fontSize: 20))
                                                          : name == "Vogons"
                                                              ? const Text('Le paysage de Vogons est caractérisé par des plaines désertiques et arides, parsemées de quelques collines rocheuses. La végétation est principalement composée de cactus et de buissons durs et résistants, adaptés aux conditions climatiques difficiles de cette région. La faune de Vogons est également très particulière, avec des espèces rares et endémiques comme le Vogon-ours, un animal robuste et agressif qui vit dans les montagnes et qui est réputé pour sa force et sa résistance.', style: TextStyle(color: Colors.white, fontSize: 20))
                                                              : name == "Hub Innovation"
                                                                  ? const Text('...', style: TextStyle(color: Colors.white, fontSize: 20))
                                                                  : name == "Torvalds"
                                                                      ? Text('Linus Torvalds est un informaticien finlandais connu pour avoir créé le noyau Linux, un système d\'exploitation libre et open source utilisé dans de nombreux ordinateurs et appareils de tous types. Torvalds est né en 1969 à Helsinki, en Finlande. Il a grandi dans une famille où l\'informatique et les technologies de l\'information étaient très présentes. Son père travaillait pour l\'université de Helsinki et avait installé un ordinateur personnel à la maison dès le début des années 1980. ', style: TextStyle(color: darkmode, fontSize: 20))
                                                                      : Text('Gotham City est une ville fictive du monde de l\'univers DC Comics. Elle est principalement connue comme étant la ville natale de Batman et comme le lieu où se déroulent la plupart de ses aventures. Gotham City est décrite comme étant une grande ville industrielle et cosmopolite, située sur la côte est des États-Unis. Selon les différentes versions de l\'histoire, elle peut être située dans n\'importe quel État de la côte est, mais elle est souvent associée à New York. La ville est connue pour être sombre et menaçante, avec une criminalité élevée et des quartiers défavorisés.', style: TextStyle(color: darkmode, fontSize: 20))),
                          SizedBox(
                              height: 500,
                              width: 500,
                              child: InteractiveViewer(
                                  maxScale: 10,
                                  child: Image.asset(
                                    "assets/plans/plan ${name.toLowerCase()}.png",
                                  )))
                        ],
                      ))
                    ]))));
  }
}
