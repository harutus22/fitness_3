import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/Routes.dart';
import '../../utils/back_button.dart';
import '../../utils/const.dart';
import '../../utils/next_button.dart';
import '../../utils/words.dart';

class TrainingSetScreen extends StatefulWidget {
  const TrainingSetScreen({Key? key}) : super(key: key);

  @override
  State<TrainingSetScreen> createState() => _TrainingSetScreenState();
}

class _TrainingSetScreenState extends State<TrainingSetScreen> {

  bool isNextActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: backButton(context)),
                  Expanded(
                      flex: 3,
                      child: Image.asset(
                        "assets/images/onboard_5.png",
                        alignment: Alignment.centerLeft,
                      ))
                ],
              ),
              Text(
                focusArea.tr(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w900, fontSize: onboardingTextSize),
              ),
              // MenuGridView(),

              next(context, mainGoalScreen, isNextActive, () {

              }),

              const SizedBox()
            ],
          )),
    );
  }
}
