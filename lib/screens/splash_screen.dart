import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/utils/Routes.dart';
import 'package:fitness/utils/colors.dart';
import 'package:fitness/utils/const.dart';
import 'package:fitness/utils/next_button.dart';
import 'package:fitness/utils/words.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = VideoPlayerController.asset("assets/videos/splash_video.mp4")
    //   ..initialize().then((value) => {
    //         _controller.play(),
    //         _controller.setLooping(true),
    //         // Ensure the first frame is shown after the video is initialized.
    //         setState(() {})
    //       });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: SizedBox(
                // width: _controller.value.size.width,
                // height: _controller.value.size.height,
                // child: VideoPlayer(_controller),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        splash_text.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: mainFont,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ),
                Expanded(child:
                Center(child:
                GestureDetector(
                  onTap: (){
                    changeScreen(genderScreen, context);
                  },
                  child: Text(
                    tap_to_start.tr(),
                    style: TextStyle(
                        fontFamily: mainFont,
                        fontSize: 18,
                        color: mainColor
                    ),
                  ),
                ),)),
                // next(context, genderScreen, true, () {}),
                // const SizedBox(
                //   height: 35,
                // ),
                // RichText(
                //     text: TextSpan(
                //         style:
                //             const TextStyle(fontSize: 12, color: Colors.white),
                //         children: [
                //       TextSpan(
                //         text: termsOfUse.tr(),
                //         recognizer: TapGestureRecognizer()..onTap = () {},
                //         style: const TextStyle(
                //             decoration:
                //                 TextDecoration.underline), //<-- SEE HERE
                //       ),
                //       TextSpan(text: " ${and.tr()} "),
                //       TextSpan(
                //         text: privacy.tr(),
                //         recognizer: TapGestureRecognizer()..onTap = () {},
                //         style: const TextStyle(
                //             decoration:
                //                 TextDecoration.underline), //<-- SEE HERE
                //       ),
                //     ])),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
