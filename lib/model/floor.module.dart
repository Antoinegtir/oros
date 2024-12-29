import 'package:epitech/model/room.module.dart';

class FloorModel {
  late String name;
  late Map<String, RoomModel> rooms;

  FloorModel({
    required this.name,
    required this.rooms,
  });

  FloorModel.fromJson(Map<String, dynamic> map) {
    name = map['name'];
    rooms = {};
    for (var floorKey in map.keys) {
      if (floorKey != 'name' && floorKey != 'colors') {
        for (var roomKey in map[floorKey].keys) {
          rooms[roomKey] = RoomModel.fromJson(map[floorKey][roomKey]);
          rooms[roomKey]!.name = roomKey;
        }
      }
    }
  }
}
