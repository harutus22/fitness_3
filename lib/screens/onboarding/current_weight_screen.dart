import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/custom_class/line_drawer.dart';
import 'package:fitness/utils/calculations.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../custom_class/bar_item.dart';
import '../../utils/back_button.dart';
import '../../utils/const.dart';
import '../../utils/input_formater/weight_input_formatter.dart';
import '../../utils/next_button.dart';
import '../../utils/routes.dart';

class CurrentWeightScreen extends StatefulWidget {
  const CurrentWeightScreen({Key? key}) : super(key: key);

  @override
  State<CurrentWeightScreen> createState() => _CurrentWeightScreenState();
}

class _CurrentWeightScreenState extends State<CurrentWeightScreen> {
  bool isNextActive = true;
  bool lowerMinimum = false;
  double weight = 0;
  bool isKgChecked = true;
  double chooseHeight = 0;
  double chooseWidth = 0;
  late List<int> kgList;
  late List<double> lbList;

  @override
  void initState() {
    scrollController =
        FixedExtentScrollController(initialItem: _selectedItemIndex);
    kgList = List.generate(200, (index) => 40 + index);
    lbList = List.generate(200, (index) => kgList[index] * 2.205);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = isKgChecked ? kgList : lbList;
    chooseWidth = MediaQuery.of(context).size.width * 0.25;
    chooseHeight = MediaQuery.of(context).size.height * 0.04;
    final massIndex = massIndexCalculation();
    Color color;
    String text = "";
    if (massIndex >= 18.5 && massIndex <= 25) {
      color = Color(0xff44B564);
      text = great_figure.tr();
    } else if ((massIndex >= 16 && massIndex < 18.5) ||
        (massIndex > 25 && massIndex <= 30)) {
      color = Color(0xff1315FC);
      text = better_shape_exercise.tr();
    } else {
      color = Color(0xffF42020);
      text = great_fitter_exercise.tr();
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
                Align(
                    alignment: Alignment.bottomRight,
                    child: backButton(context)),
                Center(
                    child: Text(
                  body_data.tr(),
                  style: TextStyle(
                      fontFamily: mainFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))
              ],
            ),
          ),
          TopBarItem(count: 6),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(what_current_weight.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: onboardingTextSize,
                  ))),
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
                    border: Border.all(color: Colors.black)),
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
                        user.weight = kgList[newIndex].toDouble();
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
                      your_bmi.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: mainFont,
                          fontSize: 20),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          massIndex.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: color),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(child: Text(text))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          next(context, userTargetWeightScreen, isNextActive, () {
            weight = kgList[_selectedItemIndex].toDouble();
            sendEvent("onboarding_9");
            user.weight = weight;
          }),
          const SizedBox()
        ],
      )),
    );
  }

  int _selectedItemIndex = 100;
  late FixedExtentScrollController scrollController;
  Timer? future;

  void futureJob(Function callback) {
    if (future != null) {
      if (future!.isActive) {
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
