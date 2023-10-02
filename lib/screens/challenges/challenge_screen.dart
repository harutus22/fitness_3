import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/challane_model.dart';
import 'package:fitness/screens/challenges/challenge_detailed_screen.dart';
import 'package:fitness/screens/challenges/challenge_item.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../model/plan_model_static.dart';
import '../../utils/const.dart';

const String challenge_model = "challenge_plan";
const String challenge_plans = "challenge_static_plan";
const String challenge_item = "challenge_item";

class ChallengeMainScreen extends StatefulWidget {
  const ChallengeMainScreen({Key? key}) : super(key: key);

  @override
  State<ChallengeMainScreen> createState() => _ChallengeMainScreenState();
}

class _ChallengeMainScreenState extends State<ChallengeMainScreen> {

  late List<PlanModelStatic> staticList;
  List<ChallengeModel> challengeList = [];

  @override
  void initState() {
    databaseHelper.getStaticPlanModels().then((value) =>
    {
      staticList = value,
      databaseHelper.getChallenges().then((value) => {
        challengeList = value,
        setState((){}),
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Wrap(
                runSpacing: 0,
                spacing: 5,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                        challenges.tr().toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black
                        )
                        ,textAlign: TextAlign.start),
                  )

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: challengeList.isEmpty ? Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ) : ListView.builder(
                      itemBuilder: (context, position) {
                        return Column(
                          children: [
                            ChallengeItem(
                              challengeModel: challengeList[position],
                              challengeFunction: () {
                                final name = challengeList[position].name?.split(" challenge");
                                List<PlanModelStatic> item = staticList.where((element) =>
                                element.type?.toLowerCase() == name?.first.toLowerCase()
                                ).toList();
                                 List<PlanModelStatic> finalModels = [];
                                 int startPos = position % 2 == 0 ? 0 : item.length ~/ 2;
                                 int endPos = position % 2 == 0 ? item.length ~/ 2 : item.length;
                                for(var a = startPos; a < endPos ; a++){
                                  finalModels.add(item[a]);
                                }
                                Map<String, Object> itemToSend = {
                                  challenge_model: challengeList[position],
                                  challenge_plans: finalModels
                                };
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                  return ChallengeDetailedScreen(map: itemToSend);
                                }));
                              },
                            ),
                            SizedBox(height: 20,)
                          ],
                        );
                      },
                      itemCount: challengeList.length))
            ],
          ),
        ),
      ),
    );
  }
}
