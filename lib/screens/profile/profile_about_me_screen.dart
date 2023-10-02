import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/user_info.dart';
import 'package:fitness/screens/profile/change_weight_height.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../../custom_class/mass_index_painter.dart';
import '../../model/user_info_enums.dart';
import '../../utils/back_button.dart';
import '../../utils/calculations.dart';
import '../../utils/colors.dart';
import '../../utils/routes.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({Key? key}) : super(key: key);

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  @override
  void initState() {
    getUser().then((value) => user = value).whenComplete(() => setState(() {
      isMale = user!.gender == Gender.male ? true : false;
    }));
    super.initState();
  }

  UserInfo? user;
  bool isMale = false;
  double chooseHeight = 0;
  double chooseWidth = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    chooseWidth = size.width * 0.5;
    chooseHeight = size.height * 0.04;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: backButton(context)),
                Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        aboutMe.tr(),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () async{
                  final map = {
                  "is_height" : true,
                  "weight_height": user!.height.toInt(),
                  };
                  final item  = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeWeightHeight(map: map)),
                  );
                  user!.height = double.parse(item);
                  setUser(user!);
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      heightText.tr(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [colorMainGradLeft, colorMainGradRight],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: Text("${user?.height.toInt()} ${cm.tr()}",style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Divider( thickness: 1, color: Color(0xff282E3C).withOpacity(0.5)),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: ()async{
                  final map = {
                    "is_height" : false,
                    "weight_height": user!.weight.toInt(),
                  };
                  final item =  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeWeightHeight(map: map)),
                  );
                  user!.weight = double.parse(item);
                  setUser(user!);
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      weightTextUpper.tr(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [colorMainGradLeft, colorMainGradRight],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds),
                      child: Text("${user?.weight.toStringAsFixed(1)} ${kg.tr()}",style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Divider( thickness: 1, color: Color(0xff282E3C).withOpacity(0.5)),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(genderTxt.tr(),style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
                  Flexible(child: Align(child: maleOrFemale(), alignment: Alignment.centerRight,)),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 5.0, right: 5.0, top: 30.0),
                  child: Container(
                    height: size.height / 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0xffDCDCDC), width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    massIndexCalculation().toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900, fontSize: 30),
                                  ),
                                ),
                              ),
                              Text(
                                bodyMassIndex.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        changeScreen(bodyMassIndexScreen, context);
                                      },
                                      icon: const Icon(
                                        Icons.info,
                                        color: Color(0xff919BA9),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            child: CustomPaint(
                              size: Size(MediaQuery.of(context).size.width, 70),
                              painter: MassIndexPainter(
                                  context: context,
                                  trianglePos: massIndexCalculation()
                                // trianglePos: 16.1035
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: size.height / 7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              border: Border.all(
                                  color: const Color(0xffDCDCDC), width: 2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  dailyCaloriesNeedsResult(user).toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900, fontSize: 26),
                                ),
                                Text(
                                  dailyCalories.tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: size.height / 7,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: const Color(0xffDCDCDC), width: 2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        user?.gender == Gender.male
                                            ? basalMetabolicRateMale(user).toStringAsFixed(2)
                                            : basalMetabolicRateFemale(user)
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900, fontSize: 26),
                                      ),
                                      Text(
                                        basalMetabolicRate.tr(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    changeScreen(
                                        basalMetabolicRateScreen,
                                        context);
                                  },
                                  icon: Container(
                                    margin: const EdgeInsets.all(2.0),
                                    child: const Icon(
                                      Icons.info,
                                      color: Color(0xff919BA9),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      )),
    );
  }

  double massIndexCalculation(){
    final height = user == null ? 0 : user!.height / 100;
    return user != null ?  user!.weight / (height * height) : 0;
  }

  Widget maleOrFemale(){
    return Container(
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
                isMale = true;
                user!.gender = Gender.male;
                setUser(user!);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: chooseHeight,
                decoration: isMale
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
                  male.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isMale ?Colors.white : Colors.black ,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                isMale = false;
                user!.gender = Gender.female;
                setUser(user!);
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: chooseHeight,
                decoration: isMale
                    ?BoxDecoration(
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
                  female.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !isMale ? Colors.white : Colors.black ,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
