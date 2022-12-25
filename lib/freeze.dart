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
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> libreItems = [];
    List<Map<String, dynamic>> nonLibreItems = [];
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
            backgroundColor: lightmode,
            body: Stack(
              children: [
                Image.asset("assets/b.png",
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.height / 1,
                    fit: BoxFit.fill),
                Container(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.transparent
                      : Color.fromARGB(173, 0, 0, 0),
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width / 1,
                ),
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
                        Duration oneHour = const Duration(hours: 1);
                        DateFormat dateFormat = DateFormat("HH'h'mm");
                        var activities = sortedData[index]['activities'];
                        return Padding(
                            padding: EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                right: MediaQuery.of(context).size.width / 7,
                                left: MediaQuery.of(context).size.width / 7),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    color: const Color.fromARGB(48, 0, 0, 0),
                                    child: ExpansionTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 10,
                                                          bottom: 10,
                                                          right: 20),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  70),
                                                      child: Container(
                                                          color: Colors.white,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              13,
                                                          height: 70,
                                                          child: Hero(
                                                            tag: sortedData[
                                                                index]['name'],
                                                            child:
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(context).pushNamed(
                                                                          '/room',
                                                                          arguments: {
                                                                            'name':
                                                                                sortedData[index]['name'],
                                                                            'activities': sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'] == null
                                                                                ? ""
                                                                                : sortedData[index]['activities'][0]['activity_title'],
                                                                            "module_title": sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['module_title'] == null
                                                                                ? ""
                                                                                : sortedData[index]['activities'][0]['module_title'],
                                                                            "module_code": sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['module_code'] == null
                                                                                ? ""
                                                                                : sortedData[index]['activities'][0]['module_code'],
                                                                            "start_at": sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['start_at'] == null
                                                                                ? 0
                                                                                : sortedData[index]['activities'][0]['start_at'],
                                                                            "end_at": sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['end_at'] == null
                                                                                ? 0
                                                                                : sortedData[index]['activities'][0]['end_at'],
                                                                            "type": sortedData[index]['activities'].toString() == "[]" || sortedData[index]['activities'][0]['type'] == null
                                                                                ? ""
                                                                                : sortedData[index]['activities'][0]['type'],
                                                                          });
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/${sortedData[index]['name'].toLowerCase()}.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                          )))),
                                              Text(
                                                "${sortedData[index]['name']}",
                                                style: TextStyle(
                                                    color: darkmode,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            30,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              Row(children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      30,
                                                ),
                                                for (int i = 0;
                                                    i < activities.length;
                                                    i++)
                                                  MediaQuery.of(context).size.width /
                                                              1 *
                                                              16 /
                                                              9 >=
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1
                                                      ? sortedData[index]['activities'][0]['end_at'] <
                                                                      DateTime.now()
                                                                          .millisecondsSinceEpoch &&
                                                                  sortedData[index]['activities'][0][
                                                                          'start_at'] ==
                                                                      null ||
                                                              sortedData[index]
                                                                          ['activities'][0]
                                                                      ['start_at'] >
                                                                  DateTime.now().millisecondsSinceEpoch
                                                          ? Text(
                                                              "Libre jusqu'à: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activities[i]['start_at']).subtract(oneHour))}",
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color:
                                                                      darkmode,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            )
                                                          : Text(
                                                              "Occupé jusqu'à: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activities[i]['end_at']).subtract(oneHour))}",
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color:
                                                                      darkmode,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                            )
                                                      : const SizedBox.shrink(),
                                                Text(
                                                  "${sortedData[index]['activities']}" !=
                                                          "[]"
                                                      ? ""
                                                      : "Libre jusqu'à la fin de la journée",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: darkmode,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ])
                                            ],
                                          ),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  color: "${sortedData[index]['activities']}" == "[]" ||
                                                          sortedData[index]['activities'][0]
                                                                  ['end_at'] ==
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
                                                          : const Color.fromARGB(255, 255, 0, 0)))
                                        ],
                                      ),
                                      children: <Widget>[
                                        for (int i = 0;
                                            i < activities.length;
                                            i++)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30),
                                            child: ListTile(
                                              title: Text(
                                                activities[i]['activity_title'],
                                                style:
                                                    TextStyle(color: darkmode),
                                              ),
                                              leading: Text(
                                                overflow: TextOverflow.ellipsis,
                                                activities[i]['type']
                                                            .toString() ==
                                                        "null"
                                                    ? ""
                                                    : activities[i]['type']
                                                        .toString()
                                                        .toUpperCase(),
                                                style: TextStyle(
                                                  color: darkmode,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              trailing: Text(
                                                "${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activities[i]['start_at']).subtract(oneHour))} - ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(activities[i]['end_at']).subtract(oneHour))}",
                                                style:
                                                    TextStyle(color: darkmode),
                                              ),
                                              subtitle: Text(
                                                "${activities[i]['module_title'].toString() == "null" ? "" : "${activities[i]['module_title']} -"} ${activities[i]['module_code'].toString() == "null" ? "" : activities[i]['module_code']}",
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    TextStyle(color: darkmode),
                                              ),
                                            ),
                                          )
                                      ],
                                    ))));
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
    final lightmode =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : Colors.black;
    final darkode = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
        backgroundColor: lightmode,
        appBar: AppBar(
          title: Text(
            name,
            style: TextStyle(color: darkode),
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
              style: TextStyle(color: darkode, fontSize: 50),
            ),
            Text(
              moduleTitle,
              style: TextStyle(color: darkode, fontSize: 50),
            ),
            Text(
              moduleCode,
              style: TextStyle(color: darkode, fontSize: 50),
            ),
            Text(
              type,
              style: TextStyle(color: darkode, fontSize: 50),
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
