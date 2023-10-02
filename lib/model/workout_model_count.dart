import 'package:fitness/model/workout_model.dart';

const String _model = "workout_model";
const String _count = "workout_count";
const String _isTime = "workout_is_time";

class WorkoutModelCount {
  late int workOutModel;
  int count = 0;
  bool isTime = false;

  WorkoutModelCount({
    required this.workOutModel,
    required this.count,
    required this.isTime,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _model: workOutModel,
      _count: count,
      _isTime: isTime,
    };
    return map;
  }

  WorkoutModelCount.fromMap(Map<dynamic, dynamic> map) {
    workOutModel = map[_model] as int;
    count = map[_count] as int;
    isTime = map[_isTime] as bool;
  }
}
