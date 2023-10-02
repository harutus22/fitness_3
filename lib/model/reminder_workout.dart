import 'dart:convert';

const String reminderId = "reminder_id";
const String reminderTime = "reminder_time";
const String reminderIsOn = "reminder_is_on";
const String reminderDays = "reminder_weekday";

class ReminderWorkout{
  int? id;
  DateTime? time;
  bool isOn = true;
  List<bool>? days;

  ReminderWorkout({this.id, this.time, this.isOn = true, this.days});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      reminderId: id,
      reminderTime: time!.toIso8601String(),
      reminderIsOn: isOn == true ? 1 : 0,
      reminderDays: jsonEncode(days),
    };
    return map;
  }

  ReminderWorkout.fromMap(Map<dynamic, dynamic> map) {
    final item = map[reminderId];
    id = item == null ? 0 : item as int;
    time =DateTime.parse(map[reminderTime] as String) ;
    isOn = map[reminderIsOn] == 1;
    days = getList(jsonDecode(map[reminderDays]));
  }

  List<bool> getList(List<dynamic> a){
    List<bool >list = [];
    for(final item in a){
      list.add(item as bool);
    }
    return list;
  }
}