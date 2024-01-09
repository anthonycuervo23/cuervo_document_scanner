import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/refer_and_earn/how_it_work_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class HowItWorkWidget extends State<HowItWorkScreen> {
  Widget inviteFriendLorem() {
    return ListView.builder(
      itemCount: 4,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonWidget.commonBulletPoint(padding: EdgeInsets.only(right: 12.w), size: 5.r),
                  CommonWidget.commonText(
                    text: "${index + 1}. ",
                    style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonText(
                    text: TranslationConstants.invite_friend.translate(context),
                    style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: CommonWidget.sizedBox(
                  width: 300,
                  child: CommonWidget.commonText(
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .captionBookHeading
                        .copyWith(color: appConstants.default3Color, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget howItWorkLoremText() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: CommonWidget.commonText(
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        maxLines: 5,
        style: Theme.of(context)
            .textTheme
            .captionBookHeading
            .copyWith(color: appConstants.default1Color, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
