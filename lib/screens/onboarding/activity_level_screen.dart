import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../custom_class/bar_item.dart';
import '../../utils/back_button.dart';
import '../../utils/const.dart';
import '../../utils/next_button.dart';
import '../../utils/routes.dart';
import '../../utils/words.dart';

class ActivityLevelScreen extends StatefulWidget {
  const ActivityLevelScreen({Key? key}) : super(key: key);

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {

  int _selectedIndex = 0;

  final images = [
    "assets/images/activity_not_active.png",
    "assets/images/activity_lightly_active.png",
    "assets/images/active_moderately_active.png",
    "assets/images/active_highly_active.png",
  ];

  final titles = [
    not_active.tr(),
    lightly_active.tr(),
    moderately_active.tr(),
    highly_active.tr()
  ];

  final bodies = [
    not_active_txt.tr(),
    lightly_active_txt.tr(),
    moderately_active_txt.tr(),
    highly_active_txt.tr()
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
                TopBarItem(count: 12),
                SizedBox(height: 10,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(choose_activity.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: mainFont,
                  fontWeight: FontWeight.bold,
                  fontSize: onboardingTextSize,
                ),),
            ),
            Image.asset(images[_selectedIndex],
            width: MediaQuery.of(context).size.width *0.7,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                titles[_selectedIndex],
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                bodies[_selectedIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black
                ),
              ),
            ),

            Column(
              children: [
                SfSliderTheme(
                  data: SfSliderThemeData(
                    activeTrackHeight: 20,
                    inactiveTrackHeight: 20,
                    inactiveDividerRadius: 8,
                    activeDividerRadius: 8,
                      activeDividerColor:  const Color(0xff919BA9),
                      inactiveDividerColor: const Color(0xff919BA9),
                    thumbStrokeWidth: 2,
                    thumbColor: Colors.white,
                    thumbStrokeColor: mainColor,
                    activeTrackColor: const Color(0xffD9D9D9).withOpacity(0.3),
                    inactiveTrackColor: const Color(0xffD9D9D9).withOpacity(0.3),
                    thumbRadius: 16
                  ),
                  child: SfSlider(
                      value: _selectedIndex,
                      min: 0,
                      max: 3,
                      interval: 1,
                    // showTicks: true,
                    showLabels: false,
                      showDividers: true,
                      onChanged: (dynamic value){
                        setState(() {
                          _selectedIndex = (value as double).round();
                        });
                      },
                    // activeColor: Color(0xffD9D9D9).withOpacity(0.3),
                    // inactiveColor: Color(0xffD9D9D9).withOpacity(0.3),
                    thumbIcon: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(100))
                      ),
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(not_active.tr()),
                      Text(highly_active.tr()),
                    ],
                  ),
                )
              ],
            ),
            next(context, fitnessLevelScreen, true, () {
              sendEvent("onboarding_5");
            }),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
