import 'dart:collection';
import 'dart:convert';

import 'package:fitness/model/user_info_enums.dart';

class UserInfo {
  String name = "";
  Gender gender = Gender.male;
  int age = 0;
  double height = 0;
  double weight = 0;
  double targetWeight = 0;
  List<FocusArea> focusArea = [];
  MainGoal mainGoal = MainGoal.buildMuscle;
  List<Motivations> motivations = [];
  TrainingCount firstCount = TrainingCount.from5To10;
  TrainingCount secondCount = TrainingCount.from5To10;
  TrainingCount thirdCount = TrainingCount.from5To10;
  int totalCount = 0;
  bool isSubscribed = false;
  bool isPassed = false;
  int waterLimit = 8;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> user = {
      'name': name,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'targetWeight': targetWeight,
      'focusArea': jsonEncode(focusArea),
      'mainGoal': mainGoal,
      'motivations': jsonEncode(motivations),
      'firstCount': firstCount,
      'secondCount': secondCount,
      'thirdCount': thirdCount,
      'totalCount': totalCount,
      'subscribed': isSubscribed,
      'passed': isPassed,
      'waterLimit': waterLimit
    };
    return user;
  }

  UserInfo fromMap(Map<String, dynamic> user){
    final fa = (jsonDecode(user['focusArea'])) as List<dynamic>;
    List<FocusArea> focusArea = [];
    for (var element in fa) {
      focusArea.add(FocusArea.values.byName(element['focus_are']));
    }

    final mot = (jsonDecode(user['motivations'])) as List<dynamic>;
    List<Motivations> motivations = [];
    for (var element in mot) {
      motivations.add(Motivations.values.byName(element['motivation']));
    }

    UserInfo info = UserInfo();
    info.name = user['name'];
    info.gender = Gender.values.byName((user['gender']  as Map<String, dynamic>).values.first);
    info.age = user['age'];
    info.height = user['height'];
    info.weight = user['weight'];
    info.targetWeight = user['targetWeight'];
    info.focusArea = focusArea;
    info.mainGoal = MainGoal.values.byName((user['mainGoal'] as Map<String, dynamic>).values.first);
    info.motivations = motivations;
    info.firstCount = TrainingCount.values.byName((user['firstCount'] as Map<String, dynamic>).values.first);
    info.secondCount = TrainingCount.values.byName((user['secondCount'] as Map<String, dynamic>).values.first);
    info.thirdCount = TrainingCount.values.byName((user['thirdCount'] as Map<String, dynamic>).values.first);
    info.totalCount = user['totalCount'] as int;
    info.isSubscribed = user['subscribed'] as bool;
    info.isPassed = user['passed'] as bool;
    info.waterLimit = user['waterLimit'] as int;
    return info;
  }
}