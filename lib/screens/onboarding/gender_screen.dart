import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/custom_class/bar_item.dart';
import 'package:fitness/custom_widgets/gender_image.dart';
import 'package:fitness/utils/Routes.dart';
import 'package:fitness/utils/back_button.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/next_button.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../model/user_info_enums.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  bool isGenderChosen = false;
  bool isNextActive = false;
  bool isMaleChosen = false;
  bool isFemaleChosen = false;
  int initialPage = 0;
  late GenderImage maleImg;
  late GenderImage femaleImg;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    maleImg = GenderImage(
      isClicked: isMaleChosen,
      image: "assets/images/male.png",
      gender: male,
      click: () {
        _maleChosen();
      },
    );
    femaleImg = GenderImage(
      isClicked: isFemaleChosen,
      image: "assets/images/female.png",
      gender: female,
      click: () {
        _femaleChosen();
      },
    );
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(height: 50,)
                ],
              ),
              TopBarItem(count: 1),
              SizedBox(height: 20,),
              Text(
                what_gender.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: onboardingTextSize,
                fontFamily: mainFont),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color(0xff0E1618).withOpacity(.4)
                  )
                ),
                child: Row(
                  children: [
                    Image.asset("assets/images/light_bulb.png", height: 40,),
                    SizedBox(width: 10,),
                    Flexible(child: Text(gender_help_text.tr(),
                    style: TextStyle(
                      fontFamily: mainFont
                    ),))
                  ],
                ),
              ),
              SizedBox(height: 60,),
              Container(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [maleImg, femaleImg],
                  )
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: next(context, motivationScreen, isNextActive,
                          wide: MediaQuery.of(context).size.width, (){
                        if(isMaleChosen) {
                          user.gender = Gender.male;
                        } else {
                          user.gender = Gender.female;
                        }
                      }),
                    ),
                    SizedBox(height: 30,)
                  ],
                ),
              ),
            ],
          )),
    );
  }
  dynamic callbackFunction(int index, CarouselPageChangedReason reason) async {
    if(index == 0) {
      _maleChosen();
    } else {
      _femaleChosen();
    }}

  void _maleChosen() {
    isGenderChosen = true;
    isMaleChosen = true;
    isFemaleChosen = false;
    isNextActive = true;
    initialPage = 0;
    buttonCarouselController.previousPage();
    setState(() {});
  }

  void _femaleChosen() {
    isGenderChosen = true;
    isFemaleChosen = true;
    isMaleChosen = false;
    isNextActive = true;
    initialPage = 1;
    buttonCarouselController.nextPage();
    setState(() {});
  }
}
