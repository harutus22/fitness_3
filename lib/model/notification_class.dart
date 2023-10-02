import 'package:fitness/model/reminder_workout.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   print(notificationResponse);
// }

class NotificationReminder{

  // final FlutterLocalNotificationsPlugin flutterNotificationPlugin =
  //     FlutterLocalNotificationsPlugin();

  void initializeSettings()async {
    // const AndroidInitializationSettings androidInitializationSettings =
    //     AndroidInitializationSettings("@mipmap/ic_launcher");
    //
    // const DarwinInitializationSettings iosInitializationSettings =
    //     DarwinInitializationSettings();
    //
    // const InitializationSettings initSettings =
    //     InitializationSettings(
    //       android: androidInitializationSettings,
    //       iOS: iosInitializationSettings
    //     );
    //
    // await flutterNotificationPlugin.initialize(
    //   initSettings,
    //   onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    //   onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    //
    // );
    // flutterNotificationPlugin.resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    // final isEnabled = await flutterNotificationPlugin.resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();
    // print(isEnabled);
  }

  // void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   print("aaaa");
  // }

  showNotification(ReminderWorkout item){
    // const androidNotificationDetails =  AndroidNotificationDetails(
    //     "fitness_channel_id",
    //     "workout fitness",
    //     importance: Importance.high,
    //   priority: Priority.max
    // );
    //
    // const DarwinNotificationDetails iosNotificationDetails =
    //     DarwinNotificationDetails(
    //       presentAlert: true,
    //       presentBadge: true,
    //       presentSound: true
    //     );
    //
    // NotificationDetails notificationDetails =
    //     const NotificationDetails(
    //       android: androidNotificationDetails,
    //       iOS: iosNotificationDetails
    //     );
    //
    // tz.initializeTimeZones();
    // DateTime dateTime = DateTime.now();
    // final toRingDate = DateTime(dateTime.year, dateTime.month,
    //     dateTime.day, item.time!.hour, item.time!.minute);
    // DateTime schedulingTime;
    // while(true) {
    //   if(!item.days![dateTime.weekday - 1]){
    //     dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day + 1, dateTime.hour, dateTime.minute);
    //   } else {
    //     if(toRingDate.day == dateTime.day &&
    //         dateTime.hour <= toRingDate.hour &&
    //         dateTime.minute < toRingDate.minute){
    //       schedulingTime = DateTime(dateTime.year, dateTime.month,
    //           dateTime.day, toRingDate.hour, toRingDate.minute);
    //       break;
    //     } else if(toRingDate.day == dateTime.day &&
    //         dateTime.hour >= toRingDate.hour){
    //       // dateTime.add(const Duration(days: 1));
    //       schedulingTime = DateTime(dateTime.year, dateTime.month,
    //           dateTime.day + 1, toRingDate.hour, toRingDate.minute);
    //       break;
    //     } else {
    //       schedulingTime = DateTime(dateTime.year, dateTime.month,
    //           dateTime.day, toRingDate.hour, toRingDate.minute);
    //       break;
    //     }
    //   }
    // }
    // final tz.TZDateTime scheduleAt = tz.TZDateTime.from(schedulingTime, tz.local);
    //
    // flutterNotificationPlugin.zonedSchedule(item.id!, "Fitness", "Time to workout", scheduleAt,
    //     notificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
    //     androidAllowWhileIdle: true);


    // flutterNotificationPlugin.show(item.id!, "Fitness", "Time to workout", notificationDetails);
  }
}