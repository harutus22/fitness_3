import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
//   final bool value;
//   final ValueChanged<bool> onChanged;
//   final Color activeColor;
//   final Color inactiveColor;
//
//   const CustomSwitch({
//     Key? key,
//     required this.value,
//     required this.onChanged,
//     required this.activeColor,
//     this.inactiveColor = Colors.grey,
//   }) : super(key: key);
//
//   @override
//   _CustomSwitchState createState() => _CustomSwitchState();
// }
//
// class _CustomSwitchState extends State<CustomSwitch>
//     with TickerProviderStateMixin {
//   late Animation _circleAnimation;
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 60));
//     _circleAnimation = AlignmentTween(
//         begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
//         end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
//         .animate(CurvedAnimation(
//         parent: _animationController, curve: Curves.ease));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return InkWell(
//           onTap: () {
//             if (_animationController.isCompleted) {
//               _animationController.reverse();
//             } else {
//               _animationController.forward();
//             }
//             widget.value == false
//                 ? widget.onChanged(true)
//                 : widget.onChanged(false);
//           },
//           child: Ink(
//             width: 55.0,
//             height: 30.0,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.0),
//                 color: _circleAnimation.value == Alignment.centerLeft
//                     ? Colors.grey
//                     : widget.activeColor,
//                 gradient: _circleAnimation.value == Alignment.centerLeft
//                     ? null
//                     : linearGradient),
//             child: Padding(
//               padding: EdgeInsets.only(
//                 right: 2.0,
//                 left: 2.0,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   _circleAnimation.value == Alignment.centerRight
//                       ? const Spacer()
//                       : const Center(),
//                   Align(
//                     alignment: _circleAnimation.value,
//                     child: Ink(
//                       width: 26.0,
//                       height: 26.0,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   _circleAnimation.value == Alignment.centerLeft
//                       ? const Spacer()
//                       : const Center(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;

  const CustomSwitch(
      {Key? key,
        required this.value,
        required this.onChanged,
        required this.activeColor,
        this.inactiveColor = Colors.grey,
        this.activeText = '',
        this.inactiveText = '',
        this.activeTextColor = Colors.white70,
        this.inactiveTextColor = Colors.white70})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
        begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 70.0,
            height: 35.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: _circleAnimation!.value == Alignment.centerLeft ? const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.grey,
                ],
              ) : linearGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 0.0, right: 2.0, left: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation!.value == Alignment.centerRight
                      ? Padding(
                    padding: const EdgeInsets.only(left: 34.0, right: 0),
                    child: Text(
                      widget.activeText,
                      style: TextStyle(
                          color: widget.activeTextColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0),
                    ),
                  )
                      : Container(),
                  Align(
                    alignment: _circleAnimation!.value,
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  _circleAnimation!.value == Alignment.centerLeft
                      ? Padding(
                    padding: const EdgeInsets.only(left: 0, right: 34.0),
                    child: Text(
                      widget.inactiveText,
                      style: TextStyle(
                          color: widget.inactiveTextColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}