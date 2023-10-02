import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/custom_check_box_main_goal_model.dart';
import 'package:fitness/model/user_info_enums.dart';
import 'package:fitness/utils/Routes.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../custom_class/bar_item.dart';
import '../../utils/back_button.dart';
import '../../utils/colors.dart';
import '../../utils/next_button.dart';

class MainGoalScreen extends StatefulWidget {
  const MainGoalScreen({Key? key}) : super(key: key);

  @override
  State<MainGoalScreen> createState() => _MainGoalScreenState();
}

class _MainGoalScreenState extends State<MainGoalScreen> {
  bool isNextActive = false;
  final list = [
    CheckBoxMainGoalState(
        title: lose_weight.tr(), mainGoal: MainGoal.loseWeight),
    CheckBoxMainGoalState(
        title: build_muscle.tr(), mainGoal: MainGoal.buildMuscle),
    CheckBoxMainGoalState(title: stay_fit.tr(), mainGoal: MainGoal.stayFit),
  ];
  int chosenItem = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Align(alignment: Alignment.bottomRight, child: backButton(context)),
                    Center(
                        child: Text(goal_txt.tr(),
                          style: TextStyle(
                              fontFamily: mainFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),))
                  ],
                ),
              ),
              TopBarItem(count: 3),
              Text(
                main_goal.tr(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900, fontSize: onboardingTextSize,
                fontFamily: mainFont),
              ),
              itemMainGoal(list[0], 0, user.gender == Gender.male ? "assets/images/goal_man_lose_weight.png" :"assets/images/goal_woman_lose_weight.png"),
              itemMainGoal(list[1], 1, user.gender == Gender.male ? "assets/images/goal_man_muscle.png" :"assets/images/goal_woman_muscle.png"),
              itemMainGoal(list[2], 2, user.gender == Gender.male ? "assets/images/goal_man_fit.png" :"assets/images/goal_woman_fit.png"),
              next(context, focusAreaScreen, isNextActive, () {
                user.mainGoal = list[chosenItem].mainGoal;
                sendEvent("onboarding_4");
              }),
              const SizedBox()
            ],
          )),
    );
  }

  Widget itemMainGoal(CheckBoxMainGoalState item, int checkNumber, String image) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius:10,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric( horizontal: 20),
            decoration: chosenItem != checkNumber
                ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorGreyBoarder),
            )
                : BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: mainColor,
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: Row(
              children: [
                Expanded(
                  flex:1,
                  child: Text(
                    item.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: mainFont,
                        fontSize: 24),
                  ),
                ),
                Expanded(flex: 1, child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(image,
                    fit: BoxFit.fitHeight,
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                ))
              ],
            ),
          ),
        ),
        onTap: () {
          chosenItem = checkNumber;
          isNextActive = true;
          setState(() {});
        },
      ),
    );
  }
}
