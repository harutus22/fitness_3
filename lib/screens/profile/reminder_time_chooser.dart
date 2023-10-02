import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/reminder_workout.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../utils/back_button.dart';
import '../../utils/routes.dart';

class ReminderTimeChooserScreen extends StatefulWidget {
  const ReminderTimeChooserScreen({Key? key}) : super(key: key);

  @override
  State<ReminderTimeChooserScreen> createState() => _ReminderTimeChooserState();
}

class _ReminderTimeChooserState extends State<ReminderTimeChooserScreen> {

  int _hour = 10;
  int _minute = 0;
  String _dayNight = "AM";
  List<bool> daysOfWeek= [true, true, true, true, true, false, false];
  Object? item;
  List<String> tmpMinute = ["AM", "PM"];

  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)!.settings.arguments;
    if(item != null){
      daysOfWeek = (item as ReminderWorkout).days!;
      _minute = (item as ReminderWorkout).time!.minute;
      if((item as ReminderWorkout).time!.hour == 12) {
        _hour = 12;
        tmpMinute = ["PM", "AM"];
        _dayNight = "PM";
      } else if((item as ReminderWorkout).time!.hour > 12){
        _hour = (item as ReminderWorkout).time!.hour - 12;
        tmpMinute = ["PM", "AM"];
        _dayNight = "PM";
      } else if((item as ReminderWorkout).time!.hour == 0){
        _hour = 12;
        tmpMinute = ["AM", "PM"];
        _dayNight = "AM";
      } else {
        _hour = (item as ReminderWorkout).time!.hour == 0 ? 12 : (item as ReminderWorkout).time!.hour;
        _dayNight = "AM";
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                  child: backButton(context)
              ),
             Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: bedTimeChooser((p0) => _hour = p0, (p0) => _minute = p0,
                        (p0) => _dayNight = p0,
                    height: 150, width: 60),
              ),
              Divider( thickness: 1, color: Color(0xff282E3C).withOpacity(0.5)),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  repeatText.tr(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dayItem(daysOfWeek[0], "M", 0),
                  dayItem(daysOfWeek[1], "T", 1),
                  dayItem(daysOfWeek[2], "W", 2),
                  dayItem(daysOfWeek[3], "T", 3),
                  dayItem(daysOfWeek[4], "F", 4),
                  dayItem(daysOfWeek[5], "S", 5),
                  dayItem(daysOfWeek[6], "S", 6),
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      if(item == null) {
                        var currentDateTime = DateTime.now();
                        int hour = 0;
                        if(_dayNight == "PM"){
                          if(_hour == 12){
                            hour = 12;
                          } else {
                            hour = _hour + 12;
                          }
                        } else {
                          if(_hour == 12){
                            hour = 0;
                          } else {
                            hour = _hour;
                          }
                        }
                        var dateTime = DateTime(currentDateTime.year,
                            currentDateTime.month,
                            currentDateTime.hour < hour ? currentDateTime.day +
                                1 : currentDateTime.day,
                            hour, _minute, 0);
                        var workoutDate = ReminderWorkout(
                            time: dateTime, isOn: true, days: daysOfWeek);
                        final id = await databaseHelper.insertReminder(workoutDate);
                        // setSettings(id);
                        popScreen(context, argument: id);
                      } else {
                        final work = item as ReminderWorkout;
                        int hour = 0;
                        if(_dayNight == "PM"){
                          if(_hour == 12){
                            hour = 12;
                          } else {
                            hour = _hour + 12;
                          }
                        } else {
                          if(_hour == 12){
                            hour = 0;
                          } else {
                            hour = _hour;
                          }
                        }
                        work.time = DateTime(work.time!.year,
                            work.time!.month,
                            work.time!.hour < hour ? work.time!.day +
                                1 : work.time!.day,
                            hour, _minute, 0);
                         databaseHelper.updateReminder(work);
                        setSettings(work);
                        popScreen(context, argument: work);
                      }
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: linearGradient,
                      ),
                      alignment: Alignment.center,
                      child: Text(doneTxt.tr(), style: const TextStyle(fontSize: 24,
                          color: Colors.white, fontWeight: FontWeight.bold),), ),
                  ),
                ),
              ),
              SizedBox(height: 20,)

            ],
          ),
        ),
      ),
    );
  }

  void setSettings(ReminderWorkout reminder){
    // final alarmSettings = AlarmSettings(
    //   id: reminder.id!,
    //   dateTime: reminder.time!,
    //   assetAudioPath: 'assets/sounds/alarm.mp3',
    //   loopAudio: true,
    //   vibrate: true,
    //   fadeDuration: 3.0,
    //   notificationTitle: 'Fitness',
    //   notificationBody: 'Time to train',
    //   enableNotificationOnKill: true,
    //   stopOnNotificationOpen: true
    // );
    // Alarm.set(alarmSettings: alarmSettings);
  }

  Widget bedTimeChooser(Function(int) hour, Function(int) minute, Function(String) dayNight,
      {double height = 200, double width = 100}){
    return Stack(
      children: [
        Positioned(
          top: height / 9 *3,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 20,
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xff97999F).withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WheelChooser.integer(
                onValueChanged: (s) => hour(s),
                maxValue: 12,
                minValue: 1,
                initValue: _hour,
                horizontal: false,
                isInfinite: true,
                selectTextStyle: const TextStyle(color: Colors.black),
                listHeight: height,
                listWidth: width,
                unSelectTextStyle: const TextStyle(color: Colors.grey),
              ),
              WheelChooser.integer(
                onValueChanged: (s) => minute(s),
                maxValue:  59 ,
                minValue: 0,
                initValue: _minute,
                horizontal: false,
                isInfinite: true,
                selectTextStyle: const TextStyle(color: Colors.black),
                listHeight: height,
                listWidth: width,
                unSelectTextStyle: const TextStyle(color: Colors.grey),
              ),
              WheelChooser(
                onValueChanged: (s) => dayNight(s),
                datas: tmpMinute,
                selectTextStyle: const TextStyle(color: Colors.black, fontFamily: 'TT_Norms'),
                listHeight: height,
                listWidth: width,
                unSelectTextStyle: const TextStyle(color: Colors.grey, fontFamily: 'TT_Norms'),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget dayItem(bool isSelected, String text, int position){
    final size = MediaQuery.of(context).size.width / 9;
    return InkWell(
      onTap: (){
        daysOfWeek[position] = !isSelected;
        setState(() {});
      },
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: isSelected ? linearGradient : null,
          borderRadius: const BorderRadius.all(Radius.circular(200))
        ),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
            color: isSelected ?  Colors.white : Colors.black),),
      ),
    );
  }
}
