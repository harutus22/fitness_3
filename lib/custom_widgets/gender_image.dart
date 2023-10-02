import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom_class/text_painter.dart';

class GenderImage extends StatefulWidget {
  GenderImage(
      {Key? key,
        required this.isClicked,
        required this.image,
        required this.gender,
        required this.click})
      : super(key: key);

  bool isClicked;
  final String image;
  final String gender;
  final Function() click;
  bool slided = false;

  @override
  State<GenderImage> createState() => _GenderImageState();
}

class _GenderImageState extends State<GenderImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.3,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            border: Border.all(
                color: !widget.isClicked ?Color(0xff0E1618).withOpacity(0.40): Color(0xff0E1618),
                width: 2
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -20,
                top: 10,
                child: widget.isClicked ? SvgPicture.asset("assets/images/checked.svg", height: 30,): SizedBox(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    height: MediaQuery.of(context).size.height / 4,
                    widget.image,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.gender.tr(),
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  )
                ],
              ),
            ]),
      ),
      onTap: () {
        widget.click();
      },
    );
  }
}
