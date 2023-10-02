const waterId = "water_id";
const waterDrunk = "water_drunk";
const waterCurrentDate = "water_date";

class WaterModel{
  int? id;
  double? water;
  int? currentDate;

  WaterModel({required this.water, required this.currentDate});


  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      waterId: id,
      waterDrunk: water,
      waterCurrentDate: currentDate,

    };
    return map;
  }

  WaterModel.fromMap(Map<dynamic, dynamic> map) {
    final item = map[waterId];
    id = item == null ? 0 : item as int;
    water = map[waterDrunk] as double;
    currentDate = map[waterCurrentDate];
  }
}