import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/plan_model_static.dart';
import 'package:fitness/model/work_out_plan_item_model.dart';
import 'package:fitness/screens/challenges/challenge_screen.dart';
import 'package:fitness/screens/plan/work_out_start_screen.dart';
import 'package:fitness/utils/back_button.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/next_button.dart';
import 'package:fitness/utils/routes.dart';
import 'package:flutter/material.dart';

import '../../custom_class/divider_circle_painter.dart';
import '../../model/challane_model.dart';
import '../../model/workout_model.dart';
import '../../model/workout_model_count.dart';
import '../../utils/words.dart';

class ChallengeDetailedScreen extends StatefulWidget {
  const ChallengeDetailedScreen({Key? key, required this.map}) : super(key: key);

  final Map<String, Object> map;

  @override
  State<ChallengeDetailedScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeDetailedScreen> {

  late List<PlanModelStatic> planModelStatic;
  late ChallengeModel challengeItem;
  List<WorkOutModel> listCount = [];
  List<WorkoutModelCount> list = [];

  @override
  void initState() {
    planModelStatic = widget.map[challenge_plans] as List<PlanModelStatic>;
    challengeItem = widget.map[challenge_model] as ChallengeModel;
    databaseHelper.getWorkoutModels().then((value) {
      if (value.isNotEmpty) {
        listCount.addAll(value);
      }
    });
    super.initState();
  }

  void fillList(List<int> a, List<int> b) {
    for (int i = 0; i < a.length; i++) {
      list.add(WorkoutModelCount(
          workOutModel: a[i], count: b[i], isTime: b[i] > 1000));
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("4 ${weeksText.tr().toUpperCase()}", style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black
                ),),
                Text("${DateFormat("LLLL").format(dateNow)} ${dateNow.subtract(Duration(days: dateNow.weekday - 1)).day} "
                    "- ${DateFormat("LLLL").format(dateNow.add(Duration(days: DateTime.daysPerWeek - dateNow.weekday)))} ${DateFormat("d").format(dateNow.add(Duration(days: DateTime.daysPerWeek - dateNow.weekday)))}",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(challenge_txt.tr().toUpperCase(), style: const TextStyle(
                  color: mainColor, fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  weeksItem(DateTime.now(), 1),
                  const SizedBox(height: 10,),
                  weeksItem(DateTime.now(), 2),
                  const SizedBox(height: 10,),
                  weeksItem(DateTime.now(), 3),
                  const SizedBox(height: 10,),
                  weeksItem(DateTime.now(), 4),
                  // GridView.count(crossAxisCount: 5,
                  // children: List.generate(planModelStatic.length, (index) {
                  //     return challengeItemWidget(
                  //         challengeItem.isPassed![index],index,  () {
                  //     print(index);
                  //       PlanModelStatic item = planModelStatic[index];
                  //     final warmUp = item.warmUp!;
                  //     final warmUpTime = item.warmUpTime!;
                  //     final training = item.training!;
                  //     final trainingTime = item.trainingTime!;
                  //     final hitch = item.hitch!;
                  //     final hitchTime = item.hitchTime!;
                  //     fillList(warmUp, warmUpTime);
                  //     fillList(training, trainingTime);
                  //     fillList(hitch, hitchTime);
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => WorkoutStartScreen(
                  //               name: item.name!,
                  //               workoutCount: list,
                  //               workoutModel: listCount,
                  //               restTime: item.restBetweenExercises == null ? 0 : item.restBetweenExercises!,
                  //               timeMinutes: item.trainingInMinutes == null ? 0 : item.trainingInMinutes!,
                  //               challengeItem: challengeItem,
                  //             )),
                  //       );
                  // });
                  // }),),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget challengeItemWidget(bool isChecked,  int index, Function() clicked){
    return GestureDetector(
      onTap: () {
        if(!isChecked)
        clicked();
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorMainGradLeft, colorMainGradRight],
                )),
            child: !isChecked ? Padding(
              padding: const EdgeInsets.all(2),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.white],
                      )),

                ),
              ),
            ) : null,
          ),
          isChecked ? Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ) : Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget weeksItem(DateTime dateTime, int countWeek){
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffF4F6FA),
        borderRadius: BorderRadius.circular(15)
      ),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 7),
              Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                height: MediaQuery.of(context).size.height / 18,
                width: 4,
              ),
              const SizedBox(height: 10),
              RotatedBox(
                quarterTurns: 3,
                child: Text("${week_txt.tr().toUpperCase()} $countWeek", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                )),
              )
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    introductionIcon(Icons.close, missed_txt.tr(), Colors.black, const Color(0xffF42020)),
                    const SizedBox(width: 15,),
                    introductionIcon(Icons.check, completed_up_txt.tr(), const Color(0xffCCFF00), Colors.black),
                    const SizedBox(width: 15,),
                    introductionIcon(null, following_txt.tr(), Colors.white, null),
                  ],
                ),
                // Expanded(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //
                //       challengeWeekItem(0 + 1, 1, "June ${0 + 1}", "Mon"),
                //       challengeWeekItem(2, 1, "June ${2}", "Tue"),
                //       challengeWeekItem(3, -1, "June ${3}", "Wed"),
                //       challengeWeekItem(4, 0, "June ${4}", "Thr"),
                //       challengeWeekItem(5, 1, "June ${5}", "Fri"),
                //       challengeWeekItem(6, -1, "June ${6}", "Sut"),
                //       challengeWeekItem(7, 0, "June ${7}", "Sun"),
                //     ],
                //   ),
                // )
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                      itemBuilder: (context, index){
                      return challengeWeekItem(index + 1, -1, "June ${index + 1}", "Mon");
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget introductionIcon(IconData? icon, String text, Color color, Color? iconColor){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color,
            border: icon == null ? Border.all(color: const Color(0xff989CA0)): null
          ),
          child: Icon(icon, color: iconColor, size: 10,),
        ),
        const SizedBox(width: 5,),
        Text(text, style: TextStyle(color: Colors.black, fontSize: 12),)
      ],
    );
  }

  Widget challengeWeekItem(int count, int isPassed, String day, String week){
    final height = MediaQuery.of(context).size.height / 7.5;
    final finalCount = count > 7 ? count % 7 : count;
    final color = isPassed == 1 ? const Color(0xffCCFF00) : isPassed == 0 ? Colors.white : const Color(0xffCCFF00);
    final iconColor = isPassed == 1 ? Colors.black : isPassed == 0 ? Colors.white : const Color(0xffCCFF00);
    final icon = isPassed == 1 ? Icons.check : isPassed == 0 ? null : Icons.cancel_rounded;
    return Container(
      margin: EdgeInsets.only(right: 4, top: 10, bottom: 4),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      // width: height / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(finalCount.toString(), style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20
          ),),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: color,
                border: icon == null ? Border.all(color: const Color(0xff989CA0)): null
            ),
            child: Icon(icon, color: iconColor,),
          ),
          Column(
            children: [
              Text(day, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 11
              ),),
              SizedBox(height: 3,),
              Text(week, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 9
              ),),
            ],
          )

        ],
      ),
    );
  }
}
