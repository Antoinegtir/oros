class ActivitiesModel {
  late String activityTitle;
  late int startAt;
  late int endAt;
  late List<dynamic> orosTags;
  late String? moduleTitle;
  late String? moduleCode;
  late String? type;

  ActivitiesModel({
    required this.activityTitle,
    required this.startAt,
    required this.endAt,
    required this.orosTags,
    required this.moduleTitle,
    required this.moduleCode,
    required this.type,
  });

  ActivitiesModel.fromJson(Map<String, dynamic> map) {
    activityTitle = map['activity_title'];
    startAt = map['start_at'];
    endAt = map['end_at'];
    orosTags = map['oros_tags'];
    if (map.containsKey('module_title')) {
      moduleTitle = map['module_title'];
    } else {
      moduleTitle = null;
    }
    if (map.containsKey('module_code')) {
      moduleCode = map['module_code'];
    } else {
      moduleCode = null;
    }
    if (map.containsKey('type')) {
      type = map['type'];
    } else {
      type = null;
    }
  }
}
