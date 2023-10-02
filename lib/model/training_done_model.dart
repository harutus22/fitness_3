const String trainingDoneId = "training_done_id";
const String trainingDoneDate = "training_done_date";
const String trainingDoneCalories = "training_done_calories";
const String trainingDoneTimePassed = "training_done_time_passed";

class TrainingDone{

  int? id;
  DateTime? date;
  int caloriesBurnt = 0;
  int timePassed = 0;

  TrainingDone({this.id, this.date, this.caloriesBurnt = 0, this.timePassed = 0});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      trainingDoneId: id,
      trainingDoneDate: date!.toIso8601String(),
      trainingDoneCalories: caloriesBurnt,
      trainingDoneTimePassed: timePassed,
    };
    return map;
  }

  TrainingDone.fromMap(Map<dynamic, dynamic> map) {
    id = map[trainingDoneId];
    date = DateTime.parse(map[trainingDoneDate] as String) ;
    caloriesBurnt = map[trainingDoneCalories];
    timePassed = map[trainingDoneTimePassed];
  }

}