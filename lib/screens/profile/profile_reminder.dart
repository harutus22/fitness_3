import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/notification_class.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/custom_switch.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../model/reminder_workout.dart';
import '../../utils/back_button.dart';
import '../../utils/colors.dart';
import '../../utils/routes.dart';

class ProfileReminderScreen extends StatefulWidget {
  const ProfileReminderScreen({Key? key}) : super(key: key);

  @override
  State<ProfileReminderScreen> createState() => _ProfileReminderScreenState();
}

class _ProfileReminderScreenState extends State<ProfileReminderScreen> {
  @override
  void initState() {
    notificationReminder = NotificationReminder();
    notificationReminder.initializeSettings();
    databaseHelper
        .getReminders()
        .then((value) => {list.clear(), list.addAll(value), setState(() {})});
    AwesomeNotifications().isNotificationAllowed().then((allowed) =>
    {
      if (!allowed)
        {
          showDialog(
              context: context,
              builder: (builder) =>
                  AlertDialog(
                    title: Text(allowNotification.tr()),
                    content: Text(alertText.tr()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            dontAllow.tr(),
                            style:
                            TextStyle(color: Colors.grey, fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            AwesomeNotifications()
                                .requestPermissionToSendNotifications()
                                .then((value) => Navigator.pop(context));
                          },
                          child: Text(
                            allowText.tr(),
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ))
        }
    });
    super.initState();
  }

  List<ReminderWorkout> list = [];
  late NotificationReminder notificationReminder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  backButton(context),
                  Text(
                    reminder.tr(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () async {
                      final item = await changeScreen(
                          profileReminderTimeChooseScreen, context);
                      notificationReminder
                          .showNotification(item as ReminderWorkout);
                      createReminderNotification(item);
                      databaseHelper.getReminders().then((value) =>
                      {list.clear(), list.addAll(value), setState(() {})});
                    },
                    child: Image.asset(
                      "assets/images/add_reminder.png",
                      height: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  workoutsReminder.tr(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return list.isEmpty
                        ? const SizedBox()
                        : reminderItem(list[position], position);
                  },
                  itemCount: list.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _removeItem(int index, ReminderWorkout reminderWorkout) {
    list.removeAt(index);
    databaseHelper.deleteReminder(reminderWorkout.id!);
    setState(() {});
  }

  Widget reminderItem(ReminderWorkout reminderWorkout, int index) {
    int hour =
    reminderWorkout.time!.hour == 0 ? 12 : reminderWorkout.time!.hour;
    final minute = reminderWorkout.time!.minute;
    String isDay = "";
    if (reminderWorkout.time!.hour == 12) {
      isDay = "PM";
      hour = 12;
    } else if (reminderWorkout.time!.hour > 12) {
      isDay = "PM";
      hour = hour - 12;
    } else if (reminderWorkout.time!.hour == 0) {
      isDay = "AM";
      hour = 12;
    } else {
      isDay = "AM";
    }
    List<String> weekDays = [];
    for (var position = 0;
    position < reminderWorkout.days!.length;
    position++) {
      if (reminderWorkout.days![position]) {
        weekDays.add(getWeekDayName(position + 1));
      }
    }
    return Dismissible(
      key: Key(list[index].hashCode.toString()),
      onDismissed: (direction) {
        cancelNotifications(reminderWorkout);
        _removeItem(index, reminderWorkout);
      },
      confirmDismiss: (direction) {
        return Future(() => true);
      },
      child: InkWell(
        onTap: () async {
          final reminder = await changeScreen(profileReminderTimeChooseScreen, context,
              argument: reminderWorkout);
          updateNotification(reminderWorkout, reminder as ReminderWorkout);
          databaseHelper.getReminders().then(
                  (value) =>
              {
                list.clear(),
                list.addAll(value),
                setState(() {})
              });
        },
        child: Column(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: const BoxDecoration(
                border: GradientBoxBorder(
                  gradient: linearGradient,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${hour.toString().padLeft(2, "0")}:${minute.toString()
                            .padLeft(2, "0")} $isDay",
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: getDaysRow(weekDays),
                      )
                    ],
                  ),
                  Focus(
                    autofocus: true,
                    child: CustomSwitch(
                      value: reminderWorkout.isOn,
                      onChanged: (value) {
                        reminderWorkout.isOn = value;
                        databaseHelper.updateReminder(reminderWorkout);
                        if(value == true) {
                          createReminderNotification(reminderWorkout);
                        } else {
                          cancelNotifications(reminderWorkout);
                        }
                        setState(() {});
                      },
                      activeColor: const Color(0xffA16DEA),
                      key: Key(reminderWorkout.id.toString()),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getDaysRow(List<String> days) {
    List<Widget> lines = [];
    for (var day in days) {
      lines.add(ShaderMask(
        shaderCallback: (bounds) =>
            const LinearGradient(
              colors: [colorMainGradLeft, colorMainGradRight],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
        child: Text(
          day,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ));
      lines.add(const SizedBox(
        width: 3,
      ));
    }
    return lines;
  }

  String getWeekDayName(int name) {
    String dayName = "";
    if (name == DateTime.monday) {
      dayName += mondayTxt.tr();
    } else if (name == DateTime.tuesday) {
      dayName += tuesdayTxt.tr();
    } else if (name == DateTime.wednesday) {
      dayName += wednesdayTxt.tr();
    } else if (name == DateTime.thursday) {
      dayName += thursdayTxt.tr();
    } else if (name == DateTime.friday) {
      dayName += fridayTxt.tr();
    } else if (name == DateTime.saturday) {
      dayName += saturdayTxt.tr();
    } else if (name == DateTime.sunday) {
      dayName += sundayTxt.tr();
    }
    return dayName;
  }

  //TODO init reminder work

  Future<void> cancelNotifications(ReminderWorkout reminderWorkout) async {
    var counter = 1;
    for(var item in reminderWorkout.days!) {
      if(item == true) {
        await AwesomeNotifications().cancel(
            reminderWorkout.id! * 1000 + counter);
      }
      counter++;
    }
  }

  Future<void> updateNotification(ReminderWorkout oldReminder, ReminderWorkout newReminder) async {
    await cancelNotifications(oldReminder);
    if(newReminder.isOn == true) {
      createReminderNotification(newReminder);
    }
  }

  Future<void> createReminderNotification(
      ReminderWorkout reminderWorkout) async {
    var counter = 1;
    for(var item in reminderWorkout.days!) {
      if(item == true) {
        await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: reminderWorkout.id! * 1000 + counter,
              channelKey: "scheduled_notification",
              title: "Workout reminder",
              body: reminderTxt.tr(),
              notificationLayout: NotificationLayout.Default,
            ),
            actionButtons: [
              NotificationActionButton(key: 'MARK_DONE', label: "Let's start")
            ],
            schedule: NotificationCalendar(
                weekday: counter,
              hour: reminderWorkout.time!.hour,
              minute: reminderWorkout.time!.minute,
              second: 0,
              millisecond: 0,
              repeats: true
            ),
        );
      }
      counter++;
    }
  }
}
