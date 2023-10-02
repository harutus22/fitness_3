import 'dart:async';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/custom_class/water_circle.dart';
import 'package:fitness/custom_class/water_circle_limit.dart';
import 'package:fitness/custom_class/water_graphic.dart';
import 'package:collection/collection.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/water_model.dart';
import '../../utils/routes.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({Key? key}) : super(key: key);

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {

  int waterDrunk = 0;
  // int waterLimit = 8;
  List<WaterModel> thisWeekWater = List.generate(7, (index) => WaterModel(water: 0, currentDate: DateTime.now().millisecondsSinceEpoch));
  List<int>? thisWeekWaterDrink = List.generate(7, (index) => 0);
  // [5, 8, 0 , 4, 3, 1 ,2];
  bool changeWater = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final today = DateTime.now();
    final dur = Duration(days: today.weekday);
    final weekStart = today.subtract(dur);
    DateTime dating = weekStart;
    int count = 0;
    // databaseHelper.getWaters().then((value){
    //   for (var element in value) {
    //     final date = "${dating.year} ${dating.month} ${dating.day}";
    //     final dateCompare = "${element.currentDate?.year} ${element.currentDate?.month} ${element.currentDate?.day}";
    //     if(date == dateCompare){
    //       thisWeekWater[count] = element;
    //       thisWeekWaterDrink![count] = element.water! / 250 as int ;
    //
    //     }
    //     ++count;
    //     dating = weekStart.add(Duration(days: count));
    //   }});
    getWaters().then((value) {
      print(value);
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2.8;
    final dateNow = DateTime.now();
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {

                          popScreen(context, argument: false);
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                      Text(water_tracker.tr().toUpperCase(),style: TextStyle(
                        fontSize: 22, fontFamily: mainFont, fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            changeWater = true;
                          });
                        },
                          child: Icon(Icons.more_horiz, color: Colors.black,),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffF4F6FA)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(today_txt.tr(), style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black,
                            fontSize: 16
                          ),),
                        ),),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              child: CustomPaint(
                                painter: WaterCircle(limit: user.waterLimit, alreadyDrunk: waterDrunk),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Image.asset("assets/images/drop.png", height: height * 0.12,),
                                  Text("$waterDrunk", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: height * 0.12
                                  ),),
                                  Text("/${user.waterLimit} ${cups_txt.tr()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(waterDrunk > 0){
                                    --waterDrunk;
                                    saveWaters();
                                    // databaseHelper.updateWater(WaterModel(water: waterDrunk * 250, currentDate: DateTime.now()));
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xffCDCDCF).withOpacity(0.3),
                                ),
                                child: Icon(Icons.remove, color: Colors.black, size: 30,),
                              ),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  ++waterDrunk;
                                  saveWaters();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xff1F55A2)
                                ),
                                child: Text(drink_txt.tr(),
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("${DateFormat("LLLL").format(dateNow)} ${dateNow.year}", style:
                        TextStyle(
                          color: Color(0xff919BA9),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffF4F6FA)
                    ),
                    height:  height / 1.75,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${DateFormat("LLLL").format(dateNow)} ${dateNow.subtract(Duration(days: dateNow.weekday - 1)).day} "
                                  "- ${DateFormat("LLLL").format(dateNow.add(Duration(days: DateTime.daysPerWeek - dateNow.weekday)))} ${DateFormat("d").format(dateNow.add(Duration(days: DateTime.daysPerWeek - dateNow.weekday)))}",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                              Text((thisWeekWaterDrink!.sum/ user.waterLimit).toStringAsFixed(1), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${dateNow.year}", style:
                              TextStyle(
                                  color: Color(0xff919BA9),
                                  fontWeight: FontWeight.bold
                              ),),
                              Text(average_cups_txt.tr(), style:
                              TextStyle(
                                  color: Color(0xff919BA9),
                                  fontWeight: FontWeight.bold
                              ))
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: height / 3,
                            child: CustomPaint(
                              painter: WaterGraphic(drunkInDay: thisWeekWaterDrink!, waterLimit: user.waterLimit),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          changeWater ? waterChange() : SizedBox()
        ],
      ),
    );
  }

  Widget waterChange(){
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
        width: size.width,
        height: size.height / 5,
            color: Color(0xff616161).withOpacity(0.3),
      ),
        Container(
          alignment: Alignment.bottomCenter,
          width: size.width,
          height: size.height / 5 * 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    set_daily_goal.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                ),
              Column(
                children: [
                  Container(
                    height: size.height / 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          GestureDetector(
                            onTap: (){
                              --user.waterLimit;
                              if(user.waterLimit < 1) {
                                user.waterLimit = 1;
                              }
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black
                              ),
                                child: const Icon(Icons.remove, color: Colors.white,)),
                          ),
                        Container(
                          height: size.height / 4,
                          width: size.width / 2,
                          child: Stack(
                            children: [
                              Container(
                                width: size.width / 2,
                                height: size.height / 4,
                                child: CustomPaint(
                                  painter: WaterCircleLimit(limit: user.waterLimit),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: size.width / 2,
                                    alignment: Alignment.center,
                                    child: Text(user.waterLimit.toString(),
                                      style: TextStyle(
                                          fontSize: 46,
                                          fontFamily: mainExtraBoldFont,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900
                                      ),),
                                  ),
                                  Container(
                                    width: size.width / 2,
                                    alignment: Alignment.center,
                                    child: Text(user.waterLimit == 1 ? cup_txt.tr() : cups_txt.tr(),
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontFamily: mainExtraBoldFont,
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            ++user.waterLimit;
                            if(user.waterLimit > 10) {
                              user.waterLimit = 10;
                            }
                            setState(() {});
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.black
                              ),
                              child: const Icon(Icons.add, color: Colors.white,)),
                        )
                      ],
                    ),
                  ),
                  RichText(text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black
                      ),
                      children: [
                        TextSpan(text: limit_txt.tr()),
                        TextSpan(text: " 10 ${cups_txt.tr()}", style: TextStyle(
                            color: Color(0xffF42020)
                        )),
                        TextSpan(text: limit_cups_txt.tr()),
                      ]
                  )),
                ],
              ),

              GestureDetector(
                onTap: (){
                  setState(() {
                    changeWater = false;
                    setUser(user);
                  });
                },
                child: Container(
                  width: size.width,
                  height: size.height / 14,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(doneTxt.tr().toUpperCase(), style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void saveWaters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final tt = today.weekday;
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    thisWeekWaterDrink![tt - 1] = waterDrunk;
    final getWaterDay = prefs.getString("start_day_drink");
    final currentWaterDay = DateFormat('yyyy-MM-dd').format(today);
    final clearDate = DateTime(today.year, today.month, today.day);
    final waterModel = thisWeekWater[tt- 1];
    // waterModel.currentDate = DateFormat('EEEE, MMM dd').format(DateTime.now());
    waterModel.currentDate = clearDate.millisecondsSinceEpoch;
    waterModel.water = waterDrunk * 250;
    final wat =  await databaseHelper.insertWater(waterModel);
    if(getWaterDay != currentWaterDay) {
      prefs.setString("start_day_drink",
          "${weekStart.year} ${weekStart.month} ${weekStart.day}");
    }
    final list = thisWeekWaterDrink!.map((e) => e.toString()).toList();
    prefs.setStringList("waters", list);
  }

  Future<List<int>> getWaters() async{
    final todayL = DateTime.now();
    final today = DateTime(todayL.year, todayL.month, todayL.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 7));
    final currentWaterDay = DateFormat('yyyy-MM-dd').format(weekStart);
    final endWaterDay = DateFormat('yyyy-MM-dd').format(weekEnd);
    final result = await databaseHelper.getWaters(weekStart.millisecondsSinceEpoch, weekEnd.millisecondsSinceEpoch);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final getWaterDay = prefs.getString("start_day_drink");
    final tt = today.weekday;


    // if(getWaterDay == currentWaterDay){
    //   final a = prefs.getStringList("waters");
    //   thisWeekWaterDrink = a == null ? thisWeekWaterDrink : a.map((e) => int.parse(e)).toList();
    //   waterDrunk = thisWeekWaterDrink![tt - 1];
    // }
    if(result.isNotEmpty){
      for(int a = 0; a < result.length; a++){
        final date = DateTime.fromMillisecondsSinceEpoch(result[a].currentDate!);
        final weekDay = date.weekday;
        thisWeekWaterDrink![weekDay - 1] = result[a].water! ~/ 250;
      }
    }
    waterDrunk = thisWeekWaterDrink![tt - 1];
    return thisWeekWaterDrink!;
  }
}
