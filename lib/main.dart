import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_strategy/url_strategy.dart';

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
  if (response.statusCode == 200) {
    // Parse the response body as JSON
    final dynamic jsonData = json.decode(response.body);

    // Now you can use the `jsonData` variable in your app
    runApp(MyApp(jsonData: jsonData));
  } else {
    debugPrint("error 201");
  }
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
          '/room': (context) => const SubPage(),
        },
        home: HomePage(jsonData: widget.jsonData));
  }
}

class HomePage extends StatefulWidget {
  final dynamic jsonData;
  const HomePage({Key? key, this.jsonData}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> libreItems = [];
    List<Map<String, dynamic>> nonLibreItems = [];
    Duration oneHour = const Duration(hours: 1);
    DateFormat dateFormat = DateFormat("HH'h'mm");
    final lightmode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : Colors.black;

    final darkmode =
        MediaQuery.of(context).platformBrightness != Brightness.light
            ? Colors.white
            : Colors.black;

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
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
                height: 500,
                width: MediaQuery.of(context).size.width / 1,
                child: Image.network(
                    "assets/${sortedData[_current]['name'].toLowerCase()}.png",
                    fit: BoxFit.cover)),
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
            Positioned(
              bottom: 100,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 500.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.60,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,
                items: sortedData.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      int index = sortedData.indexOf(movie);
                      var activities = sortedData[index]['activities'];
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 320,
                                          margin: const EdgeInsets.only(
                                              top: 30, left: 20, right: 20),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    '/room',
                                                    arguments: {
                                                      'name': sortedData[index]
                                                          ['name'],
                                                      'activities': sortedData[
                                                                              index]
                                                                          [
                                                                          'activities']
                                                                      .toString() ==
                                                                  "[]" ||
                                                              sortedData[index][
                                                                      'activities'] ==
                                                                  null
                                                          ? ""
                                                          : sortedData[index][
                                                                  'activities'][0]
                                                              [
                                                              'activity_title'],
                                                      "module_title": sortedData[
                                                                              index]
                                                                          [
                                                                          'activities']
                                                                      .toString() ==
                                                                  "[]" ||
                                                              sortedData[index][
                                                                          'activities'][0]
                                                                      [
                                                                      'module_title'] ==
                                                                  null
                                                          ? ""
                                                          : sortedData[index]
                                                                  ['activities']
                                                              [0]['module_title'],
                                                      "module_code": sortedData[
                                                                              index]
                                                                          [
                                                                          'activities']
                                                                      .toString() ==
                                                                  "[]" ||
                                                              sortedData[index][
                                                                          'activities'][0]
                                                                      [
                                                                      'module_code'] ==
                                                                  null
                                                          ? ""
                                                          : sortedData[index]
                                                                  ['activities']
                                                              [0]['module_code'],
                                                      "start_at": sortedData[index]
                                                                          [
                                                                          'activities']
                                                                      .toString() ==
                                                                  "[]" ||
                                                              sortedData[index][
                                                                          'activities'][0]
                                                                      [
                                                                      'start_at'] ==
                                                                  null
                                                          ? 0
                                                          : sortedData[index]
                                                                  ['activities']
                                                              [0]['start_at'],
                                                      "end_at": sortedData[index]
                                                                          [
                                                                          'activities']
                                                                      .toString() ==
                                                                  "[]" ||
                                                              sortedData[index][
                                                                          'activities'][0]
                                                                      [
                                                                      'end_at'] ==
                                                                  null
                                                          ? 0
                                                          : sortedData[index]
                                                                  ['activities']
                                                              [0]['end_at'],
                                                      "type": sortedData[index][
                                                                          'activities']
                                                                      .toString() ==
                                                                  "[]" ||
                                                              sortedData[index][
                                                                          'activities'][0]
                                                                      [
                                                                      'type'] ==
                                                                  null
                                                          ? ""
                                                          : sortedData[index]
                                                                  ['activities']
                                                              [0]['type'],
                                                    });
                                              },
                                              child: Hero(
                                                  tag: sortedData[index]
                                                      ['name'],
                                                  child: Image.network(
                                                      "assets/${sortedData[index]['name'].toLowerCase()}.png",
                                                      fit: BoxFit.cover))),
                                        ),

                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${sortedData[sortedData.indexOf(movie)]['name']}",
                                              style: TextStyle(
                                                  color: darkmode,
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    color: "${sortedData[index]['activities']}" ==
                                                                "[]" ||
                                                            sortedData[index]['activities'][0]['end_at'] ==
                                                                null
                                                        ? const Color.fromRGBO(
                                                            0, 255, 8, 1)
                                                        : sortedData[index]['activities'][0]['end_at'] <
                                                                        DateTime.now()
                                                                            .millisecondsSinceEpoch &&
                                                                    sortedData[index]['activities'][0]['start_at'] ==
                                                                        null ||
                                                                sortedData[index]
                                                                            ['activities'][0]
                                                                        ['start_at'] >
                                                                    DateTime.now().millisecondsSinceEpoch
                                                            ? const Color.fromRGBO(0, 255, 8, 1)
                                                            : const Color.fromARGB(255, 255, 0, 0))),
                                          ],
                                        ),
                                        // rating
                                        const SizedBox(height: 20),

                                        sortedData[index]['activities'] != "[]"
                                            ? const Text(
                                                "Libre jusqu'à la fin de la journée",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              )
                                            : sortedData[index]['activities'][0]
                                                                ['end_at'] <
                                                            DateTime.now()
                                                                .millisecondsSinceEpoch &&
                                                        sortedData[index][
                                                                    'activities'][0]
                                                                ['start_at'] ==
                                                            null ||
                                                    sortedData[index]
                                                                ['activities']
                                                            [0]['start_at'] >
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch
                                                ? Text(
                                                    "Libre jusqu'à: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activities[0]['start_at']).subtract(oneHour))}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: darkmode,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )
                                                : Text(
                                                    "Occupé jusqu'à: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activities[0]['end_at']).subtract(oneHour))}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: darkmode,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedOpacity(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              opacity: _current ==
                                                      sortedData.indexOf(movie)
                                                  ? 1.0
                                                  : 0.0,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time,
                                                      color:
                                                          Colors.grey.shade600,
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      '24h',
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors
                                                              .grey.shade600),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))));
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String name = args['name'];
    final String activities = args['activities'];
    final String moduleTitle = args['module_title'];
    final String moduleCode = args['module_code'];
    final int startAt = args['start_at'];
    final int endAt = args['end_at'];
    final String type = args['type'];

    Duration oneHour = const Duration(hours: 1);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(startAt).subtract(oneHour);
    DateTime dateTimes =
        DateTime.fromMillisecondsSinceEpoch(endAt).subtract(oneHour);
    DateFormat dateFormat = DateFormat("HH'h'mm");
    String formattedEndDate = dateFormat.format(dateTimes);
    String formattedStartTime = dateFormat.format(dateTime);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: const TextStyle(color: Colors.black),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              activities,
              style: const TextStyle(color: Colors.black, fontSize: 50),
            ),
            Text(
              moduleTitle,
              style: const TextStyle(color: Colors.black, fontSize: 50),
            ),
            Text(
              moduleCode,
              style: const TextStyle(color: Colors.black, fontSize: 50),
            ),
            Text(
              type,
              style: const TextStyle(color: Colors.black, fontSize: 50),
            ),
            Text(
              "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ));
  }
}
