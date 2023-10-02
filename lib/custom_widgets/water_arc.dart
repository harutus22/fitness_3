import 'package:fitness/model/user_info.dart';
import 'package:fitness/model/water_model.dart';
import 'package:flutter/cupertino.dart';

import '../custom_class/water_arc.dart';

class WaterArcus extends StatefulWidget {
  const WaterArcus({Key? key, required this.size, required this.user,
    required this.waterModel, required this.progress}) : super(key: key);

  final Size? size;
  final UserInfo user;
  final WaterModel waterModel;
  final double progress;

  @override
  State<WaterArcus> createState() => _WaterArcusState();
}

class _WaterArcusState extends State<WaterArcus> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> animation;
  late Tween<double> valueTween;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    this.valueTween = Tween<double>(
      begin: 0,
      end: widget.progress,
    );
    // animation = Tween(begin: 0.0, end: water.water! / 250 / user.waterLimit).animate(controller);
    //   animation.addListener(() {
    //     setState(() {
    //       progress = animation.value;
    //     });
    //   });
    controller.forward();

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(

            painter: WaterArc(sizePass: widget.size,
                width: MediaQuery.of(context).size.width / 9,
                limit: widget.user.waterLimit, alreadyDrunk: widget.waterModel.water! ~/ 250,
                progress: valueTween.evaluate(controller))
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant WaterArcus oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.progress != oldWidget.progress){
      double beginValue = valueTween.evaluate(controller) ?? oldWidget.progress ?? 0;
      valueTween = Tween<double>(
        begin: beginValue,
        end: widget.progress ?? 1,
      );

      this.controller
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
