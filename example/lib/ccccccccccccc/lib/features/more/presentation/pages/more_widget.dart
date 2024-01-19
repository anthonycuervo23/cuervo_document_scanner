import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/features/more/presentation/pages/more_screen.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class MoreWidget extends State<MoreScreen> {
  Widget screenView() {
    return CommonWidget.container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      padding: EdgeInsets.only(top: 8.h),
      color: appConstants.whiteBackgroundColor,
      borderRadius: 10.r,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonTile(
              svgPath: 'assets/svgs/more_icon/theme_icon.svg',
              text: TranslationConstants.theme.translate(context),
            ),
            commonTile(
              svgPath: 'assets/svgs/more_icon/rate_us.svg',
              text: TranslationConstants.rate_us.translate(context),
            ),
            commonTile(
              svgPath: 'assets/svgs/more_icon/privacy_policy.svg',
              text: TranslationConstants.privacy_policy.translate(context),
            ),
            commonTile(
              svgPath: 'assets/svgs/more_icon/share_app.svg',
              text: TranslationConstants.share_app.translate(context),
            ),
            commonTile(
              svgPath: 'assets/svgs/more_icon/version_icon.svg',
              text: TranslationConstants.version.translate(context),
              isDivider: false,
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget commonTile({
    required String svgPath,
    required String text,
    bool isDivider = true,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: appConstants.greyColor1,
                  child: CommonWidget.imageBuilder(
                    imageUrl: svgPath,
                    height: 20.r,
                    color: appConstants.greyTextColor,
                  ),
                ),
                CommonWidget.sizedBox(width: 20),
                CommonWidget.commonText(
                  text: text,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          isDivider == true
              ? Divider(
                  color: appConstants.dividerColor,
                  thickness: 0.5,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
