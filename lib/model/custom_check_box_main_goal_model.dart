import 'package:fitness/model/user_info_enums.dart';

class CheckBoxMainGoalState{
  final String title;
  final MainGoal mainGoal;
  bool value;

  CheckBoxMainGoalState(
      {
        required this.title,
        this.value = false,
        required this.mainGoal
      });
}