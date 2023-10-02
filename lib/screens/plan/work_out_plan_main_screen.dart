import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/water_model.dart';
import 'package:fitness/screens/plan/work_out_plan_item.dart';
import 'package:fitness/utils/Routes.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom_class/water_arc.dart';
import '../../custom_widgets/water_arc.dart';
import '../../model/plan_model_static.dart';
import '../../utils/colors.dart';
import '../onboarding/paywall_screen.dart';

class WorkOutPlanMainScreen extends StatefulWidget  {
  const WorkOutPlanMainScreen({Key? key}) : super(key: key);

  @override
  State<WorkOutPlanMainScreen> createState() => _WorkOutPlanMainScreenState();
}

class _WorkOutPlanMainScreenState extends State<WorkOutPlanMainScreen> with SingleTickerProviderStateMixin  {
  String name = "";
  List<PlanModelStatic> planModels = [];
  double count = 0;
  bool isSubscribed = false;
  String date = "";
  Size? size;
  late GlobalKey _widthKey;
  int planChosen = 0;
  double _progress = 0.0;
  // late Animation<double> animation;
  // WaterModel _waterModel = WaterModel(water: 0, currentDate: DateFormat('EEEE, MMM dd').format(DateTime.now()));
  WaterModel _waterModel = WaterModel(water: 0, currentDate: DateTime.now().millisecondsSinceEpoch);
  // late AnimationController controller;


  void _getWidgetInfo(_) {
    final RenderBox renderBox = _widthKey.currentContext?.findRenderObject() as RenderBox;

    size = renderBox.size;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _widthKey = GlobalKey();
    super.initState();
    // controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);

    final today = DateTime.now();
    final clearDate = DateTime(today.year, today.month, today.day);
    _waterModel.currentDate = clearDate.millisecondsSinceEpoch;
    // _checkSubs();
    inita();
    _getUserName();
    final currentDate = DateTime.now();
    date = DateFormat("EEEE, MMMM d").format(currentDate);
    getUser().then((value) => {
      isSubscribed = value!.isSubscribed,
    });
    WidgetsBinding.instance.addPostFrameCallback(_getWidgetInfo);
  }

  void inita() async {
    await databaseHelper.init();
    // final water = await databaseHelper.getWater(DatFormat('EEEE, MMM dd').format(DateTime.now()));
    final today = DateTime.now();
    final clearDate = DateTime(today.year, today.month, today.day);
    final water = await databaseHelper.getWater(clearDate.millisecondsSinceEpoch);
      _waterModel = water;
      final waterDrunk = water.water! / 250 > user.waterLimit ? user.waterLimit : water.water! / 250;
      _progress = waterDrunk / user.waterLimit;
      setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // databaseHelper.close();
  }

  void _getUserName() async {
    final user = await getUser();
    name = user?.name == null ? "" : user!.name;
    count = user!.totalCount.toDouble();
    final item = await getWorkoutWeekDate();

    if(item == null) {
      _setDatabase();
    } else if(item == false){
      planModels.addAll(await getWeekPlans());
      setState(() {});
    } else{
      _setDatabase();
    }
  }

  void _setDatabase(){
    databaseHelper.getStaticPlanModels().then((value) =>
    {
      planModels.addAll(_getListStaticModel(
          value
              .where((element) => element.restBetweenExercises! > 0)
              .toList(),
          count)),
      _setWeeks(),
    });
  }

void _setWeeks()async {
  setWorkoutWeekDate();
  _setImages();
  setWeekPlans(planModels);
  setState(() {});
}

void _setImages(){
    List<int> numbers = [];
    for(var item in planModels){
      var random = Random().nextInt(62) + 1;
      while(numbers.contains(random)){
        random = Random().nextInt(62) + 1;
      }
      numbers.add(random);
      item.image = "assets/images/covers/$random.png";
    }
}

  List<PlanModelStatic> _getListStaticModel(
      List<PlanModelStatic> list, final double diff) {
    List<PlanModelStatic> retList = [];
    int a = 0;
    if (diff <= 3) {
      a = 3;
    } else if (diff > 3 && diff <= 4) {
      a = 4;
    } else {
      a = 5;
    }
    for (int i = 0; i < a; i++) {
      if (i == 0) {
        retList.add(getStaticModel("Cardio", list));
      } else if (i == 1) {
        retList.add(getStaticModel("Upper Body", list));
      } else if (i == 2) {
        retList.add(getStaticModel("Full Body", list));
      } else if (i == 3) {
        retList.add(getStaticModel("Core", list));
      } else if (i == 4) {
        retList.add(getStaticModel("Lower Body", list));
      }
    }
    return retList;
  }

