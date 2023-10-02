import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/training_done_model.dart';
import 'package:fitness/screens/challenges/challenge_screen.dart';
import 'package:fitness/screens/main_menu_screen.dart';
import 'package:fitness/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../model/challane_model.dart';
import '../../utils/colors.dart';
import '../../utils/words.dart';

class WorkOutEndScreen extends StatefulWidget {
  const WorkOutEndScreen({Key? key}) : super(key: key);

  @override
  State<WorkOutEndScreen> createState() => _WorkOutEndScreenState();
}

class _WorkOutEndScreenState extends State<WorkOutEndScreen> {

  int _selectedFeedback = -1;
  int day = 1;
  bool _adShowed = false;

  @override
  void initState() {
    getWorkoutFirstDate().then((value){
      if(value == null){
        setWorkoutFirstDate();
      } else {
        final now = DateTime.now().millisecondsSinceEpoch - value;
        day = Duration(milliseconds: now).inDays;
      }
    });
    // if(!user.isSubscribed)
    //   createInterstitialAd('ca-app-pub-5842953747532713/4776224817');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)?.settings.arguments as Map;
    final name = map[planExerciseName] as String;
    final kcal = map[planExerciseKcal] as double;
    final exerciseCount = map[planExerciseCount] as int;
    final time = map[planExerciseTime] as String;
    final total = map[planExerciseTotal] as int;
    final challengeItem = map[challenge_item] as ChallengeModel?;
    int dayCount = challengeItem != null ? challengeItem.isPassed!.contains(true) ? challengeItem.isPassed!.indexWhere((element) => element == false) + 1 : 1 : 1;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              // fit: BoxFit.cover
              child: SizedBox(
                // width: _controller.value.size.width,
                // height: _controller.value.size.height,
                // child: VideoPlayer(_controller),
                child: Image.asset("assets/images/result_background.png",
                fit: BoxFit.cover,),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StrokeText(
                          text: time,
                          strokeWidth: 2,
                          strokeColor: Colors.black,
                          textStyle: const TextStyle(
                            color: mainColor,
                            fontSize: 60
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/result_fire.svg",
                                  height: 20,
                                ),
                                const SizedBox(width: 5,),
                                Text(burned_txt.tr(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16
                                ),)
                              ],
                            ),
                            RichText(text: TextSpan(
                              children: [
                                TextSpan(
                                  text: kcal.toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white
                                  )
                                ),
                                WidgetSpan(child: SizedBox(width: 5,)),
                                TextSpan(
                                  text: kcalText.tr(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                    )
                                )
                              ]
                            ))
                          ],
                        )
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          itemHappiness("assets/images/sunbed.png", tooEasy.tr(), 0),
                          const SizedBox(height: 20,),
                          itemHappiness("assets/images/strong.png", hard_in_good_way.tr(), 1),
                          const SizedBox(height: 20,),
                          itemHappiness("assets/images/dead.png", tooHard.tr(), 2),
                          const SizedBox(height: 30,),
                          GestureDetector(
                            onTap: (){
                              var dateCurrent = DateTime.now();
                              var date = DateTime(dateCurrent.year, dateCurrent.month, dateCurrent.day);
                              final training = TrainingDone(date: date, caloriesBurnt: kcal.toInt(), timePassed: total);
                              databaseHelper.insertTrainingDone(training);
                              if(challengeItem != null) {
                                for (var item = 0; item < challengeItem.isPassed!.length; item++){
                                  if(challengeItem.isPassed![item] == IsChallengePassed.following){
                                    challengeItem.isPassed![item] = IsChallengePassed.completed;
                                    break;
                                  }
                                }
                                databaseHelper.updateChallenge(challengeItem);
                              }
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                                return MainMenuScreen(numer: challengeItem != null ? 1 : null);
                              }), (r){
                                return false;
                              });
                            },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: mainColor
                                ),
                                child: Text(
                                  finishText.tr(),
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(results_txt.tr(), style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white
                        ),),
                        SizedBox(width: 10,),
                        SvgPicture.asset("assets/images/workout_screen_checked.svg",
                        height: 20,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemHappiness(String image, String title, int number){
    return GestureDetector(
      onTap: (){
        _selectedFeedback = number;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: _selectedFeedback == number ? mainColor : Colors.black,
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.all(Radius.circular(40))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  // border: Border.all(width: 2, color: _selectedFeedback != number ? const Color(0xffCDCDCF) : Colors.transparent),
                  borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                ),
                child: Image.asset(image, height: 25,)
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white,
                fontSize: 20
            ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}
