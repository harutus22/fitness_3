import 'package:fitness/model/user_info.dart';
import 'package:fitness/model/user_info_enums.dart';
import 'package:flutter/material.dart';

import 'const.dart';

double dailyCaloriesNeedsResult(UserInfo? userInfo){
  double result = (user.firstCount.index + user.secondCount.index + user.thirdCount.index) / 3;
  double dcn = 0;
  if(userInfo == null) {
    if (result.toInt() == 0 || result.toInt() == 1) {
      dcn = (user.gender == Gender.male
          ? basalMetabolicRateMale(user)
          : basalMetabolicRateFemale(user)) * 1.2;
    } else if (result.toInt() == 2) {
      dcn = (user.gender == Gender.male
          ? basalMetabolicRateMale(user)
          : basalMetabolicRateFemale(user)) * 1.375;
    } else if (result.toInt() == 3) {
      dcn = (user.gender == Gender.male
          ? basalMetabolicRateMale(user)
          : basalMetabolicRateFemale(user)) * 1.55;
    } else if (result.toInt() == 4) {
      dcn = (user.gender == Gender.male
          ? basalMetabolicRateMale(user)
          : basalMetabolicRateFemale(user)) * 1.725;
    } else if (result.toInt() == 5) {
      dcn = (user.gender == Gender.male
          ? basalMetabolicRateMale(user)
          : basalMetabolicRateFemale(user)) * 1.9;
    }
  } else {
    if (result.toInt() == 0 || result.toInt() == 1) {
      dcn = (userInfo.gender == Gender.male
          ? basalMetabolicRateMale(userInfo)
          : basalMetabolicRateFemale(userInfo)) * 1.2;
    } else if (result.toInt() == 2) {
      dcn = (userInfo.gender == Gender.male
          ? basalMetabolicRateMale(userInfo)
          : basalMetabolicRateFemale(userInfo)) * 1.375;
    } else if (result.toInt() == 3) {
      dcn = (userInfo.gender == Gender.male
          ? basalMetabolicRateMale(userInfo)
          : basalMetabolicRateFemale(userInfo)) * 1.55;
    } else if (result.toInt() == 4) {
      dcn = (userInfo.gender == Gender.male
          ? basalMetabolicRateMale(userInfo)
          : basalMetabolicRateFemale(userInfo)) * 1.725;
    } else if (result.toInt() == 5) {
      dcn = (userInfo.gender == Gender.male
          ? basalMetabolicRateMale(userInfo)
          : basalMetabolicRateFemale(userInfo)) * 1.9;
    }
  }
  return dcn;
}

double massIndexCalculation(){
  final height = user.height / 100;
  return user.weight / (height * height);
}

double basalMetabolicRateMale(UserInfo? userInfo){

  return userInfo == null ?
  10 * user.weight + 6.25 * user.height - 5 * user.age + 5
  : 10 * userInfo.weight + 6.25 * userInfo.height - 5 * userInfo.age + 5;
}

double basalMetabolicRateFemale(UserInfo? userInfo){
  return userInfo == null ?
  10 * user.weight + 6.25 * user.height - 5 * user.age - 161
      : 10 * userInfo.weight + 6.25 * userInfo.height - 5 * userInfo.age - 161 ;
}

Size calculateTextSize(
    BuildContext context,{
  required String text,
  required TextStyle style,
}) {
  final double textScaleFactor = context != null
      ? MediaQuery.of(context).textScaleFactor
      : WidgetsBinding.instance.window.textScaleFactor;

  final TextDirection textDirection =
  context != null ? Directionality.of(context) : TextDirection.ltr;

  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: textDirection,
    textScaleFactor: textScaleFactor,
  )..layout(minWidth: 0, maxWidth: double.infinity);

  return textPainter.size;
}