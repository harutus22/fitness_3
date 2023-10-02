import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/custom_class/custom_graphic.dart';
import 'package:fitness/custom_class/mass_index_painter.dart';
import 'package:fitness/model/user_info_enums.dart';
import 'package:fitness/utils/calculations.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:video_player/video_player.dart';

import '../../utils/back_button.dart';
import '../../utils/custom_radio_button.dart';
import '../../utils/next_button.dart';
import '../../utils/routes.dart';

class PlanCalculationScreen extends StatefulWidget {
  const PlanCalculationScreen({Key? key}) : super(key: key);

  @override
  State<PlanCalculationScreen> createState() => _PlanCalculationScreenState();
}

class _PlanCalculationScreenState extends State<PlanCalculationScreen> {
  double height = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: backButton(context)),
                Expanded(
                    flex: 3,
                    child: Image.asset(
                      "assets/images/onboard_13.png",
                      alignment: Alignment.bottomLeft,
                    ))
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: Container(
                height: height / 7,
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: height / 7,
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
                              dailyCaloriesNeedsResult(null).toStringAsFixed(2),
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
                              height: height / 7,
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
                              user.gender == Gender.male
                                  ? basalMetabolicRateMale(null).toStringAsFixed(2)
                                    : basalMetabolicRateFemale(null)
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
                              icon: const Icon(
                                Icons.info,
                                color: Color(0xff919BA9),
                              )),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
               width: MediaQuery.of(context).size.width - 40,
               decoration: BoxDecoration(
                    border: const GradientBoxBorder(
                      gradient: linearGradient,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomPaint(
                  painter: CustomGraphic(isMore: user.targetWeight < user.weight),
                )
                // SfCartesianChart(series: <ChartSeries>[
                //   // Renders line chart
                //   SplineSeries<ChartData, int>(
                //     cardinalSplineTension: 0.5,
                //       splineType: SplineType.natural,
                //       markerSettings: MarkerSettings(
                //         isVisible: false
                //       ),
                //       dataSource: chartData,
                //       xValueMapper: (ChartData data, _) => data.x,
                //       yValueMapper: (ChartData data, _) => data.y)
                // ],primaryXAxis: CategoryAxis(
                //   isVisible: false
                // ),
                // primaryYAxis: CategoryAxis(
                //   isVisible: false
                // ),
                //
                // )
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                        text: getWorkoutWeeks(),
                        style: TextStyle(
                          foreground: Paint()..shader = textLinearGradient,
                        )),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text(
                        weeksText.tr(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ),
                  ],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            next(context, loaderScreen, true, () {
              user.totalCount = (user.firstCount.index +
                  user.secondCount.index +
                  user.thirdCount.index) ~/
                  3;
              user.totalCount < 2 ? user.totalCount = 2 : user.totalCount;
              sendEvent("onboarding_14");
              setUser(user);
              setPassed();
            }, text: getMyPlan.tr()),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getWorkoutWeeks(){
    double result = user.targetWeight - user.weight;
   result *= result < 0 ? -1 : 1;
   String total = result != 0 ? "${(result - 1).toInt()}-${result.toInt()} " : "0 ";
   return total;
  }
}

final List<ChartData> chartData = [
  ChartData(4, 400),
  ChartData(5, 1600),
  ChartData(6, 6400),
  ChartData(7, 25600),
  // ChartData(2014, 40)
];

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double y;
}
