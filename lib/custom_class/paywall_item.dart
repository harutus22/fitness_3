import 'package:fitness/custom_class/paywall_line_drawer.dart';
import 'package:fitness/utils/colors.dart';
import 'package:flutter/material.dart';

class PaywallItemUnderline extends StatefulWidget {
  PaywallItemUnderline({Key? key, required this.image, required this.title}) : super(key: key);

  String image;
  String title;

  @override
  State<PaywallItemUnderline> createState() => _PaywallItemUnderlineState();
}

class _PaywallItemUnderlineState extends State<PaywallItemUnderline> {
  double width = 0;

  GlobalKey? _widthKey;

  @override
  void initState() {
    _widthKey ??= GlobalKey();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_getWidgetInfo);
  }

  void _getWidgetInfo(_) {
    final RenderBox renderBox = _widthKey!.currentContext?.findRenderObject() as RenderBox;

    width = renderBox.size.width;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      key: _widthKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(widget.image, height: 20,),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                overflow: TextOverflow.visible,
                softWrap: true,
              )
            ],
          ),
          SizedBox(height: 5,),
          CustomPaint(
            painter: PaywallCustomLine(index: width, circle: mainColor),
          )
        ],
      ),
    );
  }
}
