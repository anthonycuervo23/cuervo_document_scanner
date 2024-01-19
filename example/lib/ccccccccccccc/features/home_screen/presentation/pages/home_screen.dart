import 'package:captain_score/features/home_screen/presentation/pages/home_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomeWidget {
  final List<String> imgList = ["assets/svgs/home_screen/background.png"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appConstants.greyBackgroundColor,
        appBar: appBar(context),
        body: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: TabBarView(
            children: [
              homeView(context),
              liveView(context),
            ],
          ),
        ),
      ),
    );
  }
}
