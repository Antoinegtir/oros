import 'package:epitech/constants/constants.dart';
import 'package:epitech/model/room.module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _HomePageState();
}

class _HomePageState extends State<RoomPage> {
  String dateFormat(int startAt, int endAt) {
    DateFormat dateFormat = DateFormat("HH':'mm");
    return '${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(startAt)) + " - " + dateFormat.format(DateTime.fromMillisecondsSinceEpoch(endAt))}';
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final room = args['room'] as RoomModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          room.name,
          style: TextStyle(
            color: isDarkMode(context) ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: CupertinoNavigationBarBackButton(
          color: isDarkMode(context) ? Colors.white : Colors.black,
          previousPageTitle: 'Oros',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
      body: room.activities.length == 0
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(30),
                      child: Image.network(
                        "https://em-content.zobj.net/source/microsoft-teams/363/man-detective_1f575-fe0f-200d-2642-fe0f.png",
                        height: 100,
                      ),
                    ),
                    sh(20),
                    Text(
                      'No activities found',
                      style: TextStyle(
                        color:
                            isDarkMode(context) ? Colors.white : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    sh(dh(context) / 6)
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: room.activities.length,
              itemBuilder: (context, index) {
                final activity = room.activities[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          activity.activityTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        sh(10),
                        Text(
                          activity.moduleTitle ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          activity.moduleCode ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          dateFormat(activity.startAt, activity.endAt),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