  PlanModelStatic getStaticModel(
      String text, List<PlanModelStatic> chosenList) {
    List<PlanModelStatic> finalList =
        chosenList.where((element) =>
            element.type!.contains(text)
        ).toList();
    return finalList[Random().nextInt(finalList.length)];
  }
  final style = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                  child: Text(
                      date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: mainFont,
                      fontWeight: FontWeight.bold
                    ),
                  )
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    home_workout.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  )
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    workoutItem("0", "assets/images/fire.png", day_streak.tr(),
                        personal_best.tr(), " 1"),
                    const SizedBox(width: 20,),
                    workoutItem("0/4", "assets/images/calendar.png", this_week.tr(),
                        in_total.tr(), " 2")
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(water_tracker.tr(),style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )),
                  GestureDetector(
                    onTap: () async {
                       final result = await changeScreen(waterTrackerScreen, context);
                       final today = DateTime.now();
                       final clearDate = DateTime(today.year, today.month, today.day);
                       final water = await databaseHelper.getWater(clearDate.millisecondsSinceEpoch);
                       _waterModel = water;
                       final waterDrunk = water.water! / 250 > user.waterLimit ? user.waterLimit : water.water! / 250;
                       _progress = waterDrunk / user.waterLimit;
                       setState(() {});
                    },
                    child: SvgPicture.asset("assets/images/filter.svg"),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 20, right: 20),
                decoration: BoxDecoration(
                  color: const Color(0xffF4F6FA),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${(user.waterLimit * 250 / 1000).toStringAsFixed(1)}L ${daily_goal.tr()}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black
                          ),),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text("${_waterModel.water!}L", style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff32B5FF),
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Text("${(_waterModel.water! / 250 / user.waterLimit * 100).toStringAsFixed(0)}% ${completed_txt.tr()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black
                          ),),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        key: _widthKey,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addMinus(Icons.remove, (){
                            if(_waterModel.water != 0) {
                              setState(() {
                                _waterModel.water = _waterModel.water! - 250;
                                _progress = _waterModel.water! / 250 / user.waterLimit;
                                saveWater();
                              });
                            }
                          }),
                          WaterArcus(size: size, user: user, waterModel: _waterModel, progress: _progress,),
                          addMinus(Icons.add, (){
                              setState(() {
                                _waterModel.water = _waterModel.water! + 250;
                                _progress = _waterModel.water! / 250 / user.waterLimit;
                                saveWater();
                              });
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  planCreate(plan.tr(), 0),
                  planCreate(create.tr(), 1),
                ],
              ),
              const SizedBox(height: 10,),
              planChosen == 0 ? Expanded(
                  child: planModels.isEmpty ? Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ) : ListView.builder(
                      itemBuilder: (context, position) {
                        return Column(
                          children: [
                            WorkOutPlanItem(
                              workOutPlanItemModel: planModels[position],
                              workoutFunction: (workoutItem, isFree) async {
                                if (isFree) {
                                  changeScreen(planDetailedScreen, context,
                                      argument: workoutItem);
                                } else {
                                  await changeScreen(payWallScreen, context, argument: canPop);
                                  setState(() {});
                                }
                              },
                              image: planModels[position].image!,
                              isFree: position > 1 ? isSubscribed : true,
                            ),
                            position != planModels.length - 1
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : const SizedBox()
                          ],
                        );
                      },
                      itemCount: planModels.length)) :
                  Text("not ready")
            ],
          ),
        ),
      ),
    );
  }

  Widget workoutItem(String one, String image, String two, String three, String three2){
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xffF4F6FA),
            // boxShadow: [
            //   BoxShadow(
            //       offset: Offset(0, 6),
            //       color: Color(0xff1F55A2).withOpacity(0.05)
            //   )
            // ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  one,
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Image.asset(image, height: 25,)
              ],
            ),
            const SizedBox(height: 6,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(two, style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(three, style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                )),
                Text(three2, style: const TextStyle(
                  fontSize: 12,
                    color: Colors.grey
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget planCreate(String title, int number){
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            planChosen = number;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(
              color: Colors.black,
              fontSize: 24
            ),),
            const SizedBox(height: 20,),
            Container(
              height: 8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: planChosen == number ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(30)
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addMinus(IconData image, Function() callback){
      return GestureDetector(
      onTap: (){
        callback();
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 9,
          width: MediaQuery.of(context).size.width / 9,
        decoration: BoxDecoration(
          color: Icons.add == image ? const Color(0xff32B5FF) : const Color(0xff32B5FF).withOpacity(0.5),
          borderRadius: BorderRadius.circular(100)
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xffF4F6FA),
                borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Icon(image, size: 35,
                color: Icons.add == image ? const Color(0xff32B5FF) : const Color(0xff32B5FF).withOpacity(0.5),)
            ),
          ),
        ),
      ),
    );
  }

  void saveWater() async {
    final wat =  await databaseHelper.insertWater(_waterModel);
  }
}
