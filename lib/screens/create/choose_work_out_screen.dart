import 'dart:core';

import 'package:fitness/model/muscle_groups.dart';
import 'package:fitness/model/workout_model.dart';
import 'package:fitness/screens/create/quantity_work_out_screen.dart';
import 'package:fitness/utils/Routes.dart';
import 'package:fitness/utils/const.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../model/workout_training_choose_item.dart';
import '../../utils/back_button.dart';

class ChooseWorkOutScreen extends StatefulWidget {
  const ChooseWorkOutScreen({Key? key}) : super(key: key);

  @override
  State<ChooseWorkOutScreen> createState() => _ChooseWorkOutScreenState();
}

class _ChooseWorkOutScreenState extends State<ChooseWorkOutScreen> {
  List<WorkOutModel> workoutModels = [];
  List<WorkOutModel> chosen = [];
  int _pastPosition = -1;
  List<WorkoutTrainingChooseItem> workoutChooseItem = [
    WorkoutTrainingChooseItem(muscleGroup: MuscleGroups.chestGroup),
    WorkoutTrainingChooseItem(muscleGroup: MuscleGroups.armsGroup),
    WorkoutTrainingChooseItem(muscleGroup: MuscleGroups.shouldersGroup),
    WorkoutTrainingChooseItem(muscleGroup: MuscleGroups.absGroup),
    WorkoutTrainingChooseItem(muscleGroup: MuscleGroups.legsGroup),
    WorkoutTrainingChooseItem(muscleGroup: MuscleGroups.buttocksGroup),
    WorkoutTrainingChooseItem(muscleGroup: MuscleGroups.backGroup),
  ];

  @override
  void initState() {
    super.initState();
    databaseHelper.getWorkoutModels().then((value) => {
          workoutModels.addAll(value),
          setState(() {}),
        });
  }

  void openList(int workOutChoosePosition) {
    if (workOutChoosePosition == _pastPosition) {
      // workoutChooseItem[workOutChoosePosition].isPressed = !workoutChooseItem[workOutChoosePosition].isPressed;
      _pastPosition = -1;
    } else if(_pastPosition != -1){
      workoutChooseItem[_pastPosition].isPressed =
          !workoutChooseItem[_pastPosition].isPressed;
      _pastPosition = workOutChoosePosition;
      chosen.clear();
      chosen = workoutModels
          .where((element) => element.muscleGroups
              .contains(workoutChooseItem[workOutChoosePosition].muscleGroup))
          .toList();
      print(chosen);
    } else {
      _pastPosition = workOutChoosePosition;
      chosen.clear();
      chosen = workoutModels
          .where((element) => element.muscleGroups
          .contains(workoutChooseItem[workOutChoosePosition].muscleGroup))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Align(alignment: Alignment.topLeft, child: backButton(context)),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
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
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return InkWell(
                    onTap: (){
                      workoutChooseItem[position]
                          .isPressed =
                      !workoutChooseItem[position]
                          .isPressed;
                      openList(position);
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                workoutChooseItem[position].muscleGroup.value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  workoutChooseItem[position].isPressed =
                                      !workoutChooseItem[position].isPressed;
                                  openList(position);
                                  setState(() {});
                                },
                                icon: !workoutChooseItem[position].isPressed
                                    ? const Icon(Icons.arrow_forward_ios)
                                    : Transform.rotate(
                                        angle: 90 * math.pi / 180,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                          ),
                                          onPressed: () {
                                            workoutChooseItem[position]
                                                    .isPressed =
                                                !workoutChooseItem[position]
                                                    .isPressed;
                                            openList(position);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: const Color(0xff0E1618).withOpacity(0.1),
                          height: 2,
                          thickness: 1,
                        ),
                        workoutChooseItem[position].isPressed
                            ? ListView.builder(
                                itemBuilder: (context, position) {
                                  return InkWell(
                                    onTap: (){
                                      // Map<String, Object> pass = {
                                      //   'name': title,
                                      //   'exercise': chosen[position]
                                      // } ;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => WorkoutQuantityScreen(name: title, workout: chosen[position],)),
                                      );
                                      // changeScreen(quantityScreen, context, argument: pass);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    "assets/images/training/${chosen[position].id}.jpg",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  chosen[position].name,
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: const Color(0xff0E1618)
                                              .withOpacity(0.1),
                                          height: 2,
                                          thickness: 1,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: chosen.length,
                                physics: const NeverScrollableScrollPhysics(),
                              )
                            : const SizedBox(
                                height: 10,
                              )
                      ],
                    ),
                  );
                },
                itemCount: workoutChooseItem.length,
                shrinkWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
