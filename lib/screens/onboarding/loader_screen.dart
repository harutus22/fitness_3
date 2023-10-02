import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/user_info_enums.dart';
import 'package:fitness/utils/calculations.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/const.dart';
import '../../utils/routes.dart';
import '../main_menu_screen.dart';

class LoaderScreen extends StatefulWidget {
  LoaderScreen({Key? key}) : super(key: key);

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> with TickerProviderStateMixin{
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    setUser(user);
    super.initState();
  }

  final list = [
    LoaderItem(isActive: false,
        title: analyzing_profile.tr(),
        body: "${user.weight}${kg.tr()}, ${user.height}${cm.tr()}"),
    LoaderItem(isActive: false,
        title: calculating_metabolism.tr(),
        body: "${user.gender == Gender.male ?
        basalMetabolicRateMale(user):
        basalMetabolicRateFemale(user)
        }${kcalText.tr()}"),
  ];

  @override
  Widget build(BuildContext context) {

    start(context);
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 20,),
              Image.asset(
                "assets/images/loading_image.png",
                height: MediaQuery.of(context).size.height / 8,),
              SizedBox(height: 20,),
              Text(
                creating_your_plan.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black
                ),),
            ],
          ),

          Center(
            child: Lottie.asset('assets/loader/onboard_calculation.json', controller: _controller,
            onLoaded: (composition){
              Future.delayed(Duration(seconds: 3), (){
                list[0].isActive = true;
                Future.delayed(Duration(seconds: 2), (){
                  list[1].isActive = true;
                  setState(() {});
                });
                setState(() {});
              });

              _controller
                ..duration = composition.duration
                ..forward();
              _controller.addListener(() {
                print("asdas");
              });
              _controller.addStatusListener((status) async {
                if (status == AnimationStatus.completed) {

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                    return MainMenuScreen();
                  }), (r){
                    return false;
                  });
                }
              });
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _item(list[0]),
                SizedBox(height: 10,),
                list[0].isActive ? _item(list[1]): SizedBox(),
              ],
            ),
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void start(BuildContext context) async {
    await databaseHelper.init();
    // databaseHelper.getWorkoutModels().then((value) async {
    //   // final dir = await getApplicationDocumentsDirectory();
    //   // for(var item in value){
    //   //   var video = ref.child("training_videos").child("${item.id}.mp4");
    //   //   final file = File("${dir.path}/training_video/${video.name}");
    //   //   final a = await video.writeToFile(file);
    //   //   print(a);
    //   // }
    //   Future.delayed(const Duration(milliseconds: 4000), () {
    //     // changeScreen(payWallScreen, context);
    //   });
    // });
    ;
  }

  Widget _item(LoaderItem item){
    return Row(
      children: [
        item.isActive ?
        Icon(
          Icons.check,
          size: 26,
          color:  Color(0xff1EAA56),):
        Container(height: 20, width: 20, child: CircularProgressIndicator(color: Color(0xffD9D9D9),)),
        SizedBox(width: 10,),
        RichText(
            text: TextSpan(
              style: TextStyle(
                color: item.isActive ? Colors.black : Colors.black.withOpacity(0.3),
                fontSize: 18
              ),
          children: [
            TextSpan(
              text: item.title,
            ),
            WidgetSpan(child: SizedBox(width: 5,)),
            TextSpan(
              text: item.body,
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            )
          ]
        ))
      ],
    );
  }
}

class LoaderItem{
  bool isActive;
  String title;
  String body;

  LoaderItem({
    required this.isActive,
    required this.title,
    required this.body,
});
}
