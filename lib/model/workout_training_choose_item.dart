import 'package:fitness/model/muscle_groups.dart';
import 'package:fitness/model/workout_model.dart';

class WorkoutTrainingChooseItem{
  final MuscleGroups muscleGroup;
  List<WorkOutModel> workOutModel = [];
  bool isPressed = false;

  WorkoutTrainingChooseItem({
    required this.muscleGroup,
});

  void setWorkouts(List<WorkOutModel> workOutModel){
    this.workOutModel.addAll(workOutModel);
  }
}