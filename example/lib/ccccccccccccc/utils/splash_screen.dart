import 'dart:async';
import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

enum CheckSplashTypeEnum { video, image }

class _SplashScreenState extends State<SplashScreen> {
  String path = "";
  String path1 = "";
  CheckSplashTypeEnum? checkSplashTypeEnum;
  int duration = 3;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    if (path.isEmpty) {
      path1 = path;
    } else if (path.endsWith(".mp4") || path.endsWith(".webm")) {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(path));
      videoPlayerController.initialize().then((value) {
        duration = videoPlayerController.value.duration.inSeconds;
        setState(() {});
      });
      videoPlayerController.play();
      checkSplashTypeEnum = CheckSplashTypeEnum.video;
    } else if (path.endsWith(".gif") || path.endsWith(".png") || path.endsWith(".jpg") || path.endsWith(".svg")) {
      path1 = path;
      checkSplashTypeEnum = CheckSplashTypeEnum.image;
    }
    super.initState();
    Future.delayed(const Duration(seconds: 1), () => timer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      body: checkSplashTypeEnum == null
          ? Stack(
              children: [
                CommonWidget.imageBuilder(
                  imageUrl: "assets/png/splash.png",
                  fit: BoxFit.cover,
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().screenHeight,
                ),
              ],
            )
          : checkSplashTypeEnum == CheckSplashTypeEnum.video
              ? Center(child: CommonWidget.sizedBox(height: 200, child: VideoPlayer(videoPlayerController)))
              : Center(child: CommonWidget.imageBuilder(imageUrl: path1)),
    );
  }

  void timer() {
    Timer(
      Duration(seconds: duration),
      () {
        CommonRouter.pushReplacementNamed(RouteList.app_home);

        // log('isFirst ==> $isFirst');
        // log('isTourCompleted ==> $isTourCompleted');
        // log('User Token ==> $userToken');
        // if (isFirst) {
        //   CommonRouter.pushReplacementNamed(RouteList.introduction_screen);
        // } else {
        //   // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        //   // String? uid = firebaseAuth.currentUser?.uid;
        //   // if (uid == null) {
        //   //   CommonRouter.pushReplacementNamed(RouteList.login_screen);
        //   // } else {
        //   //   CommonRouter.pushReplacementNamed(RouteList.app_home);
        //   // }
        //   if ((!isTourCompleted) && (userToken == null)) {
        //     CommonRouter.pushReplacementNamed(RouteList.login_screen);
        //   } else {
        //     CommonRouter.pushReplacementNamed(RouteList.app_home);
        //   }
        // }
      },
    );
  }
}
