import 'package:epitech/model/activities.module.dart';

class RoomModel {
  late List<ActivitiesModel> activities;
  late bool hideIfFree;
  late bool forceClosed;
  late String forceClosedMessage;
  late String name;

  RoomModel({
    required this.activities,
    required this.hideIfFree,
    required this.forceClosed,
    required this.forceClosedMessage,
    required this.name,
  });

  RoomModel.fromJson(Map<String, dynamic> map) {
    if (map['activities'].isEmpty) {
      activities = [];
    } else {
      activities = map['activities']
          .map<ActivitiesModel>((e) => ActivitiesModel.fromJson(e))
          .toList();
    }
    hideIfFree = map['hide_if_free'];
    if (map.containsKey('force_closed')) {
      forceClosed = map['force_closed'];
    } else {
      forceClosed = false;
    }
    if (map.containsKey('force_closed_message')) {
      forceClosedMessage = map['force_closed_message'];
    } else {
      forceClosedMessage = '';
    }
  }
}
