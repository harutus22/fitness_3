import 'package:fitness/model/workout_model_count.dart';

class CreateExerciseFinal{
  bool forEdit = false;
  List<WorkoutModelCount>? workoutModelCount;
  int? id;

  CreateExerciseFinal({this.forEdit = false, this.workoutModelCount, this.id});
}