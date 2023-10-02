import 'dart:convert';

const String planId = "plan_id";
const String planDiffLevel = "plan_difficulty_level";
const String planWarmUp = "plan_warm_up";
const String planWarmUpTime = "plan_warm_up_time";
const String planTrainingInMin = "plan_training_in_minutes";
const String planTraining = "plan_training";
const String planTrainingTime = "plan_training_time";
const String planHitch = "plan_hitch";
const String planHitchTime = "plan_hitch_time";
const String planRestBetweenExercises = "plan_rest_between_exercises";
const String planName = "plan_name";
const String planType = "plan_type";
const String planImage = "plan_image";

class PlanModelStatic{

  int? id = 0;
  int? difficultyLevel;
  List<int>? warmUp;
  List<int>? warmUpTime;
  int? trainingInMinutes;
  List<int>? training;
  List<int>? trainingTime;
  List<int>? hitch;
  List<int>? hitchTime;
  int? restBetweenExercises;
  String? name;
  String? type;
  String? image;

  PlanModelStatic({
  required this.name,
   required this.difficultyLevel,
   required this.warmUp,
   required this.warmUpTime,
   required this.trainingInMinutes,
   required this.training,
   required this.trainingTime,
   required this.hitch,
   required this.hitchTime,
   required this.restBetweenExercises,
   required this.type,
});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      planName: name,
      planDiffLevel: difficultyLevel,
      planWarmUp: jsonEncode(warmUp),
      planWarmUpTime: jsonEncode(warmUpTime),
      planTrainingInMin: trainingInMinutes,
      planTraining: jsonEncode(training),
      planTrainingTime: jsonEncode(trainingTime),
      planHitch: jsonEncode(hitch),
      planHitchTime: jsonEncode(hitchTime),
      planRestBetweenExercises: restBetweenExercises,
      planType: type,
      planImage: image
    };
    return map;
  }

  PlanModelStatic.fromMap(Map<dynamic, dynamic> map) {
    final item = map[planId];
    id = item == null ? 0 : item as int;
    name = map[planName] as String;
    difficultyLevel = map[planDiffLevel] as int;
    warmUp = getList(jsonDecode(map[planWarmUp]));
    warmUpTime = getList(jsonDecode(map[planWarmUpTime]));
    trainingInMinutes = map[planTrainingInMin] as int;
    training = getList(jsonDecode(map[planTraining]));
    trainingTime= getList(jsonDecode(map[planTrainingTime]));
    hitch = getList(jsonDecode(map[planHitch]));
    hitchTime = getList(jsonDecode(map[planHitchTime]));
    restBetweenExercises = map[planRestBetweenExercises] as int;
    type = map[planType] as String;
    image = map[planImage];
  }

  List<int> getList(List<dynamic> a){
    List<int >list = [];
    for(final item in a){
      list.add(item as int);
    }
    return list;
  }

}