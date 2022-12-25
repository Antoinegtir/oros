import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _room(String name, String activityTitle, String moduleTitle,
      String moduleCode, int startAt, int endAt, String type, String status) {
    Duration oneHour = const Duration(hours: 1);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(startAt).subtract(oneHour);
    DateTime dateTimes =
        DateTime.fromMillisecondsSinceEpoch(endAt).subtract(oneHour);
    DateFormat dateFormat = DateFormat("HH'h'mm");
    String formattedEndDate = dateFormat.format(dateTimes);
    String formattedStartTime = dateFormat.format(dateTime);

    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20, vertical: 20),
        child: ClipRRect(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height / 40),
            child: Container(
                height: MediaQuery.of(context).size.height / 9,
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height / 70),
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width / 13,
                              height: 200,
                              child: Image.asset(
                                "${name.toLowerCase()}.png",
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      activityTitle,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      status,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${formattedStartTime == formattedEndDate ? "" : status == "Occupé Jusqu'à " ? formattedEndDate : formattedStartTime}\t',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      moduleTitle,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      moduleCode,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${formattedStartTime == formattedEndDate ? "" : formattedStartTime}\t',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${formattedStartTime == formattedEndDate ? "" : formattedEndDate}\t',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      type,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
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

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          '/room': (context) => const SubPage(),
        },
        home: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 70,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/epitech.png",
                    fit: BoxFit.cover,
                    height: 50,
                  ),
                ],
              ),
              flexibleSpace: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                        height: 200,
                        width: 50,
                      ))),
            ),
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Image.asset("assets/b.png",
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.height / 1,
                    fit: BoxFit.fill),
                ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 1,
                        ))),
                Lottie.asset("assets/ani.json",
                    width: MediaQuery.of(context).size.width / 1,
                    fit: BoxFit.cover),
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView.builder(
                      itemCount: sortedData.length,
                      itemBuilder: (context, index) {
                        String status;
                        if (sortedData[index]['activities'].toString() ==
                                "[]" ||
                            sortedData[index]['activities'] == null) {
                          status = "Libre Jusqu'à la fin de la journée";
                        } else if (sortedData[index]['activities'][0]
                                    ['end_at'] ==
                                null ||
                            sortedData[index]['activities'][0]['end_at'] >
                                    DateTime.now().millisecondsSinceEpoch &&
                                sortedData[index]['activities'][0]
                                        ['start_at'] ==
                                    null ||
                            sortedData[index]['activities'][0]['start_at'] <
                                DateTime.now().millisecondsSinceEpoch) {
                          status = "Occupé Jusqu'à ";
                        } else if (sortedData[index]['activities'][0]
                                    ['end_at'] ==
                                null ||
                            sortedData[index]['activities'][0]['end_at'] >
                                DateTime.now().millisecondsSinceEpoch) {
                          status = "Libre Jusqu'à ";
                        } else {
                          status = sortedData[index]['activities'][0]['type'];
                        }

                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/room', arguments: {
                                'name': sortedData[index]['name'],
                              });
                            },
                            child: _room(
                                sortedData[index]['name'],
                                sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'] == null
                                    ? ""
                                    : sortedData[index]['activities'][0]
                                        ['activity_title'],
                                sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['module_title'] == null
                                    ? ""
                                    : sortedData[index]['activities'][0]
                                        ['module_title'],
                                sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['module_code'] == null
                                    ? ""
                                    : sortedData[index]['activities'][0]
                                        ['module_code'],
                                sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['start_at'] == null
                                    ? 0
                                    : sortedData[index]['activities'][0]
                                        ['start_at'],
                                sortedData[index]['activities'].toString() == "[]" ||
                                        sortedData[index]['activities'][0]['end_at'] ==
                                            null
                                    ? 0
                                    : sortedData[index]['activities'][0]
                                        ['end_at'],
                                sortedData[index]['activities'].toString() == "[]" ||
                                        sortedData[index]['activities'][0]['type'] == null
                                    ? ""
                                    : sortedData[index]['activities'][0]['type'],
                                status));
                      },
                    ))
              ],
            )));
  }
}

class SubPage extends StatelessWidget {
  const SubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String name = args['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text(
          'This is the subpage for $name',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
