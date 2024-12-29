import 'dart:ui';

import 'package:epitech/constants/constants.dart';
import 'package:epitech/model/floor.module.dart';
import 'package:epitech/model/room.module.dart';
import 'package:epitech/pages/widget/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String searchQuery = "";

  String whenOccuped(int startAt) {
    DateFormat dateFormat = DateFormat("HH':'mm");
    return 'Jusqu\'à ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(startAt))}';
  }

  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<TextSpan> highlightMatchingText(
      String fullText, String query, bool isDarkMode) {
    if (query.isEmpty) {
      return [
        TextSpan(
          text: fullText,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ];
    }

    final queryLower = query.toLowerCase();
    final textLower = fullText.toLowerCase();

    List<TextSpan> spans = [];
    int start = 0;

    while (true) {
      final index = textLower.indexOf(queryLower, start);
      if (index < 0) {
        spans.add(
          TextSpan(
            text: fullText.substring(start),
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        );
        break;
      }

      if (start != index) {
        spans.add(
          TextSpan(
            text: fullText.substring(start, index),
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: fullText.substring(index, index + query.length),
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      start = index + query.length;
    }
    return spans;
  }

  List<FloorModel> prioritizeFloorsBySearch(
      List<FloorModel> floors, String searchQuery) {
    if (searchQuery.isEmpty) {
      return floors;
    }

    return floors
      ..sort((a, b) {
        int aRelevance = a.rooms.entries
            .where((room) => room.value.name
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .length;
        int bRelevance = b.rooms.entries
            .where((room) => room.value.name
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .length;

        return bRelevance.compareTo(aRelevance);
      });
  }

  @override
  Widget build(BuildContext context) {
    bool isOccuped(MapEntry<String, RoomModel> room) {
      return room.value.activities.isEmpty ||
          room.value.activities.where((e) {
            DateTime now = DateTime.now();
            return DateTime.fromMillisecondsSinceEpoch(e.startAt)
                        .millisecondsSinceEpoch <
                    now.millisecondsSinceEpoch &&
                DateTime.fromMillisecondsSinceEpoch(e.endAt)
                        .millisecondsSinceEpoch >
                    now.millisecondsSinceEpoch;
          }).isEmpty;
    }

    bool soonOccuped(MapEntry<String, RoomModel> room) {
      return room.value.activities.where((e) {
        DateTime now = DateTime.now();
        return DateTime.fromMillisecondsSinceEpoch(e.startAt)
                    .millisecondsSinceEpoch <
                now.add(Duration(hours: 1)).millisecondsSinceEpoch &&
            DateTime.fromMillisecondsSinceEpoch(e.endAt)
                    .millisecondsSinceEpoch >
                now.millisecondsSinceEpoch;
      }).isNotEmpty;
    }

    List<FloorModel> prioritizedList = prioritizeFloorsBySearch(
      floors.where((e) => e.rooms.isNotEmpty).toList(),
      searchQuery,
    );

    prioritizedList.insert(0, FloorModel(name: 'TITLE', rooms: {}));
    prioritizedList.insert(1, FloorModel(name: 'SEARCH_BAR', rooms: {}));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: isDarkMode(context) ? Colors.black : Color(0xfff3f2f8),
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.transparent,
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity:
              controller.hasClients && controller.position.pixels > 50 ? 1 : 0,
          child: Text(
            'Oros',
            style: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
        ),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.white.withOpacity(0),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        controller: controller,
        addAutomaticKeepAlives: true,
        shrinkWrap: true,
        itemCount: prioritizedList.length,
        itemBuilder: (context, index) {
          if (prioritizedList[index].name == 'TITLE') {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Oros',
                style: TextStyle(
                  color: isDarkMode(context) ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            );
          }
          if (prioritizedList[index].name == 'SEARCH_BAR') {
            return SearchBarUI(
              text: (searchRoom) {
                setState(() {
                  searchQuery = searchRoom;
                });
              },
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prioritizedList[index].name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                sh(5),
                Container(
                  width: dw(context),
                  decoration: BoxDecoration(
                    color:
                        isDarkMode(context) ? Color(0xff1c1c1e) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: prioritizedList[index].rooms.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          final room =
                              prioritizedList[index].rooms.entries.elementAt(i);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/room',
                                    arguments: {
                                      "room": room.value,
                                      "floor": prioritizedList[index],
                                    },
                                  );
                                },
                                child: Container(
                                  width: dw(context) - 80,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(
                                            children: highlightMatchingText(
                                              room.value.name,
                                              searchQuery,
                                              isDarkMode(context),
                                            ),
                                            style: TextStyle(
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (room.value.forceClosed) ...[
                                        Container(
                                          height: 20,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 12.2,
                                                child: Text('🚧'),
                                              ),
                                              sw(10),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ] else ...[
                                        Row(
                                          children: [
                                            if (soonOccuped(room))
                                              Builder(builder: (context) {
                                                final roomData = room
                                                    .value.activities
                                                    .firstWhere((e) {
                                                  DateTime now = DateTime.now();
                                                  return DateTime
                                                              .fromMillisecondsSinceEpoch(
                                                                  e.startAt)
                                                          .millisecondsSinceEpoch <
                                                      now
                                                          .add(Duration(
                                                              hours: 1))
                                                          .millisecondsSinceEpoch;
                                                });
                                                return Container(
                                                    width: 120,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          roomData
                                                              .activityTitle,
                                                          style: TextStyle(
                                                            color: isDarkMode(
                                                                    context)
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 10,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Text(
                                                          whenOccuped(
                                                              roomData.startAt),
                                                          style: TextStyle(
                                                            color: isDarkMode(
                                                                    context)
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 10,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              }),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isOccuped(room)
                                                        ? soonOccuped(room)
                                                            ? Colors.yellow
                                                            : Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                                sw(10),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.grey,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: 0.2,
                              width: dw(context),
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
