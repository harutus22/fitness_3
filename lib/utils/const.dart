import 'dart:convert';

// import 'package:alarm/alarm.dart';
// import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/user_info.dart';
import 'package:fitness/utils/database/workout_model_database_helper.dart';
import 'package:fitness/utils/words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/create_exercise_final.dart';
import '../model/muscle_groups.dart';
import '../model/plan_model_static.dart';

const String userShared = "user";
const String subscribedShared = "subscribed";
const String weekShared = "week";
const String firstTrainingDay = "first_training_day";
const String weekPlanShared = "week_plan";
const String passedShared = "passed_shared";

const String planExerciseKcal = "calories";
const String planExerciseName = "name";
const String planExerciseCount = "training_count";
const String planExerciseTotal = "training_total";
const String planExerciseTime = "time";

const mainFont = "PoppinsRegular";
const mainExtraBoldFont = "PoppinsExtraBold";

const catRevenueEntitlement = "premium";
const catRevenueApiKey = "appl_HHjfdScMzYanKVoZbmEJTxSMhYC";
const footerText =
"""Don't forget to add your subscription terms and conditions. 
Read more about this here: https://www.revenuecat.com/blog/schedule-2-section-3-8-b""";

const String canPop = "can_pop";

UserInfo user = UserInfo();
final databaseHelper = WorkoutModelDatabaseHelper();
// PlanModelDatabaseHelper? planDatabaseHelper;
CreateExerciseFinal? workoutModelCount;

void setUser(UserInfo user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, dynamic> us = user.toMap();
  String res = jsonEncode(us);
  await prefs.setString(userShared, res);
}

Future<UserInfo?> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userPref = prefs.getString(userShared);
  Map<String,dynamic> userMap = jsonDecode(userPref!) as Map<String,dynamic>;
  UserInfo user = UserInfo().fromMap(userMap);
  return user;
}

void setSubscribed() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(subscribedShared, true);
}

Future<bool?> getSubscribed() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(subscribedShared);
}

void setPassed() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(passedShared, true);
}

Future<bool?> getPassed() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(passedShared);
}

Future<List<PlanModelStatic>> getWeekPlans() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userPref = prefs.getString(weekPlanShared);
  List<dynamic> userMap = jsonDecode(userPref!) as List<dynamic>;
  List<PlanModelStatic> models = [];
  userMap.forEach((element) {
    models.add(PlanModelStatic.fromMap(element as Map<dynamic, dynamic>));
  });
  return models;
}

void setWeekPlans(List<PlanModelStatic> models) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Map<String, dynamic> us = { for (var e in models) (e).name! : {(e)} };
  List<Map> us = [];
  for (var element in models) {us.add(element.toMap());};
  String res = jsonEncode(us);
  await prefs.setString(weekPlanShared, res);
}

Future<bool?> getWorkoutWeekDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? weekPref = prefs.getInt(weekShared);
  if(weekPref == null) {
    return null;
  }
  DateTime compare = DateTime.fromMillisecondsSinceEpoch(weekPref);
  if(DateTime.now().difference(compare).inDays > 7) {
    return true;
  } else {
    return false;
  }
}

void setWorkoutWeekDate() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final item = DateTime.now().millisecondsSinceEpoch;
  await prefs.setInt(weekShared, item);
  // final prev = DateTime.parse("2023-02-28");
  // print(item.difference(prev).inDays);
}

void setWorkoutFirstDate() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final item = DateTime.now().millisecondsSinceEpoch;
  await prefs.setInt(firstTrainingDay, item);
}

Future<int?> getWorkoutFirstDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(firstTrainingDay);
}

String getTime(bool isTimeChecked, int count, {bool nextLine = false}){
  String result;
  if(!isTimeChecked) {
    result = "x$count";
  } else {
    int time = count * 30;
    int minute = time ~/ 60;
    int seconds = time % 60;

    if (minute == 0) {
      result = "$seconds ${secText.tr()}";
    } else if (seconds == 0 && minute > 0) {
      result = "$minute ${minText.tr()}";
    } else {
      result = nextLine ? "$minute ${minText.tr()} $seconds ${secText.tr()}" : "$minute ${minText.tr()}\n$seconds ${secText.tr()}";
    }
  }
  return result;
}

String getListMuscles(List<MuscleGroups> list) {
  String text = "";
  for(var item = 0; item < list.length; item++) {
    if (item == 0){
      text += list[item].value;
    } else if (item == list.length - 1) {
      text += "| ${list[item].value} ";
    }else {
      text += " | ${list[item].value} ";
    }
  }
  return text;
}

// late AppsflyerSdk appsflyerSdk;

Future<void> launchUrlCall(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

const double onboardingTextSize = 24;

void sendEvent(String eventName) async {
  // final params = Param().putString("onBoardingEvent", eventName);
  // Flurry.logStandardEvent(FlurryEvent.contentViewed, params);
  // appsflyerSdk.logEvent("onBoardingEvent", {
  //   "event": eventName
  // });
  // FirebaseAnalytics.instance.logEvent(name: eventName, parameters: {
  //   eventName:eventName
  // });
}

// void createInterstitialAd(String key) {
//   InterstitialAd.load(
//       adUnitId: key,
//       request: AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           print('$ad loaded');
//           interstitialAd = ad;
//           interstitialAd!.setImmersiveMode(true);
//           _showInterstitialAd();
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           print('InterstitialAd failed to load: $error.');
//           interstitialAd = null;
//         },
//       ));
// }

// void _showInterstitialAd() {
//   if (interstitialAd == null) {
//     print('Warning: attempt to show interstitial before loaded.');
//     return;
//   }
//   interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//     onAdShowedFullScreenContent: (InterstitialAd ad) =>
//         print('ad onAdShowedFullScreenContent.'),
//     onAdDismissedFullScreenContent: (InterstitialAd ad) {
//       print('$ad onAdDismissedFullScreenContent.');
//       ad.dispose();
//     },
//     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//       print('$ad onAdFailedToShowFullScreenContent: $error');
//       ad.dispose();
//     },
//   );
//   interstitialAd!.show();
//   interstitialAd = null;
// }
//
// InterstitialAd? interstitialAd;