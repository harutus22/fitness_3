import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/input_formater/height_input_formatter.dart';
import 'package:fitness/utils/routes.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../custom_class/bar_item.dart';
import '../../utils/back_button.dart';
import '../../utils/const.dart';
import '../../utils/next_button.dart';

class UserHeightScreen extends StatefulWidget {
  const UserHeightScreen({Key? key}) : super(key: key);

  @override
  State<UserHeightScreen> createState() => _UserHeightScreenState();
}

class _UserHeightScreenState extends State<UserHeightScreen> {
  bool isNextActive = true;
  double height = 0;
  bool isCmChecked = true;
  double chooseHeight = 0;
  double chooseWidth = 0;
  final _userController = TextEditingController();

  @override
  void initState() {
    cmList = List.generate(200, (index) => 50 + index);
    ftList = List.generate(200, (index) => cmList[index] * 0.0348);
    scrollController = FixedExtentScrollController(initialItem: _selectedItemIndex);
    _changeInitial(haveScroll: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    chooseWidth = size.width * 0.25;
    chooseHeight = size.height * 0.04;
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
          TopBarItem(count: 5),
          RichText(
            text: TextSpan(
                text: what_height.tr(),
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: mainFont,
                  fontWeight: FontWeight.w900,
                  fontSize: onboardingTextSize,
                )),
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
                    border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          isCmChecked = true;
                          _userController.clear();
                          _changeInitial();
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: chooseHeight,
                          decoration: isCmChecked
                              ? BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          )
                              : BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cm.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: !isCmChecked ? colorGreyText : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          isCmChecked = false;
                          _userController.clear();
                          _changeInitial();
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: chooseHeight,
                          decoration: isCmChecked
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                ),
                          child: Text(
                            ft.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isCmChecked ? colorGreyText : Colors.white,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: bedTimeChooser((p0) => height = p0.toDouble(),
                    height: MediaQuery.of(context).size.height / 2)
              ),
            ],
          ),
          next(context, userCurrentWeightScreen, isNextActive, () {
            height = cmList[_selectedItemIndex].toDouble();
            sendEvent("onboarding_8");
            user.height = height;
          }),
          const SizedBox()
        ],
      )),
    );
  }

  int _selectedItemIndex = 100;
  int _initialItemIndex = 100;
  late List<int> cmList;
  late List<double> ftList;
  late FixedExtentScrollController scrollController;

  void _changeInitial({bool haveScroll = true}){
    if(isCmChecked && _initialItemIndex == -1){
      _initialItemIndex = 100;
    } else if(isCmChecked && _initialItemIndex != -1) {
      _initialItemIndex = _selectedItemIndex;

    } else if(!isCmChecked && _initialItemIndex == -1){
      _initialItemIndex = 110;
    } else if(!isCmChecked && _initialItemIndex != -1) {
      _initialItemIndex = _selectedItemIndex;
    }
    // _selectedItemIndex = _initialItemIndex;
    if(haveScroll)
      scrollController.jumpToItem(_initialItemIndex);
  }

  Widget bedTimeChooser(Function(int) userHeight,
      {double height = 200, double width = 100}){
    // final list =
    final list = isCmChecked ? cmList : ftList;

    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Center(
            child: Container(height: height  / 6, decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide.merge(
                    BorderSide(width: 2, color: mainColor),
                    BorderSide(width: 2, color: mainColor)))
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height,
                width: width - 30,
                child: ListWheelScrollView.useDelegate(
                    controller: scrollController,
                  physics: FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
              setState(() {
              _selectedItemIndex = index;
              });
              }, itemExtent: height / 6, childDelegate: ListWheelChildLoopingListDelegate(
                  children: list.map((e) {

                    final item = _selectedItemIndex == list.indexOf(e);
                    final itemAbove1 = _selectedItemIndex == list.indexOf(e) - 1;
                    final itemAbove2 = _selectedItemIndex == list.indexOf(e) - 2;
                    final itemBelow1 = _selectedItemIndex == list.indexOf(e) + 1;
                    final itemBelow2 = _selectedItemIndex == list.indexOf(e) + 2;
                    double fontSize = 10;
                    if(item) {
                      fontSize = 30;
                    } else if(itemAbove1 || itemBelow1){
                      fontSize  = 25;
                    } else if(itemAbove2 || itemBelow2){
                      fontSize = 20;
                    } else {
                      fontSize = 15;
                    }
                    return Container(
                    child: Center(
                      child: Text(
                        e.toStringAsFixed(isCmChecked ? 0 : 2),
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: item ? FontWeight.bold : FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );}).toList()
                )),
              ),
              Container(
                height: height / 12,
                alignment: Alignment.bottomCenter,
                child: Text(isCmChecked ? cm.tr() : " ${ft.tr()}",
                  style: TextStyle(fontSize: 16),),
              )
            ],
          ),

        ],
      ),
    );
  }
}
