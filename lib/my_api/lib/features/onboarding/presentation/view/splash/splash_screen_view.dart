import 'dart:async';
import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String path = "";
  String path1 = "";
  int checkSplash = 0;
  int duration = 5;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    if (path.isEmpty) {
      path1 = path;
      checkSplash = 0;
    } else if (path.endsWith(".mp4")) {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(path));
      videoPlayerController.initialize().then((value) {
        duration = videoPlayerController.value.duration.inSeconds;
        setState(() {});
      });
      videoPlayerController.play();
      checkSplash = 1;
    } else if (path.endsWith(".gif") || path.endsWith(".png") || path.endsWith(".jpg")) {
      path1 = path;
      checkSplash = 2;
    } else if (path.endsWith(".svg")) {
      path1 = path;
      checkSplash = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () => timer());
    return Scaffold(
      backgroundColor: appConstants.white,
      body: checkSplash == 0
          ? Stack(
              children: [
                CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/onboarding/splash_bg.svg"),
                Center(
                  child: CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/onboarding/bakery_shop_logo.svg",
                    borderRadius: 15.r,
                    width: ScreenUtil().screenWidth - 200.h,
                  ),
                ),
              ],
            )
          : checkSplash == 1
              ? Center(child: SizedBox(height: 200, child: VideoPlayer(videoPlayerController)))
              : checkSplash == 2
                  ? Center(child: Image.network(path1, height: 200, width: 200))
                  : Center(child: SvgPicture.network(path1)),
    );
  }

  void timer() {
    Timer(
      Duration(seconds: duration),
      () {
        // log('isFirst ==> $isFirst');
        // log('isTourCompleted ==> $isTourCompleted');
        // log('User Token ==> $userToken');
        // if (isFirst) {
        //   CommonRouter.pushReplacementNamed(RouteList.introduction_screen);
        // } else {
        // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        // String? uid = firebaseAuth.currentUser?.uid;
        // if (uid == null) {
        //   CommonRouter.pushReplacementNamed(RouteList.login_screen);
        // } else {
        //   CommonRouter.pushReplacementNamed(RouteList.app_home);
        // }
        if (userToken == null) {
          CommonRouter.pushReplacementNamed(RouteList.login_screen);
        } else {
          CommonRouter.pushReplacementNamed(RouteList.app_home);
        }
        //   }
      },
    );
  }
}
