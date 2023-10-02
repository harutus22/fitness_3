import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/custom_class/bar_item.dart';
import 'package:fitness/model/custom_check_box_motivation_model.dart';
import 'package:fitness/model/user_info_enums.dart';
import 'package:fitness/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../utils/back_button.dart';
import '../../utils/colors.dart';
import '../../utils/next_button.dart';
import '../../utils/routes.dart';
import '../../utils/words.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({Key? key}) : super(key: key);

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  bool isNextActive = false;
  final list = [
    CheckBoxMotivationState(
        title: look_better.tr(), motivation: Motivations.feelConfident, image: "assets/images/motiv_look_better.png"),
    CheckBoxMotivationState(
        title: body_for_summer.tr(), motivation: Motivations.releaseStress, image: "assets/images/motiv_body_for_summer.png"),
    CheckBoxMotivationState(
        title: feel_confident.tr(), motivation: Motivations.improveHealth, image: "assets/images/motiv_like.png"),
    CheckBoxMotivationState(
        title: find_self_love.tr(), motivation: Motivations.boostEnergy, image: "assets/images/motiv_self_love.png"),
    CheckBoxMotivationState(
        title: get_shaped.tr(), motivation: Motivations.getShaped, image: "assets/images/motiv_muscle.png"),
  ];
  List<Motivations> _motivations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          TopBarItem(count: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              motivation.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w900, fontSize: onboardingTextSize),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              listItem(list[0]),
              listItem(list[1]),
              listItem(list[2]),
              listItem(list[3]),
              listItem(list[4]),
            ],
          ),
          next(context, mainGoalScreen, isNextActive, () {
            for(var item in list) {
              if(item.value) {
                _motivations.add(item.motivation);
              }
            }
            sendEvent("onboarding_5");
            user.motivations = _motivations;
          }),
          const SizedBox()
        ],
      )),
    );
  }

  Widget listItem(CheckBoxMotivationState item) {
    return Container(
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
            decoration: !item.value
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
                    width: 1
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
          item.value = !item.value;
          final a = list.where((element) => element.value == true).toList();
          if (a.isNotEmpty) {
            isNextActive = true;
          } else {
            isNextActive = false;
          }
          setState(() {});
        },
      ),
    );
  }
}
