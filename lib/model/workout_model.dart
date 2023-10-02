import 'dart:convert';

import 'muscle_groups.dart';

const String columnId = '_id';
const String columnTitle = 'name';
const String columnList = 'muscle_list';
const String columnDifficulty = 'difficulty';
const String columnAdditionalInfo = 'additional_info';
// const String columnIdStatic = 'static_id_info';

class WorkOutModel {
  String name = "";
  int difficulty = 0;
  List<MuscleGroups> muscleGroups = [];
  String additionalInfo = "";
  int? id;
  // int? staticId;

  WorkOutModel(
      {
        required this.name,
        required this.difficulty,
        required this.muscleGroups,
        this.additionalInfo = "",
        required this.id
      });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: name,
      columnDifficulty: difficulty.toString(),
      columnList: jsonEncode(muscleGroups),
      columnAdditionalInfo: additionalInfo,
      columnId: id
    };
    return map;
  }

  WorkOutModel.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId] as int;
    name = map[columnTitle] as String;
    difficulty = map[columnDifficulty] as int;
    additionalInfo = map[columnAdditionalInfo] as String;
    // staticId = map[columnIdStatic] as int;
    final a = map[columnList];
    List<dynamic> b = jsonDecode(a);
    List<MuscleGroups> aaa = [];
    for (var element in b) {
      aaa.add(MuscleGroups.values.byName(element["muscle_group"]));
    }
    muscleGroups = aaa;
  }
}