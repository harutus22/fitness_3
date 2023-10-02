import 'package:fitness/model/user_info_enums.dart';

class CheckBoxState{
  final String title;
  final FocusArea focusArea;
  bool value;

  CheckBoxState(
      {
        required this.title,
        this.value = false,
        required this.focusArea
      });
}