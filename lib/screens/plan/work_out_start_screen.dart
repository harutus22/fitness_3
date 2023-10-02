import 'dart:io';
import 'dart:math';

import 'package:custom_timer/custom_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/workout_model.dart';
import 'package:fitness/model/workout_model_count.dart';
import 'package:fitness/screens/challenges/challenge_screen.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/custom_icons/create_final_custom_icons.dart';
import 'package:fitness/utils/routes.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:video_player/video_player.dart';

import '../../model/challane_model.dart';
import '../main_menu_screen.dart';

class WorkoutStartScreen extends StatefulWidget {
  WorkoutStartScreen({
    Key? key,
    required this.name,
    required this.workoutCount,
    required this.workoutModel,
    required this.restTime,
    required this.timeMinutes,
    this.challengeItem
  }) : super(key: key);

  final List<WorkoutModelCount> workoutCount;
  final List<WorkOutModel> workoutModel;
  final String name;
  final int restTime;
  final int timeMinutes;
  ChallengeModel? challengeItem;


  @override
  State<WorkoutStartScreen> createState() => _WorkoutStartScreenState();
}

class _WorkoutStartScreenState extends State<WorkoutStartScreen> with SingleTickerProviderStateMixin {
  final CountdownController _controllerTimerTraining =
      CountdownController(autoStart: false);
  var _currentPosition = 0;
  var _totalCount = 50;
  late VideoPlayerController _controller;
  bool _isSetVideo = false;
  bool _isResting = false;
  bool _isPaused = false;
  bool _wantQuit = false;
  bool _videoReady = false;
  int restingTime = 0;
  double? width;
  double colories = 0;
  String totalTime = "00:00";
  int total = 0;
  bool preCount = true;

  late final CustomTimerController _controllerTimeUp = CustomTimerController(
      vsync: this,
      begin: const Duration(),
      end: const Duration(hours: 24),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds
  );



