import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../custom_class/bar_item.dart';
import '../../custom_class/line_drawer.dart';
import '../../model/user_info_enums.dart';
import '../../utils/back_button.dart';
import '../../utils/calculations.dart';
import '../../utils/const.dart';
import '../../utils/input_formater/weight_input_formatter.dart';
import '../../utils/next_button.dart';
import '../../utils/routes.dart';

class TargetWeightScreen extends StatefulWidget {
  const TargetWeightScreen({Key? key}) : super(key: key);

  @override
  State<TargetWeightScreen> createState() => _TargetWeightScreenState();
}

class _TargetWeightScreenState extends State<TargetWeightScreen> {
  bool isNextActive = true;
  bool lowerMinimum = false;
  double weight = 0;
  bool isKgChecked = true;
  double chooseHeight = 0;
  double chooseWidth = 0;
  int _selectedItemIndex = 100;
  late FixedExtentScrollController scrollController;
  late List<int> kgList;
  late List<double> lbList;
  double percentage = 0;
  Timer? future;

  final commentList = [
    continuous_health_benefits.tr(),
    see_more_significant_benefits.tr(),
    you_are_in_good_shape.tr(),
    moderately_weight_gain.tr(),
    evidence_of_overweight.tr(),
    evidence_obese_related.tr(),
  ];


  @override
  void initState() {
    scrollController =
        FixedExtentScrollController(initialItem: _selectedItemIndex);
    kgList = List.generate(200, (index) => 40 + index);
    lbList = List.generate(200, (index) => kgList[index] * 2.205);
    percentage = isKgChecked ? kgList[_selectedItemIndex].toDouble() : lbList[_selectedItemIndex].toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chooseWidth = MediaQuery.of(context).size.width * 0.25;
    chooseHeight = MediaQuery.of(context).size.height * 0.04;
    final list = isKgChecked ? kgList : lbList;
    Color color;
    String text = "";
    String title = "";
    final userWeight = user.weight;
    final isForGain = user.weight <= kgList[_selectedItemIndex];
    final item = kgList[_selectedItemIndex];
    percentage = !isForGain
        ? userWeight / item * 100 -100
        : item / userWeight * 100 - 100;
    if (percentage <= 10) {
      color = Color(0xff44B564);
      text = commentList[2];
      title = easy_win.tr();
    } else if ((percentage > 10 && percentage <= 20)) {
      color = Color(0xff1315FC);
      text = commentList[Random().nextInt(commentList.length)];
      title = reasonable_goal.tr();
    } else {
      color = Color(0xffF42020);
      text = commentList[Random().nextInt(commentList.length)];
      title = challenging_goal.tr();
    }

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
                        child: Text(body_data.tr(),
                          style: TextStyle(
                              fontFamily: mainFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),))
                  ],
                ),
              ),
              TopBarItem(count: 7),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                      what_goal_weight.tr().tr(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: onboardingTextSize,
                      )
                  )
              ),
              // MenuGridView(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: chooseWidth,
                    height: chooseHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              isKgChecked = true;
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: chooseHeight,
                              decoration: isKgChecked
                                  ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              )
                                  : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                kg.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: !isKgChecked ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              isKgChecked = false;
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: chooseHeight,
                              decoration: isKgChecked
                                  ? BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              )
                                  : BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),

                              child: Text(
                                lb.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isKgChecked ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        list[_selectedItemIndex]
                            .toStringAsFixed(isKgChecked ? 0 : 1),
                        style: TextStyle(
                          fontSize: 60,
                          fontFamily: mainFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isKgChecked ? kg.tr() : lb.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: mainFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: ListWheelScrollView.useDelegate(
                        diameterRatio: 1,
                        perspective: 0.001,
                        physics: FixedExtentScrollPhysics(),
                        controller: scrollController,
                        itemExtent: 10,
                        squeeze: 1,
                        onSelectedItemChanged: (newIndex) {
                          setState(() {
                            _selectedItemIndex = newIndex;
                            user.targetWeight = kgList[newIndex].toDouble();
                          });
                        },
                        childDelegate: ListWheelChildLoopingListDelegate(
                          children: list.map((e) {
                            final value = list.indexOf(e);
                            return RotatedBox(
                                quarterTurns: 1,
                                child: CustomPaint(
                                  painter: CustomLine(
                                      index: value,
                                      current: _selectedItemIndex == value
                                          ? true
                                          : false),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Color(0xff0E1618).withOpacity(0.4)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: mainFont,
                              color: color,
                              fontSize: 20),
                        ),
                        SizedBox(height: 5,),
                        RichText(text: TextSpan(
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: isForGain ? you_will_gain.tr() : target_weight_lose.tr(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                            ),
                            TextSpan(
                              text: " ${(percentage).toStringAsFixed(1)}% ",
                              style: TextStyle(
                                color: color
                              )
                            ),
                            TextSpan(
                              text: of_your_weight.tr()
                            )
                          ]
                        )),
                        SizedBox(height: 5,),
                        Text(text, style: TextStyle(
                            fontSize: 14
                          ))
                        // Flexible(child: Text(text,
                        // style: TextStyle(
                        //   fontSize: 14
                        // ),))
                      ],
                    ),
                  )
                ],
              ),
              next(
                  context,
                  targetWeightAfterScreen,
                  isNextActive, () {
                // FocusManager.instance.primaryFocus?.unfocus();
                if (!isKgChecked) {
                  weight = weight * 0.45;
                }
                sendEvent("onboarding_10");
                // user.targetWeight = weight;
              }),
              const SizedBox()
            ],
          )),
    );
  }


  void futureJob(Function callback){
    if(future != null){
      if(future!.isActive){
        future!.cancel();
        future = Timer(Duration(milliseconds: 500), () {
          callback();
        });
      } else {
        future = Timer(Duration(milliseconds: 500), () {
          callback();
        });
      }
    } else {
      future = Timer(Duration(milliseconds: 500), () {
        callback();
      });
    }
  }
}
