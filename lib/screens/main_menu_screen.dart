// import 'package:alarm/alarm.dart';
import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/screens/challenges/challenge_screen.dart';
import 'package:fitness/screens/create/create_main_screen.dart';
import 'package:fitness/screens/plan/work_out_plan_main_screen.dart';
import 'package:fitness/screens/profile/profile_main_screen.dart';
import 'package:fitness/utils/custom_icons/create_final_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/Routes.dart';
import '../utils/colors.dart';
import '../utils/const.dart';
import '../utils/notification_class.dart';
import '../utils/words.dart';

class MainMenuScreen extends StatefulWidget {
  MainMenuScreen({Key? key, this.numer}) : super(key: key);

  int? numer = null;

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  var _selectedIndex = 0;
  final iconSize = 20.0;
  final pages = [
    const WorkOutPlanMainScreen(),
    const ChallengeMainScreen(),
    const CreateMainScreen(),
    const ProfileMainScreen()
  ];

  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
    // if(!user.isSubscribed)
    //   createInterstitialAd('ca-app-pub-5842953747532713/1780274234');
    super.initState();
    if (widget.numer != null) {
      _selectedIndex = widget.numer!;
    }
    inita();
  }

  void inita() async {
    await databaseHelper.init();
    // await Alarm.init();
  }

  @override
  void dispose() {
    super.dispose();
    // databaseHelper.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: pages.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: bottomItemColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon:
          //   Icon(
          //     FinalCreateIcons.lightning,
          //     size: iconSize,
          //   ),
          //   label: plan.tr(),
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/menu_home.svg",
                height: iconSize,
                width: iconSize,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 0 ? Colors.black : Colors.grey,
                    BlendMode.srcIn)),
            label: plan.tr(),
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/menu_challenges.svg",
                  height: iconSize,
                  width: iconSize,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 1 ? Colors.black : Colors.grey,
                      BlendMode.srcIn)),
              // Icon(
              //   FinalCreateIcons.trophy,
              //   size: iconSize,
              // ),
              label: challenges.tr()),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/menu_create.svg",
                  height: iconSize,
                  width: iconSize,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 2 ? Colors.black : Colors.grey,
                      BlendMode.srcIn)),
              // Icon(
              //   FinalCreateIcons.edit,
              //   size: iconSize,
              // ),
              label: create.tr()),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/menu_profile.svg",
                  height: iconSize,
                  width: iconSize,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 3 ? Colors.black : Colors.grey,
                      BlendMode.srcIn)),
              // Icon(
              //   FinalCreateIcons.people_icon,
              //   size: iconSize,
              // ),
              label: profile.tr()),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 2 && !user.isSubscribed) {
      changeScreen(payWallScreen, context, argument: canPop);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
