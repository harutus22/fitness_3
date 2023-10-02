import 'package:fitness/model/user_info_enums.dart';

class CheckBoxMotivationState{
  final String title;
  final Motivations motivation;
  bool value;
  final String image;

  CheckBoxMotivationState(
      {
        required this.title,
        this.value = false,
        required this.motivation,
        required this.image
      });
}