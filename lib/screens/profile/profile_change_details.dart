import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/user_info.dart';
import 'package:fitness/utils/const.dart';
import 'package:flutter/material.dart';

import '../../model/user_info_enums.dart';
import '../../utils/Routes.dart';
import '../../utils/back_button.dart';
import '../../utils/colors.dart';
import '../../utils/custom_radio_button.dart';
import '../../utils/words.dart';

class ProfileChangeDetails extends StatefulWidget {
  const ProfileChangeDetails({Key? key}) : super(key: key);

  @override
  State<ProfileChangeDetails> createState() => _ProfileChangeDetailsState();
}

class _ProfileChangeDetailsState extends State<ProfileChangeDetails> {

  String? _groupValue;
  
  @override
  void initState() {
    getUser().then((value) => user = value).whenComplete(() => setState((){
      _chosenGoal = user!.mainGoal.index;
      count = user!.totalCount.toDouble();
      _groupValue = count.round().toString();
    }));
    super.initState();
  }

  int _chosenGoal = -1;
  UserInfo? user;
  double count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  backButton(context),
                  Text(
                    changeDetails.tr(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: (){
                      user!.totalCount = int.parse(_groupValue!);
                      user!.mainGoal = MainGoal.values[_chosenGoal];
                      setUser(user!);
                      popScreen(context, argument: false);
                    },
                    child: Text(okText.tr(), style: TextStyle(
                      foreground: Paint()..shader = textLinearGradient,
                        fontSize: 24, fontWeight: FontWeight.bold
                    ),),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Text(
                mainGoalsChange.tr(),
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicHeight (child: destinationItem(0, lose_weight.tr())),
                    IntrinsicHeight (child: destinationItem(1, build_muscle.tr())),
                    IntrinsicHeight (child: destinationItem(2, stay_fit.tr())),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: count.round().toString(),
                            style: TextStyle(
                                foreground: Paint()..shader = textLinearGradient, fontSize: 30)),
                        const WidgetSpan(child: SizedBox(width: 5,)),
                        TextSpan(
                          text: timesAWeek.tr(),
                        ),
                      ],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      )),
                ),
              ),
              const SizedBox(height: 20,),
              const Divider( thickness: 3, color: Color(0xffEFF2F6)),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: MyRadioOption<String>(
                      value: '2',
                      groupValue: _groupValue,
                      onChanged: _valueChangedHandler(),
                      label: '2',
                      text: "2 ${timeCount.tr()}",
                    ),
                  ),
                  Flexible(
                    child: MyRadioOption<String>(
                      value: '3',
                      groupValue: _groupValue,
                      onChanged: _valueChangedHandler(),
                      label: '3',
                      text: "3 ${timeCount.tr()}",
                    ),
                  ),
                  Flexible(
                    child: MyRadioOption<String>(
                      value: '4',
                      groupValue: _groupValue,
                      onChanged: _valueChangedHandler(),
                      label: '4',
                      text: "4 ${timeCount.tr()}",
                    ),
                  ),
                  Flexible(
                    child: MyRadioOption<String>(
                      value: '5',
                      groupValue: _groupValue,
                      onChanged: _valueChangedHandler(),
                      label: '5',
                      text: "5 ${timeCount.tr()}",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Divider( thickness: 3, color: Color(0xffEFF2F6)),
            ],
          ),
        ),
      ),
    );
  }

  Widget destinationItem(int count, String title){
    return InkWell(
      onTap: (){
        _chosenGoal = count;
        setState(() {});
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 7 * 2,
        height: MediaQuery.of(context).size.width / 5,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        alignment: Alignment.center,
        decoration: count == _chosenGoal ? BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorMainGradLeft,
              colorMainGradRight
            ],
          ),
          border: Border.all(width: 1, color: const Color(0xffA16DEA))
        ) : BoxDecoration(
            border: Border.all(color: const Color(0xffA16DEA), width: 1)
        ),
        child: Text(
          title, style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black
        ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => {
      setState(() =>
      _groupValue = value!
      )
    };
  }
}
