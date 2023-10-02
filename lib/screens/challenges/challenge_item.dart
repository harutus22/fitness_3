import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/challane_model.dart';
import 'package:fitness/model/plan_model_static.dart';
import 'package:fitness/model/work_out_plan_item_model.dart';
import 'package:fitness/utils/calculations.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

class ChallengeItem extends StatelessWidget {
  final ChallengeModel challengeModel;
  final Function() challengeFunction;

  const ChallengeItem(
      {Key? key, required this.challengeModel, required this.challengeFunction,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        challengeFunction();
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              challengeModel.image!,
            ),fit: BoxFit.cover,
          ),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      challengeModel.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: Colors.white
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      decoration: const BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ), child: Text(
                      startText.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.black, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
