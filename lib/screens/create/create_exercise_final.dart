import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/workout_model_count.dart';
import 'package:fitness/screens/main_menu_screen.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/custom_icons/create_final_custom_icons.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/create_exercise_final.dart';
import '../../model/custom_plan_model.dart';
import '../../model/workout_model.dart';
import '../../utils/Routes.dart';
import '../../utils/back_button.dart';
import '../../utils/colors.dart';

class CreateExerciseFinalScreen extends StatefulWidget {
  const  CreateExerciseFinalScreen({Key? key}) : super(key: key);

  @override
  State<CreateExerciseFinalScreen> createState() =>
      _CreateExerciseFinalScreenState();
}

class _CreateExerciseFinalScreenState extends State<CreateExerciseFinalScreen> {
  bool isAdded = false;
  bool isForSave = false;
  List<WorkOutModel> model = [];
  String title = "";
  WorkOutModel? workoutModel;
  int? count;
  bool? isTimeChecked;
  PlanModel? planModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workoutModelCount ??= CreateExerciseFinal(workoutModelCount: [], forEdit: false);
  }

  @override
  Widget build(BuildContext context) {
    final item =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    if(title.isEmpty) {
      title = item['name_count'] as String;
    }
    if(item['workout_list'] != null){
      planModel = item['workout_list'] as PlanModel;
      title = planModel!.name;
      workoutModelCount?.workoutModelCount = List.of(planModel!.countModelList);
      workoutModelCount?.forEdit = true;
      workoutModelCount?.id = planModel?.id;
      count = planModel!.count;
      isTimeChecked = planModel!.isTimeChecked;
      if(!isAdded){
        isForSave = true;
        isAdded = true;
      }

    } else {
      workoutModel = item['model_count'] as WorkOutModel;
      count = item['count_count'] as int;
      isTimeChecked = item['is_time_checked_count'] as bool;
      if (!isAdded) {
        workoutModelCount!.workoutModelCount!.add(WorkoutModelCount(
            workOutModel: workoutModel!.id!,
            count: count!,
            isTime: isTimeChecked!));
        isAdded = true;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(alignment: Alignment.topLeft, child: backButton(context, backToMain: () {
                  final plan = PlanModel(
                      id: workoutModelCount?.forEdit == true ? workoutModelCount?.id : null,
                      name: title,
                      countModelList: workoutModelCount!.workoutModelCount!,
                      count: count!,
                      isTimeChecked: isTimeChecked!);
                  saveAndNext(
                      plan,
                      context);
                })),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        isForSave
                            ? const SizedBox(
                                width: 5,
                              )
                            : const SizedBox(),
                        isForSave
                            ? GestureDetector(
                                onTap: () async {
                                  title = await Navigator.pushNamed(
                                      context, nameWorkoutScreen, arguments: title) as String;
                                  setState(() {});
                                },
                                child: const Icon(FinalCreateIcons.edit, size: 18, color: Color(0xffA96BEA),))
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      child: Text(
                        !isForSave ? edit.tr() : save.tr(),
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                          isForSave = !isForSave;
                          setState(() {});

                        // setState(() {});
                      },
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
            !isForSave ?
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "${workoutModelCount?.workoutModelCount?.length} ${exercises.tr()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    onTap: () {
                      changeScreen(chooseWorkoutScreen, context,
                          argument: title);
                    },
                  ),
                ],
              ),
            ) : const SizedBox(),
            !isForSave ?Divider(
              color: const Color(0xff0E1618).withOpacity(0.1),
              height: 2,
              thickness: 1,
            ): const SizedBox(),
            Expanded(
              child: !isForSave ? ListView.builder(
                itemBuilder: (context, position) {
                  return listItem(position, context);
                },
                shrinkWrap: true,
                itemCount: workoutModelCount?.workoutModelCount!.length,
              )
                  : ReorderableListView.builder(itemBuilder: (context, position){
                return listItem(position, context);
              }, itemCount: workoutModelCount != null ? workoutModelCount!.workoutModelCount!.length: 0,

                  onReorder: (oldIndex, newIndex){
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex = newIndex - 1;
                    }
                    final element = workoutModelCount!.workoutModelCount!.removeAt(oldIndex);
                    workoutModelCount!.workoutModelCount!.insert(newIndex, element);
                  });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget listType(int position) =>
  ListTile(
    key: ValueKey(workoutModelCount!.workoutModelCount![position]),
    title: Text(workoutModelCount!.workoutModelCount![position].workOutModel.toString()),
  );

  Widget listItem(int position, BuildContext context)
    => Card(
      key: ValueKey(workoutModelCount?.workoutModelCount?[position]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 20),
            child: Row(
              children: [
                isForSave ? const Icon(FinalCreateIcons.burger, size: 18, color: Color(0xff919BA9),) : const SizedBox(),
                isForSave ? const SizedBox(width: 10,) : const SizedBox(),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/training/${workoutModelCount?.workoutModelCount?[position].workOutModel?? 1}.jpg",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              getTime(
                                  workoutModelCount?.workoutModelCount?[position].isTime ?? false,
                                  workoutModelCount?.workoutModelCount?[position].count ?? 0,
                                  nextLine: true),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FutureBuilder(
                            future: databaseHelper.getWorkoutModel(
                                workoutModelCount?.workoutModelCount?[position]
                                    .workOutModel ?? 1),
                            builder: ((context, snapshot) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  snapshot.data != null ? snapshot.data!.name : "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isForSave ? GestureDetector(
                  onTap: (){
                    setState(() {
                      workoutModelCount!.workoutModelCount!.removeAt(position);
                      if(workoutModelCount!.workoutModelCount!.isEmpty){
                        isForSave = false;
                      }
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/images/recycle.svg",
                    height: 20,
                    color: Colors.grey,
                  ),
                ): SizedBox()
              ],
            ),
          ),
          Divider(
            color: const Color(0xff0E1618).withOpacity(0.1),
            height: 2,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  void saveAndNext(PlanModel planModel, BuildContext context) {
  if(workoutModelCount!.workoutModelCount!.isEmpty){
    workoutModelCount?.workoutModelCount!.clear();
    workoutModelCount = null;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
      return MainMenuScreen(numer: 2,);
    }), (r){
      return false;
    });
  } else {
    if (workoutModelCount!.forEdit) {
      databaseHelper.updatePlan(planModel);
    } else {
      databaseHelper.insertPlan(planModel);
    }
    workoutModelCount?.workoutModelCount!.clear();
    workoutModelCount = null;
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (BuildContext context) {
      return MainMenuScreen(numer: 2,);
    }), (r) {
      return false;
    });
  }
}
