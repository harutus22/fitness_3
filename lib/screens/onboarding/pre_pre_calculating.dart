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

class PrePreCalculatingScreen extends StatefulWidget {
  const PrePreCalculatingScreen({Key? key}) : super(key: key);

  @override
  State<PrePreCalculatingScreen> createState() => _PrePreCalculatingScreenState();
}

class _PrePreCalculatingScreenState extends State<PrePreCalculatingScreen> {

  bool isNextActive = false;
  int _itemChosen = -1;


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
                TopBarItem(count: 16),
                SizedBox(height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text("NAME was made for people just like you!",
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
            CarouselSlider(
              carouselController: CarouselController(),
              items: [
                image("assets/images/photo_1.png"),
                image("assets/images/photo_2.png"),
                image("assets/images/photo_3.png"),
                image("assets/images/photo_4.png"),
              ],
              options: CarouselOptions(
                autoPlay: false,
                enableInfiniteScroll: true,
                viewportFraction: 0.4,
                enlargeFactor: 0.7,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                initialPage: 1,
                scrollPhysics: ClampingScrollPhysics(),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                style: TextStyle(
                  fontFamily: mainFont,
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(text: "83% ", style: TextStyle(
                    color: Color(0xffF42020),
                    fontSize: 30
                  )),
                  TextSpan(text: "of NAME users", style: TextStyle(
                      color: Colors.black,
                      fontSize: 28
                  )),
                  TextSpan(text: "\nclaim that the workout plan we offer is easy to follow and makes it simple to stay on track.", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal
                  )),
                ]
              )),
            ),

            SizedBox(height: 20,),
            next(context, preCalculationScreen, true, () {
              sendEvent("onboarding_5");
            }),
            SizedBox(height: 0,),
          ],
        ),
      ),
    );
  }

  Widget image(String image){
    return Image.asset(image);
  }
}