import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/input_formater/height_input_formatter.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../utils/back_button.dart';
import '../../utils/const.dart';
import '../../utils/input_formater/weight_input_formatter.dart';
import '../../utils/next_button.dart';
import '../../utils/routes.dart';

class ChangeWeightHeight extends StatefulWidget {
  const ChangeWeightHeight({Key? key, required this.map}) : super(key: key);
  final Map<String, Object> map;

  @override
  State<ChangeWeightHeight> createState() => _CurrentWeightScreenState();
}

class _CurrentWeightScreenState extends State<ChangeWeightHeight> {

  bool isHeightWeightChecked = false;
  double chooseHeight = 0;
  double chooseWidth = 0;
  bool isNextActive = true;
  bool isHeight = false;
  bool lowerMinimum = false;
  int weightHeight = 0;
  final _userController = TextEditingController();
  final height = ["Change your height", "Change your weight"];

  @override
  void initState() {
    isHeight = widget.map["is_height"] as bool;
    weightHeight = widget.map["weight_height"] as int;
    _userController.text = weightHeight.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chooseWidth = MediaQuery.of(context).size.width * 0.25;
    chooseHeight = MediaQuery.of(context).size.height * 0.04;
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: backButton(context)),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                      isHeight == true ? height[0] : height[1],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                      )
                  )
              ),
              // MenuGridView(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorGreyTextField,
                              border: Border.all(
                                  width: 1,
                                  color: colorGreyBoarder,
                                  style: BorderStyle.solid)),
                          child: TextFormField(
                            controller: _userController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [isHeight == true ? HeightInputFormatter(isCm: true) :  WeightInputFormatter(isKg: true)],
                            onChanged: (text) async {
                              if (text.isNotEmpty) {
                                double weight = double.parse(text);
                                if(!isHeight){
                                  if (weight < 40) {
                                    setState(() {
                                      lowerMinimum = true;
                                      isNextActive = false;
                                    });
                                  }
                                  else if (weight >= 40) {
                                    setState(() {
                                      lowerMinimum = false;
                                      isNextActive = true;
                                    });
                                  }
                                }
                              } else {
                                isNextActive = false;
                              }
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                hintText: enterCurrentWeight.tr(),
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        lowerMinimum
                            ? Align(
                            alignment: Alignment.centerRight,
                            child: Text("Minimum weight 40 kg",
                              style: TextStyle(color: Color(0xffFC0C0C)),
                            ))
                            : SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
              isNextActive ? InkWell(
                onTap: (){
                  final item = _userController.value.text;
                  FocusManager.instance.primaryFocus?.unfocus();
                  popScreen(context, argument: item);
                },
                child: Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    gradient: linearGradient,
                  ),
                  alignment: Alignment.center,
                  child: Text(doneTxt.tr(), style: const TextStyle(fontSize: 24,
                      color: Colors.white, fontWeight: FontWeight.bold),), ),
              ) :
              Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.grey,
                ),
                alignment: Alignment.center,
                child: Text(doneTxt.tr(), style: const TextStyle(fontSize: 24,
                    color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              const SizedBox()
            ],
          )),
    );
  }
  Timer? future;

  void futureJob(Function callback){
    if(future != null){
      if(future!.isActive){
        future!.cancel();
        future = Timer(Duration(milliseconds: 500), () {
          callback();
        });
      } else {
        future = Timer(Duration(milliseconds: 500), () {
          callback();
        });
      }
    } else {
      future = Timer(Duration(milliseconds: 500), () {
        callback();
      });
    }
  }
}
