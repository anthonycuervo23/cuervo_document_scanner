import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/help_support/help_support_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/help_support/help_and_support_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class HelpAndSupportWidget extends State<HelpAndSupportScreen> {
  late final HelpAndSupportCubit helpSupportCubit;
  @override
  void initState() {
    helpSupportCubit = getItInstance<HelpAndSupportCubit>();
    super.initState();
  }

  @override
  void dispose() {
    helpSupportCubit.close();
    super.dispose();
  }

  Widget commonBox({
    String? connectTitle,
    String? connectData,
    String? imagePath,
    Color? imageColor,
    required Color imageBgcolor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: InkWell(
        onTap: onTap,
        child: CommonWidget.container(
          borderColor: appConstants.default5Color,
          isBorder: true,
          borderRadius: appConstants.prductCardRadius,
          padding: EdgeInsets.all(12.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    connectTitle == null
                        ? const SizedBox.shrink()
                        : CommonWidget.commonText(
                            text: connectTitle,
                            style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                  color: appConstants.default4Color,
                                ),
                          ),
                    connectData == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: CommonWidget.commonText(
                              text: connectData,
                              style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                          ),
                  ],
                ),
              ),
              imagePath == null
                  ? const SizedBox.shrink()
                  : CircleAvatar(
                      radius: 25.r,
                      backgroundColor: imageBgcolor,
                      child: CommonWidget.imageBuilder(
                        imageUrl: imagePath,
                        height: 20.h,
                        color: imageColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
