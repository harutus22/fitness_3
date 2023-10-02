import 'package:carousel_slider/carousel_slider.dart';
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

class PreCalculatingScreen extends StatefulWidget {
  const PreCalculatingScreen({Key? key}) : super(key: key);

  @override
  State<PreCalculatingScreen> createState() => _PreCalculatingScreenState();
}

class _PreCalculatingScreenState extends State<PreCalculatingScreen> {

  bool isNextActive = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset("assets/images/back_helped.png",
            height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Align(alignment: Alignment.bottomRight,
                              child: backButton(context)),
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
                    TopBarItem(count: 17),
                    SizedBox(height: 10,
                    ),
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: RichText(
                        textAlign: TextAlign.center,
                          text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black
                        ),
                        children: [
                          TextSpan(
                            text: weve_helped.tr()
                          ),
                          TextSpan(
                              text: " 194,578 ",
                            style: TextStyle(
                              color: Color(0xffF42020)
                            )
                          ),
                          TextSpan(
                              text: weve_helped_2.tr()
                          ),
                        ]
                      )),
                    ),
                    SizedBox(height: 20,),
                    next(context, loaderScreen, true, () {
                      sendEvent("onboarding_5");
                    }),
                    SizedBox(height: 20,)
                  ],
                )

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget image(String image){
    return Image.asset(image);
  }
}