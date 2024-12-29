import 'package:epitech/constants/constants.dart';
import 'package:epitech/model/floor.module.dart';

class FloorDataService {
  static void getFloorData(List<dynamic> map) {
    floors = [];
    for (var i = 0; i < map.length; i++) {
      floors.add(FloorModel.fromJson(map[i]));
    }
  }
}
