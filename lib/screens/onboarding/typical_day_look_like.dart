import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../custom_class/bar_item.dart';
import '../../model/custom_check_box_motivation_model.dart';
import '../../model/user_info_enums.dart';
import '../../utils/back_button.dart';
import '../../utils/colors.dart';
import '../../utils/const.dart';
import '../../utils/next_button.dart';
import '../../utils/routes.dart';
import '../../utils/words.dart';

class TypicalDayLookLikeScreen extends StatefulWidget {
  const TypicalDayLookLikeScreen({Key? key}) : super(key: key);

  @override
  State<TypicalDayLookLikeScreen> createState() => _TypicalDayLookLikeScreenState();
}

class _TypicalDayLookLikeScreenState extends State<TypicalDayLookLikeScreen> {

  bool isNextActive = false;
  int _itemChosen = -1;

  final list = [
    CheckBoxMotivationState(
        title: at_work.tr(), motivation: Motivations.feelConfident, image: "assets/images/typical_at_work.png"),
    CheckBoxMotivationState(
        title: at_home.tr(), motivation: Motivations.releaseStress, image: "assets/images/typical_at_home.png"),
    CheckBoxMotivationState(
        title: walking_daily.tr(), motivation: Motivations.improveHealth, image: "assets/images/typical_walking_daily.png"),
    CheckBoxMotivationState(
        title: working_on_foot.tr(), motivation: Motivations.releaseStress, image: "assets/images/typical_working_mostly.png"),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Align(alignment: Alignment.bottomRight, child: backButton(context)),
                        Center(
                            child: Text(fitness_analysis.tr(),
                              style: TextStyle(
                                  fontFamily: mainFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),))
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  TopBarItem(count: 11),
                  SizedBox(height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(typical_day_look_like.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: mainFont,
                        fontWeight: FontWeight.bold,
                        fontSize: onboardingTextSize,
                      ),),
                  ),
                ],
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      listItem(list[0], 0),
                      listItem(list[1], 1),
                      listItem(list[2], 2),
                      listItem(list[3], 3)
                    ],
                  ),
                  SizedBox(height: 20,),
                  next(context, activityLevelScreen, isNextActive, () {
                    sendEvent("onboarding_5");
                  }),
                  SizedBox(height: 20,),
                ],
              ),

            ],
          ),
      ),
    );
  }

  Widget listItem(CheckBoxMotivationState item, int number) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 10,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: number != _itemChosen
                    ? BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color(0xffCDCDCF),
                      width: 1
                  ),
                )
                    : BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.black,
                        width: 3
                    ),
                    color: mainColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(item.image, height: 30,),
                    SizedBox(width: 10,),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              _itemChosen = number;
              isNextActive = true;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
