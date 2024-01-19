import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/score/score_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends ScoreWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: appConstants.greyBackgroundColor,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonWidget.commonText(
                text: "AUS".toUpperCase(),
                color: appConstants.whiteBackgroundColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
              CommonWidget.sizedBox(width: 6.w),
              CommonWidget.commonText(
                text: "VS".toUpperCase(),
                color: appConstants.yellow,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              CommonWidget.sizedBox(width: 6.w),
              CommonWidget.commonText(
                text: "PAK".toUpperCase(),
                color: appConstants.whiteBackgroundColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          leading: InkWell(
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.all(appConstants.transparent),
            onTap: () => CommonRouter.pop(),
            child: Icon(Icons.arrow_back, color: appConstants.whiteBackgroundColor),
          ),
          titleSpacing: 0,
          centerTitle: false,
          flexibleSpace: CommonWidget.commonLinearGradient(),
          bottom: TabBar(
            overlayColor: MaterialStateProperty.all(appConstants.transparent),
            labelColor: appConstants.whiteBackgroundColor,
            indicatorColor: appConstants.whiteBackgroundColor,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            dividerColor: Colors.red,
            unselectedLabelColor: appConstants.whiteBackgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(text: TranslationConstants.live.translate(context)),
              Tab(text: TranslationConstants.info.translate(context)),
              Tab(text: TranslationConstants.scorecard.translate(context)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            scoreData(context),
            infoData(context),
            scorecard(),
          ],
        ),
      ),
    );
  }
}
