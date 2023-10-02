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

class PreferredLevelOfWorkoutsScreen extends StatefulWidget {
  const PreferredLevelOfWorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<PreferredLevelOfWorkoutsScreen> createState() => _PreferredLevelOfWorkoutsScreenState();
}

class _PreferredLevelOfWorkoutsScreenState extends State<PreferredLevelOfWorkoutsScreen> {

  bool isNextActive = false;
  int _itemChosen = -1;

  final list = [
    CheckBoxMotivationState(
        title: easy_enough.tr(), motivation: Motivations.feelConfident, image: "assets/images/easy_enough.png"),
    CheckBoxMotivationState(
        title: a_bit_sweaty.tr(), motivation: Motivations.releaseStress, image: "assets/images/simple.png"),
    CheckBoxMotivationState(
        title: somewhat_challenging.tr(), motivation: Motivations.improveHealth, image: "assets/images/somewhat.png"),
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
                            child: Text(about_you.tr(),
                              style: TextStyle(
                                  fontFamily: mainFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),))
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  TopBarItem(count: 10),
                  SizedBox(height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(choose_lvl_workouts.tr(),
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
                      listItem(list[0], easy_enough_title.tr(), easy_enough_body.tr(), 0),
                      listItem(list[1], a_bit_sweaty_title.tr(), a_bit_sweaty_body.tr(), 1),
                      listItem(list[2], somewhat_challenging_title.tr(), somewhat_challenging_body.tr(), 2)
                    ],
                  ),
                  SizedBox(height: 20,),
                  next(context, typicalDayLookLikeScreen, isNextActive, () {
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

  Widget listItem(CheckBoxMotivationState item, String title, String body, int number) {
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
        _itemChosen == number ? Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Color(0xffD9D9D9),
                  width: 1
              ),
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),
              SizedBox(height: 5,),
              Text(body, style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.5)
              ),)
            ],
          ),
        ) : SizedBox(),
      ],
    );
  }
}
