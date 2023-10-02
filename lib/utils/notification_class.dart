import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fitness/utils/Routes.dart';

import '../main.dart';

class NotificationController{

  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    if(receivedAction.channelKey == "scheduled_notification" && Platform.isIOS){
      AwesomeNotifications().getGlobalBadgeCounter().then((value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
    }
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(mainMenuScreen,
            (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(mainMenuScreen,
            (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }

}