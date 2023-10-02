import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/routes.dart';
import 'package:fitness/utils/input_formater/age_input_formatter.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../custom_class/bar_item.dart';
import '../../utils/back_button.dart';
import '../../utils/const.dart';
import '../../utils/next_button.dart';

class UserAgeScreen extends StatefulWidget {
  const UserAgeScreen({Key? key}) : super(key: key);

  @override
  State<UserAgeScreen> createState() => _UserAgeScreenState();
}

class _UserAgeScreenState extends State<UserAgeScreen> {

  bool isNextActive = true;
  int pageNumber = 0;
  int age = 0;
  int _selectedItemIndex = 20;
  late FixedExtentScrollController scrollController;
  final list = List.generate(86, (index) =>  14 + index);

  @override
  void initState() {
    scrollController = FixedExtentScrollController(initialItem: _selectedItemIndex);
    super.initState();
  }

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
                        child: Text(about_you.tr(),
                          style: TextStyle(
                              fontFamily: mainFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),))
                  ],
                ),
              ),
              TopBarItem(count: 9),
              RichText(
                text: TextSpan(
                    text: what_age.tr(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: mainFont,
                      fontWeight: FontWeight.w900,
                      fontSize: onboardingTextSize,
                    )),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.4))
                ),
                child: Row(
                  children: [
                    Image.asset("assets/images/light_bulb.png", height: 40,),
                    SizedBox(width: 5,),
                    Flexible(child: Text(age_helper_txt.tr()))
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: bedTimeChooser((p0) => age = p0,
                      height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width)
              ),
              next(context, preferredLevelOfWorkouts, isNextActive, () {
                sendEvent("onboarding_7");
                user.age = age;
              }),
              const SizedBox()
            ],
          )),
    );
  }

  Widget bedTimeChooser(Function(int) userHeight,
      {double height = 200, double width = 150}){
    // final list =
    

    return Container(
      height: height,
      width: width / 2,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: height,
                width: width/6,
                child: ListWheelScrollView.useDelegate(
                    controller: scrollController,
                    squeeze: 1.2,
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
                        fontSize = 40;
                      } else if(itemAbove1 || itemBelow1){
                        fontSize  = 30;
                      } else if(itemAbove2 || itemBelow2){
                        fontSize = 20;
                      } else {
                        fontSize = 10;
                      }
                      return Container(
                        child: Center(
                          child: Text(
                            e.toStringAsFixed(0),
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
                child: Text(years_old_txt.tr(),
                  style: TextStyle(fontSize: 16),),
              )
            ],
          ),

        ],
      ),
    );
  }
}
