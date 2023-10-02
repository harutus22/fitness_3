import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/workout_model.dart';
import 'package:fitness/utils/routes.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../model/custom_plan_model.dart';
import '../../utils/colors.dart';
import '../../utils/const.dart';

class CreateMainScreen extends StatefulWidget {
  const CreateMainScreen({Key? key}) : super(key: key);

  @override
  State<CreateMainScreen> createState() => _CreateMainScreenState();
}

class _CreateMainScreenState extends State<CreateMainScreen> {
  late List<PlanModel> _createdPlan = [] ;
  late List<WorkOutModel> _workouts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    // databaseHelper.getWorkoutModels().then((value) => {
    //   _workouts = value,
    //   setState(() {})
    // });
    databaseHelper.getPlanModels().then((value) => {
          _createdPlan = value,
    setState(() {})
        });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Divider(
              color: const Color(0xff0E1618).withOpacity(0.1),
              //color of divider
              height: 2,
              //height spacing of divider
              thickness:
                  1, //thickness of divier line//spacing at the end of divider
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      createWorkout.tr(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            gradient: linearGradient,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    onTap: () {
                      changeScreen(nameWorkoutScreen, context);
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: const Color(0xff0E1618).withOpacity(0.1),
              //color of divider
              height: 2,
              //height spacing of divider
              thickness:
                  1, //thickness of divier line//spacing at the end of divider
            ),
            Expanded(child: ListView.builder(itemBuilder: (context, position) {
              return InkWell(
                onTap: (){
                  changeScreen(createdDetailedPreStartScreen, context, argument: _createdPlan[position]);
                },
                child: Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _createdPlan[position].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        IconButton(
                          onPressed: () {
                            changeScreen(createdDetailedPreStartScreen, context, argument: _createdPlan[position]);
                          },
                          icon: const Icon(Icons.arrow_forward_ios)
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color(0xff0E1618).withOpacity(0.1),
                    height: 2,
                    thickness: 1,
                  )
                ]),
              );
            }, itemCount: _createdPlan.length, shrinkWrap: true,))
          ],
        ),
      ),
    );
  }
}
