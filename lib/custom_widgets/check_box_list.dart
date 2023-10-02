import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/model/custom_check_box_model.dart';
import 'package:fitness/model/user_info_enums.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MenuListView extends StatefulWidget {
  const MenuListView({Key? key, required this.passChosen}) : super(key: key);

  final Function(List<CheckBoxState>) passChosen;
  @override
  _MenuListViewState createState() => _MenuListViewState();
}

class _MenuListViewState extends State<MenuListView> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: List.generate(list.length, (index) => image(list[index])),
    );
  }

  Widget image(CheckBoxState item) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            alignment: Alignment.center,
            width: 120,
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: !item.value
                ? BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),)
                : BoxDecoration(
              border: Border.all(color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: mainColor
            ),
            child: Text(item.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15,
              fontFamily: mainFont),),

          ),
        ),
        onTap: () {
          item.value = !item.value;
          widget.passChosen(list);
          setState(() {});
        },
      ),
    );
  }

  final list = [
    CheckBoxState(title: toned_arms.tr(), focusArea: FocusArea.arm),
    CheckBoxState(title: flat_belly.tr(), focusArea: FocusArea.chest),
    CheckBoxState(title: round_butt.tr(), focusArea: FocusArea.abs),
    CheckBoxState(title: slim_legs.tr(), focusArea: FocusArea.leg),
    CheckBoxState(title: full_slimming.tr(), focusArea: FocusArea.fullBody),
  ];
}