  @override
  void initState() {
    _controllerTimerTraining.setOnPause(() {
      print(123);
    });
    _totalCount = widget.workoutCount.length;
    restingTime = widget.restTime;
    final preColories =
        widget.workoutCount.map((e) => e.count > 1000 ? e.count / 1000 : 0);
    total = 0;
    preColories.forEach((element) {
      if (element != 0) {
        colories += 6 + 3 * Random().nextDouble();
        total += element.toInt();
      }
    });
    final minute = (total ~/ 60).toString().padLeft(2, "0");
    final seconds = (total % 60).toString().padLeft(2, "0");
    totalTime = "$minute:$seconds";
    _controllerTimeUp.start();
    _controllerTimeUp.state.addListener(() {
      final res = _controllerTimeUp.remaining.value.duration;
      total = res.inSeconds;
      var minutesForCalories = res.inMinutes;
      while(minutesForCalories != 0){
        colories += 6 + 3 * Random().nextDouble();
        minutesForCalories--;
      }
      final minute = (total ~/ 60).toString().padLeft(2, "0");
      final seconds = (total % 60).toString().padLeft(2, "0");
      totalTime = "$minute:$seconds";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WorkoutModelCount currentWork = widget.workoutCount[_currentPosition];
    WorkOutModel workoutModel = widget.workoutModel.firstWhere((element) => element.id == currentWork.workOutModel);
    width ??= MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Builder(
                            builder: (context){
                              if(_wantQuit || _isPaused)
                                return SizedBox();
                              else {
                                if(!preCount || _isResting) {
                                  return GestureDetector(
                                      onTap: () {
                                        _wantQuit = true;
                                        _controllerTimeUp.pause();
                                        _controllerTimerTraining.pause();
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ));
                                } else {
                                  return SizedBox();
                                }
                              }
                            },
                          )
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: CustomTimer(
                              controller: _controllerTimeUp,
                              builder: (state, time) {
                                return Text(
                                    "${time.minutes}:${time.seconds}",
                                    style: TextStyle(fontSize: 16.0, color: bottomItemColor)
                                );
                              }
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${firstLExer.tr()} ${_currentPosition + 1}/$_totalCount",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width! / 5 * 4,
                    padding: const EdgeInsets.all(10),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          getVideo(workoutModel),
                          preCount == true && _isResting == false ? Container(
                            width: width! / 5 * 4,
                            color: Colors.black.withOpacity(0.7),
                            child: Center(
                                child: Countdown(
                                  key: null,
                                  seconds: 5,
                                  interval: const Duration(seconds: 1),
                                  build: (context, item){
                                    return Text(item == 0 ? "Start" : item.toInt().toString(), style: const TextStyle(
                                      fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold
                                    ),);
                                  },
                                  onFinished: (){
                                    preCount = false;
                                    _controllerTimerTraining.resume();
                                    setState(() {});
                                  },
                                )
                            ),
                          ) : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isResting ? resting() : training(workoutModel, currentWork)
                ],
              ),
            ),
            _isPaused ? getPause(width!) : const SizedBox(),
            _wantQuit ? getQuit(width!) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget getVideo(WorkOutModel workoutModel){
    if (!_isSetVideo) {
      _isSetVideo = true;
      _controller =
      VideoPlayerController.asset("assets/videos/training/${workoutModel.id}.mp4")
        ..initialize().then((_) => {
          _controller.play(),
          _controller.setLooping(true),
          _videoReady = true,

          setState(() {})
        });
      return VideoPlayer(_controller);
    } else if (!_isSetVideo) {
      return const SizedBox();
    } else {
      return VideoPlayer(_controller);
    }
  }

  String getTimeText(int time) {
    int minute = time ~/ 60;
    int seconds = time % 60;

    return "${minute.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  Widget countDown(int time, Function() callback, double fontSize, WorkOutModel? item) {
    // startCount();
    return _videoReady ? Countdown(
      key: item == null ? null : Key(item.name + item.id.toString()),
      seconds: time ~/ 1000,
      controller: _controllerTimerTraining,
      build: (BuildContext context, double timeer) {
        if(_isResting) {
          restingTime = timeer.toInt();
        }
        return StrokeText(
            text: getTimeText(timeer.toInt()),
          textStyle: TextStyle(
              fontSize: fontSize,
            color: mainColor,
          ),
          strokeColor: const Color(0xff0E1618).withOpacity(0.4),
          strokeWidth: 2,
        );
        },
      interval: const Duration(seconds: 1),
      onFinished: () {
        print('Timer is done!');
        callback();
      },
    ) : SizedBox();
  }

  Widget training(WorkOutModel workoutModel, WorkoutModelCount currentWork) {
    return Column(
      children: [
        Text(
          getReady.tr(),
          style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          workoutModel.name,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800,
          fontFamily: mainFont),
        ),
        const SizedBox(
          height: 30,
        ),
        currentWork.count > 1000
            ? countDown(currentWork.count, () {
                nextExercise();
              }, 80, workoutModel)
            : StrokeText(
                text: "x${currentWork.count.toString()}",
                textStyle: TextStyle(
                    fontSize: 80,
                    color: mainColor,
                    fontWeight: FontWeight.w800),
          strokeColor: Color(0xff0E1618).withOpacity(0.4),
          strokeWidth: 2  ,
              ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (currentWork.count > 1000) {
                          _controllerTimerTraining.pause();
                        }
                        _controllerTimeUp.pause();
                        _isPaused = true;
                        setState(() {});
                      },
                      child: preCount != true ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: mainColor,
                              ),
                          child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white,
                                              Colors.white
                                            ],
                                          )),
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: preCount != true ? Icon(
                                            FinalCreateIcons.pause_outline,
                                            color: Colors.black,
                                            size: 30,
                                          ) : Icon(null, size: 30,)))))) : Container(
                        height: 50, width: 50,
                      ),
                    ),
                    GestureDetector(
                      child: preCount != true ?  Icon(
                        Icons.skip_next_outlined,
                        color: Colors.black,
                        size: 50,
                      ): Icon(null, size: 50,),
                      onTap: () {
                        nextExercise();
                      },
                    )
                  ],
                ))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          nextS.tr(),
          style: const TextStyle(color: bottomItemColor, fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.workoutCount.length > _currentPosition + 1
              ? widget
                  .workoutModel.firstWhere((element) =>
          element.id == widget.workoutCount[_currentPosition + 1].workOutModel
          )

                  .name
              : "",
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        )
      ],
    );
  }

  Widget resting() {
    startAfterRest();
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                nextS.tr(),
                style: const TextStyle(color: bottomItemColor, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.workoutCount.length > _currentPosition + 1
                    ? widget
                        .workoutModel.firstWhere((element) => element.id == widget.workoutCount[_currentPosition].workOutModel)
                        .name
                    : "",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    rest.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  countDown(restingTime, () {
                    restingTime = widget.restTime;
                    _isResting = false;
                    _controllerTimerTraining.pause();
                    setState(() {});
                  }, 60, null)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      restingTime = restingTime * 1000 +  20000;
                      _controllerTimerTraining.restart();
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(60),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(60),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: StrokeText(
                              text: "+20s",
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textColor: Colors.white,
                              strokeWidth: 2,
                              strokeColor: const Color(0xff0E1618).withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: const Color(0xff919BA9),
                      shadows: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const StadiumBorder(),
                      child: Text(
                        skipRest.tr(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        restingTime = widget.restTime;
                        _isResting = false;
                        _controllerTimerTraining.pause();
                        setState(() {});
                      },
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget getPause(double width) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(color: const Color(0xff0E1618).withOpacity(0.5)),
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: width,
              child: Text(
                paused.tr(),
                style: TextStyle(
                    fontSize: 30,
                    color: mainColor,
                    fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pausedMenuItem(restartExercise.tr(),
                    () => {
                  _currentPosition = 0,
                      _isPaused = false,
                      _controllerTimeUp.reset(),
                      _controllerTimeUp.start(),
                      _videoReady = false,
                      _isSetVideo = false,
                      preCount = true,
                      setState(() {})
                    }, width),
                const SizedBox(
                  height: 20,
                ),
                pausedMenuItem(
                    quitWorkout.tr(),
                    () => {
                      _isPaused = false,
                      _wantQuit = true,
                      setState((){}),
                        },
                    width),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _controllerTimerTraining.resume();
                    _controllerTimeUp.start();
                    _isPaused = false;
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    width: width,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text(
                        resume.tr(),
                        // textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  void nextExercise() {
    if (widget.workoutCount.length <= _currentPosition + 1) {
      _controllerTimeUp.pause();
      final map = {
        planExerciseKcal: colories,
        planExerciseName: widget.name,
        planExerciseTime: totalTime,
        planExerciseCount: widget.workoutCount.length,
        planExerciseTotal: total,
        challenge_item: widget.challengeItem
      };
      changeScreen(planWorkoutEndScreen, context, argument: map);
    } else {
      if (widget.restTime != 0) {
        _isResting = true;
      }
      if(preCount == true && _isResting == false){
        _controllerTimerTraining.pause();
      }
      preCount = true;
      _videoReady = false;
      _isSetVideo = false;
      _currentPosition++;
      // _controllerTimeUp.pause();
      setState(() {
      });
    }
  }

  Widget pausedMenuItem(String title, Function() callback, double width) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: width,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            title,
            // textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  int _quitValue = -1;

  Widget getQuit(double width) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(color: const Color(0xff0E1618).withOpacity(0.7)),
      child: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _wantQuit = false;
                _controllerTimeUp.start();
                _controllerTimerTraining.resume();
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      resume.tr(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    whyGiveUp.tr(),
                    style: TextStyle(
                        fontSize: 30,
                        color: mainColor,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    provideFeedback.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                quitMenuItem(tooEasy.tr(), 0, width),
                const SizedBox(
                  height: 20,
                ),
                quitMenuItem(tooHard.tr(), 1, width),
                const SizedBox(
                  height: 20,
                ),
                quitMenuItem(anotherReason.tr(), 2, width),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MainMenuScreen();
                    }), (r) {
                      return false;
                    });
                  },
                  child: Container(
                    width: width,
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          quit.tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    ));
  }

  Widget quitMenuItem(String title, int index, double width) {
    return GestureDetector(
      onTap: () {
        _quitValue = index;
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: width,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: _quitValue == index ? Colors.white : Colors.transparent,
                width: _quitValue == index ? 2.0 : 0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            title,
            // textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> startAfterRest() async {
    Future.delayed(Duration(seconds: 2), (){
      if(_isResting && !_wantQuit)
        _controllerTimerTraining.start();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
