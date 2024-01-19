import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/features/news/presentation/pages/news_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonNewsWidget {
  static Widget newsRow(int index) {
    return GestureDetector(
      onTap: () => CommonRouter.pushNamed(RouteList.single_news_screen, arguments: newsList[index]),
      child: CommonWidget.container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        color: appConstants.whiteBackgroundColor,
        borderRadius: 10.r,
        child: Row(
          children: [
            SizedBox(
              width: 125.w,
              height: 95.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  newsList[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                children: [
                  CommonWidget.commonText(
                    text: newsList[index].title,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: appConstants.textColor,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5.h),
                  CommonWidget.commonText(
                    text: newsList[index].description,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: appConstants.greyTextColor,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5.h),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CommonWidget.commonText(
                      text: newsList[index].date,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: appConstants.greyTextColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
