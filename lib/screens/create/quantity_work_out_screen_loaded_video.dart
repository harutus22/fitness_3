import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/training_video_model.dart';
import 'package:fitness/model/workout_model.dart';
import 'package:fitness/utils/next_button.dart';
import 'package:fitness/utils/routes.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../utils/back_button.dart';
import '../../utils/colors.dart';
import '../../utils/const.dart';

class WorkoutQuantityScreen extends StatefulWidget {
  const WorkoutQuantityScreen(
      {Key? key, required this.name, required this.workout})
      : super(key: key);

  final String name;
  final WorkOutModel workout;

  @override
  State<WorkoutQuantityScreen> createState() => _WorkoutQuantityScreenState();
}

class _WorkoutQuantityScreenState extends State<WorkoutQuantityScreen> {
  late VideoPlayerController _controller;
  bool _isSetVideo = false;
  double chooseHeight = 0;
  double chooseWidth = 0;
  bool isTimeChecked = false;
  int _exerciseCount = 1;
  String _exerciseText = "x1";
  Map<String, Object> argument = {};
  late Future<String> url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  String _getName(String name) {
    var pos = name.lastIndexOf('.');
    String result = name.substring(0, pos);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    chooseWidth = MediaQuery.of(context).size.width * 0.3;
    chooseHeight = MediaQuery.of(context).size.height * 0.04;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(alignment: Alignment.topLeft, child: backButton(context)),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: const Color(0xff0E1618).withOpacity(0.1),
              height: 2,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.workout.name,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 22),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 5 * 4,
              padding: const EdgeInsets.all(10),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    FutureBuilder(
                      future: getApplicationDocumentsDirectory(),
                      builder: (context, snapshot) {
                        if(!_isSetVideo && snapshot.data != null) {
                          _isSetVideo = true;
                          final url = "${snapshot.data?.path}/training_video/${widget.workout.id}.mp4";
                          _controller =
                          VideoPlayerController.file(File(url))
                            ..initialize().then((_) =>
                            {
                              _controller.play(),
                              _controller.setLooping(true),
                              setState(() {})
                            });
                          return VideoPlayer(_controller);
                        } else if(snapshot.data == null && !_isSetVideo) {
                          return SizedBox();
                        } else {
                          return VideoPlayer(_controller);
                        }


                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: chooseWidth,
              height: chooseHeight,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        isTimeChecked = false;
                        _exerciseText = "x$_exerciseCount";
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: chooseHeight,
                        decoration: isTimeChecked
                            ? BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    colorMainGradLeft,
                                    colorMainGradRight
                                  ],
                                ),
                              ),
                        child: Text(
                          repsText.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isTimeChecked ? colorGreyText : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        isTimeChecked = true;
                        _exerciseText = getTime(isTimeChecked, _exerciseCount);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: chooseHeight,
                        decoration: isTimeChecked
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    colorMainGradLeft,
                                    colorMainGradRight
                                  ],
                                ),
                              )
                            : BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                        child: Text(
                          timeText.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                !isTimeChecked ? colorGreyText : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _exerciseCount--;
                    if (_exerciseCount < 1) _exerciseCount = 1;
                    if (!isTimeChecked) {
                      _exerciseText = "x$_exerciseCount";
                    } else {
                      _exerciseText = getTime(isTimeChecked, _exerciseCount);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffE9EBEE)),
                    child: const Icon(
                      CupertinoIcons.minus,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  _exerciseText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    _exerciseCount++;
                    _exerciseText = getTime(isTimeChecked, _exerciseCount);
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffE9EBEE)),
                    child: const Icon(
                      CupertinoIcons.plus,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: next(
                    context,
                    createExerciseFinalScreen,
                    true,
                    () => {
                          argument.addAll({
                            'name_count': widget.name,
                            'model_count': widget.workout,
                            'count_count': _exerciseCount,
                            'is_time_checked_count': isTimeChecked,
                          }),
                          print(argument),
                        },
                    argument: argument,
                    text: addExercise.tr()),
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
    _controller.dispose();
  }
}
