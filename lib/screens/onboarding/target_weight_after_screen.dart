import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/Routes.dart';
import 'package:flutter/material.dart';

import '../../custom_class/bar_item.dart';
import '../../utils/back_button.dart';
import '../../utils/const.dart';
import '../../utils/next_button.dart';
import '../../utils/words.dart';

class TargetWeightAfterScreen extends StatelessWidget {
  const TargetWeightAfterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final isLosing = user.weight <= user.targetWeight;
    final resultWeight = isLosing ? user.targetWeight - user.weight : user.weight - user.targetWeight;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/images/fireworks_1.png"),
          ),
          Positioned(
            top: height / 10,
              child: Image.asset("assets/images/fireworks.png")
          ),
          Positioned(
              top: height / 4,
              right: width / 8,
              child: Image.asset("assets/images/fireworks_2.png")
          ),
          SafeArea(
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
                    SizedBox(height: 10,),
                    TopBarItem(count: 8),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      Image.asset("assets/images/like.png", height: 50,),
                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.center,
                          text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                        children: [
                          TextSpan(text: isLosing ? gaining_txt.tr() : loosing_txt.tr()),
                          TextSpan(text: " ${resultWeight.toStringAsFixed(1)}${kg.tr()} ",
                          style: TextStyle(
                            color: Colors.red
                          )),
                          TextSpan(text: loosing_txt_2.tr()),
                          // TextSpan(text: loosing_txt_3.tr()),
                        ]
                      ))
                    ],
                  ),
                ),
                Column(
                  children: [
                    next(
                        context,
                        userAgeScreen,
                        true, () {
                      sendEvent("onboarding_10");
                    }),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
