import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/routes.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMainScreen extends StatefulWidget {
  const ProfileMainScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends State<ProfileMainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDate();
  }

  int completedTraining = 0;
  int kcalSpend = 0;
  int timePassed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10,),
              InkWell(
                onTap: () async {
                  if(user.isSubscribed == false){
                    await changeScreen(payWallScreen, context, argument: canPop);
                    setState(() {});
                  }
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/premium.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      user.isSubscribed == true ?
                      premium.tr() : becomePremium.tr(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        border: const GradientBoxBorder(
                          gradient: linearGradient,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))
                    ),
                    child: TableCalendar(
                      rowHeight: 40,
                      firstDay: DateTime.utc(2023, 1, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                      },
                      headerStyle: const HeaderStyle(
                        headerMargin: EdgeInsets.symmetric(vertical: 10),
                        titleCentered: true,
                        leftChevronPadding: EdgeInsets.zero,
                        rightChevronPadding: EdgeInsets.zero,
                      ),
                      calendarStyle: CalendarStyle(
                        cellMargin: const EdgeInsets.all(2),
                          defaultTextStyle: const TextStyle(color: Colors.black),
                          todayTextStyle: const TextStyle(color: Colors.black),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: linearGradient,
                          )),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          getByDate(selectedDay);
                        });
                      },
                      selectedDayPredicate: (day) {
                        return _selectedDay == day;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: const GradientBoxBorder(
                        gradient: linearGradient,
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: trainingItem(
                                "assets/images/profile_completed.png", completedTraining.toString())),
                        Expanded(
                            child: trainingItem(
                                "assets/images/profile_kcal.png", kcalSpend.toString())),
                        Expanded(
                            child: trainingItem(
                                "assets/images/profile_time.png", getTimeText(timePassed))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  menuItem("assets/images/profile_about_me.png", aboutMe.tr()),
                  const SizedBox(height: 20,),
                  menuItem("assets/images/profile_change_details.png", changeDetails.tr()),
                  const SizedBox(height: 20,),
                  menuItem("assets/images/profile_reminder.png", reminder.tr()),
                  const SizedBox(height: 20,),
                ],
              ),
              const SizedBox(height: 20,),
              const Divider( thickness: 3, color: Color(0xffEFF2F6)),
              const SizedBox(height: 20,),
              Column(
                children: [
                  menuItem("assets/images/profile_rate.png", rateUs.tr()),
                  const SizedBox(height: 20,),
                  menuItem("assets/images/profile_terms.png", termsCondition.tr()),
                  const SizedBox(height: 20,),
                  menuItem("assets/images/profile_privacy.png", privacy.tr()),
                  const SizedBox(height: 20,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trainingItem(String image, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 28,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        )
      ],
    );
  }

  Widget menuItem(String icon, String title) {
    return InkWell(
      onTap: (){
        if(title == aboutMe.tr()){
          changeScreen(profileAboutMeScreen, context);
        } else if(title == changeDetails.tr()){
          changeScreen(profileChangeDetailsScreen, context);
        } else if(title == reminder.tr()){
          changeScreen(profileReminderScreen, context);
        } else if(title == termsCondition){
          launchUrlCall(Uri.parse("https://sites.google.com/view/homeworkoutsformenwomen-te/home-workouts-for-men-women-terms-conditions"));
        } else {
          launchUrlCall(Uri.parse("https://sites.google.com/view/homeworkoutsformenwomen-privac/home-workouts-for-men-women-privacy-policy"));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(icon, height: 35,),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
              ),
            ],
          ),
          const Icon(
            Icons.navigate_next,
            color: Color(0xffCDCDCF),
          )
        ],
      ),
    );
  }

  void getCurrentDate(){
    final current = DateTime.now();
    final date = DateTime(current.year, current.month, current.day);
    databaseHelper.getTrainingDone(date.toIso8601String()).then((value) => {
    completedTraining = value.length,
      if(completedTraining == 0){
        kcalSpend = 0,
        timePassed = 0,
      } else
        {
          for(var item in value){
            kcalSpend += item.caloriesBurnt,
            timePassed += item.timePassed
          },
        },
      setState((){}),
    });
  }

  void getByDate(DateTime dateTime){
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    databaseHelper.getTrainingDone(date.toIso8601String()).then((value) => {
      completedTraining = value.length,
      if(completedTraining == 0){
        kcalSpend = 0,
        timePassed = 0,
      } else
        {
          for(var item in value){
            kcalSpend += item.caloriesBurnt,
            timePassed += item.timePassed
          },
        },
      setState((){}),
    });
  }

  String getTimeText(int time) {
    int minute = time ~/ 60;
    int seconds = time % 60;

    return "${minute.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}m";
  }

  DateTime? _selectedDay;
  DateTime? _focusedDay;
}
