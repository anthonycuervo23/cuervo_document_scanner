import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/features/home_screen/presentation/widgets/common_home_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('dd MMM, EEEE');
Widget allMatchDetails({required BuildContext context}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dateText(text: formatter.format(DateTime.now().subtract(const Duration(days: 4)))),
          matchScoreCard(index: 3, context: context),
          dateText(text: formatter.format(DateTime.now().subtract(const Duration(days: 3)))),
          matchScoreCard(index: 2, context: context),
          dateText(text: formatter.format(DateTime.now().subtract(const Duration(days: 2)))),
          matchScoreCard(index: 4, context: context),
          dateText(text: formatter.format(DateTime.now().subtract(const Duration(days: 1)))),
          matchScoreCard(index: 2, context: context),
        ],
      ),
    ),
  );
}

Widget matchScoreCard({required int index, required BuildContext context}) {
  return ListView.builder(
    itemCount: index,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => CommonRouter.pushNamed(RouteList.score_screen),
        child: CommonHomeWidget.commonScoreDetailBox(context :context),
      );
    },
  );
}

Widget dateText({required String text}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    child: CommonWidget.commonText(
      text: text,
      color: appConstants.textColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),
  );
}
