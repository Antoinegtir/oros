import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
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
  runApp(MyApp(jsonData: jsonData));
}

class MyApp extends StatefulWidget {
  final dynamic jsonData;

  const MyApp({Key? key, this.jsonData}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          '/info': (context) => const SubPage(),
        },
        home: MyHomePage(jsonData: widget.jsonData));
  }
}

bool trans = true;

class MyHomePage extends StatefulWidget {
  final dynamic jsonData;
  const MyHomePage({Key? key, this.jsonData}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _current = 0;
  @override
  void initState() {
    super.initState();
  }

  // final List<Map<String, dynamic>> widget.jsonData = [
  //   {
  //     "name": "Bourg Palette",
  //     "activities": [
  //       {
  //         "activity_title": "Cold Case 1 (-600)",
  //         "module_title": "B0 - English",
  //         "module_code": "B-ANG-001",
  //         "start_at": 1670835600000,
  //         "end_at": 1670839200000,
  //         "oros_tags": [],
  //         "type": "tp"
  //       },
  //       {
  //         "activity_title": "Cold Case 1 (-700)",
  //         "module_title": "B0 - English",
  //         "module_code": "B-ANG-001",
  //         "start_at": 1670839200000,
  //         "end_at": 1670842800000,
  //         "oros_tags": [],
  //         "type": "tp"
  //       },
  //       {
  //         "activity_title": "Augmenter sa motivation",
  //         "module_title": "B0 - PCP Development",
  //         "module_code": "B-PCP-000",
  //         "start_at": 1670855400000,
  //         "end_at": 1670866200000,
  //         "oros_tags": [],
  //         "type": "tp"
  //       }
  //     ]
  //   },
  //   {"name": "Gallifrey", "activities": []},
  //   {
  //     "name": "Gotham",
  //     "activities": [
  //       {
  //         "activity_title": "PréMSc",
  //         "start_at": 1670834700000,
  //         "end_at": 1670868000000,
  //         "oros_tags": []
  //       }
  //     ]
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final CarouselController _carouselController = CarouselController();
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

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
                height: 500,
                width: MediaQuery.of(context).size.width / 1,
                child: Hero(
                    tag: rooms[_current]['name']!.toLowerCase(),
                    child: Image.asset(
                        "assets/${rooms[_current]['name']!.toLowerCase()}.png",
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
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.0),
                    ])),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: trans ? 1.0 : 0.0,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: MediaQuery.of(context).size.height / 0.5,
                    autoPlayInterval: const Duration(seconds: 3),
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.70,
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
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.5,
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                              left: 10,
                                              right: 10),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: AnimatedOpacity(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              opacity: _current ==
                                                      rooms.indexOf(movie)
                                                  ? 1.0
                                                  : 0.5,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      trans = false;
                                                    });
                                                    Navigator.of(context)
                                                        .pushNamed('/info',
                                                            arguments: {
                                                          'name':
                                                              sortedData[index]
                                                                  ['name'],
                                                        });
                                                  },
                                                  child: Hero(
                                                      tag: rooms[index]['name'],
                                                      child: Image.asset(
                                                          "assets/${rooms[index]['name'].toLowerCase()}.png",
                                                          fit:
                                                              BoxFit.cover))))),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${rooms[rooms.indexOf(movie)]['name'] == "Hub Innovation" ? "Hub Innov'" : rooms[rooms.indexOf(movie)]['name']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                  color: rooms[index]['icon'] ==
                                                          "0"
                                                      ? const Color.fromARGB(
                                                          255, 255, 0, 0)
                                                      : const Color.fromRGBO(
                                                          0, 255, 8, 1)))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Shimmer.fromColors(
                                              period:
                                                  const Duration(seconds: 5),
                                              baseColor: const Color.fromARGB(
                                                  255, 152, 171, 180),
                                              highlightColor: Colors.white,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(500),
                                                child: Text(
                                                  "${rooms[index]['activity']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              35,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity:
                                            _current == rooms.indexOf(movie)
                                                ? 1.0
                                                : 0.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    trans = false;
                                                  });
                                                  Navigator.of(context)
                                                      .pushNamed('/info',
                                                          arguments: {
                                                        'name':
                                                            sortedData[index]
                                                                ['name'],
                                                        'activities':
                                                            sortedData[index]
                                                                ['activities'],
                                                      });
                                                },
                                                child: Icon(
                                                  Icons.info,
                                                  color: Colors.grey.shade600,
                                                  size: 20,
                                                )),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    trans = false;
                                                  });
                                                  Navigator.of(context)
                                                      .pushNamed('/info',
                                                          arguments: {
                                                        'name':
                                                            sortedData[index]
                                                                ['name'],
                                                      });
                                                },
                                                child: const Text(
                                                  "info",
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color.fromARGB(
                                                          255, 117, 117, 117)),
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            rooms[index]['activity_title']
                                                        .toString() !=
                                                    ""
                                                ? Icon(
                                                    Icons.access_time,
                                                    color: Colors.grey.shade600,
                                                    size: 20,
                                                  )
                                                : const SizedBox.shrink(),
                                            const SizedBox(width: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${rooms[index]['activity_title']}",
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          Colors.grey.shade600),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )));
                      },
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubPage extends StatefulWidget {
  const SubPage({super.key});

  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String name = args['name'];

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
          leading: BackButton(
            onPressed: () {
              setState(() {
                trans = true;
              });
              Navigator.pop(context);
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
        body: NestedScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                    leading: const SizedBox.shrink(),
                    pinned: true,
                    backgroundColor: Colors.black,
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
                                  "assets/${name.toLowerCase()}.png",
                                  fit: BoxFit.cover)),
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topRight,
                                      colors: [
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(0.5),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                              ]))),
                        ]))),
              ];
            },
            body: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    name == "Bourg Palette"
                        ? const Text(
                            'Paysage Bourg Palette est un lieu de la série de jeux vidéo Pokémon. C\'est une petite ville située dans la région de Kanto, et c\'est le lieu de départ du personnage du joueur dans la première génération de jeux Pokémon. Dans les jeux Pokémon, Paysage Bourg Palette est représenté comme une ville pittoresque et paisible entourée de champs herbeux et de forêts.',
                            style: TextStyle(color: Colors.white, fontSize: 20))
                        : name == "Gallifrey"
                            ? const Text(
                                'Gallifrey City est une ville fictive située sur la planète Gallifrey dans l\'univers de Doctor Who. Elle est la capitale de la planète et est le lieu de résidence des Time Lords, une race extraterrestre dotée de la capacité de voyage dans le temps et de l\'espace. La ville est décrite comme étant très avancée technologiquement et comme possédant de nombreux bâtiments imposants et des rues bordées de jardins luxuriants. Elle est également connue pour ses écoles de formation pour les Time Lords et pour son Panoptique, le siège du gouvernement de Gallifrey.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))
                            : name == "Mordor"
                                ? const Text(
                                    'Mordor est décrit comme étant une région sombre et sinistre, remplie de montagnes noires et de forges où sont forgées les armes et les armures des orcs. C\'est également le lieu où se trouve le Mont Doom, un volcan actif au cœur de Mordor, et le siège du pouvoir de Sauron, le principal antagoniste de l\'histoire de "L\'Anneau Unique" de Tolkien',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20))
                                : name == "Poudlard"
                                    ? const Text(
                                        'Poudlard est une école de magie située en Grande-Bretagne et qui accueille des élèves de la maternelle à la terminale. Elle a été fondée par Godric Gryffondor, Salazar Serpentard, Rowena Serdaigle et Helga Poufsouffle, quatre grands sorcier du Moyen Âge qui ont chacun donné leur nom à une maison de l\'école.',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20))
                                    : name == "Comté"
                                        ? const Text(
                                            'Le paysage du Comté, tel qu\'il est décrit dans "Le Seigneur des Anneaux" de J.R.R. Tolkien, est un lieu idyllique et paisible situé dans le milieu de la Terre du Milieu. C\'est là que se trouve la demeure de Bilbon Sacquet, le protagoniste de l\'histoire. Le Comté est un endroit verdoyant, avec de nombreux champs et vergers, ainsi que de petits villages et hameaux dispersés ici et là.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))
                                        : name == "Tatooine"
                                            ? const Text(
                                                'Tatooine est un monde désertique situé dans la Bordure Extérieure de la galaxie. Il est connu pour être le lieu de naissance de Luke Skywalker, l\'un des héros de la Guerre des Étoiles. Le paysage de Tatooine est principalement composé de vastes étendues de sable, de dunes et de montagnes rocheuses. Le soleil y brille en permanence et la température peut atteindre des records de chaleur, ce qui rend la vie sur cette planète très difficile pour les habitants.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20))
                                            : name == "Westeros"
                                                ? const Text(
                                                    'Westeros est un pays imaginaire créé par l\'auteur George R.R. Martin pour sa série de livres "Le Trône de Fer". Il est situé sur un continent fictif et se compose de neuf royaumes, chacun ayant sa propre culture et ses propres coutumes. Le paysage de Westeros est diversifié, allant des verts pâturages du Val à la désolation glacée du Mur. Il y a des montagnes, des forêts, des prairies, des marais et des côtes rocheuses.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20))
                                                : name == "Vogons"
                                                    ? const Text(
                                                        'Le paysage de Vogons est caractérisé par des plaines désertiques et arides, parsemées de quelques collines rocheuses. La végétation est principalement composée de cactus et de buissons durs et résistants, adaptés aux conditions climatiques difficiles de cette région. La faune de Vogons est également très particulière, avec des espèces rares et endémiques comme le Vogon-ours, un animal robuste et agressif qui vit dans les montagnes et qui est réputé pour sa force et sa résistance.',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20))
                                                    : name == "Hub Innovation"
                                                        ? const Text('...',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20))
                                                        : name == "Torvalds"
                                                            ? const Text(
                                                                'Linus Torvalds est un informaticien finlandais connu pour avoir créé le noyau Linux, un système d\'exploitation libre et open source utilisé dans de nombreux ordinateurs et appareils de tous types. Torvalds est né en 1969 à Helsinki, en Finlande. Il a grandi dans une famille où l\'informatique et les technologies de l\'information étaient très présentes. Son père travaillait pour l\'université de Helsinki et avait installé un ordinateur personnel à la maison dès le début des années 1980. ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 20))
                                                            : const Text('Gotham City est une ville fictive du monde de l\'univers DC Comics. Elle est principalement connue comme étant la ville natale de Batman et comme le lieu où se déroulent la plupart de ses aventures. Gotham City est décrite comme étant une grande ville industrielle et cosmopolite, située sur la côte est des États-Unis. Selon les différentes versions de l\'histoire, elle peut être située dans n\'importe quel État de la côte est, mais elle est souvent associée à New York. La ville est connue pour être sombre et menaçante, avec une criminalité élevée et des quartiers défavorisés.', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ))));
  }
}
