import 'dart:convert';

import 'package:fitness/model/workout_model_count.dart';

const String customPlanId = "custom_plan_id";
const String customPlanModelName = "custom_plan_model";
const String customPlanCountModelList = "custom_count_model_list";
const String customPlanCount = "custom_plan_count";
const String customPlanIsChecked = "custom_plan_is_checked";

class PlanModel {
  int? id;
  late String name;
  late List<WorkoutModelCount> countModelList;
  late int count;
  late bool isTimeChecked;

  PlanModel({
    this.id,
    required this.name,
    required this.countModelList,
    required this.count,
    required this.isTimeChecked,
  });

  Map<String, Object?> toJson() {
    final list = [];
    for(var item in countModelList){
      list.add(item.toMap());
    }
    var map = <String, Object?>{
      customPlanId:id,
      customPlanModelName: name,
      customPlanCount: count,
      customPlanCountModelList: jsonEncode(list),
      customPlanIsChecked: isTimeChecked
    };
    return map;
  }

  PlanModel.fromJson(Map<dynamic, dynamic> map) {
    id = map[customPlanId] as int;
    name = map[customPlanModelName] as String;
    count = map[customPlanCount] as int;
    isTimeChecked = (map[customPlanIsChecked] as int) == 1;
    final a = map[customPlanCountModelList];
    List<dynamic> b = jsonDecode(a);
    List<WorkoutModelCount> aaa = [];
    for (var element in b) {
      aaa.add(WorkoutModelCount.fromMap(element));
    }
    countModelList = aaa;
  }
}
