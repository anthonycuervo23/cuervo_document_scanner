import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  final String url;
  const VideoPlayScreen({super.key, required this.url});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController controller;
  String url = "";

  @override
  void initState() {
    url = widget.url;
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
    super.initState();
    controller.initialize();
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          context,
          onTap: () {
            controller.pause();
            CommonRouter.pop();
          },
        ),
        body: PopScope(
          onPopInvoked: (v) {
            if (v) {
              controller.pause();
            }
          },
          child: Center(
            child: SizedBox(
              height: 400.h,
              child: VideoPlayer(
                controller,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
