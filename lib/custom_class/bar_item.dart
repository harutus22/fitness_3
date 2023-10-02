import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class TopBarItem extends StatelessWidget {
  const TopBarItem({Key? key, required this.count}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20)
          ),
          color:  Color(0xff0E1618).withOpacity(0.1)
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: List.generate(17, (index){
          return Container(
            height: 10,
            width: (MediaQuery.of(context).size.width - 20) / 17,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                    left: index == 0 ? Radius.circular(20) : Radius.zero,
                    right: index == 16 ? Radius.circular(20) : Radius.zero
                ),
                color: index < count ? mainColor : Color(0xff0E1618).withOpacity(0.1)
            ),
          );
        }),
      ),
    );
  }
}
