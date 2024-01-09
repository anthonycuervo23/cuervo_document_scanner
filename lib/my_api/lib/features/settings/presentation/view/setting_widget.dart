import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/setting_cubit/setting_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/setting_screen.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_admin_flutter/global.dart';

abstract class SettingWidget extends State<SettingScreen> {
  late SettingCubit settingCubit;

  @override
  void initState() {
    settingCubit = getItInstance<SettingCubit>();

    super.initState();
  }

  @override
  void dispose() {
    settingCubit.loadingCubit.hide();
    settingCubit.close();
    super.dispose();
  }

  Widget settingListTile({
    required String svgPicturePath,
    required String text,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.r),
            child: CommonWidget.container(
              width: ScreenUtil().screenWidth,
              isMarginAllSide: false,
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.imageBuilder(
                    imageUrl: svgPicturePath,
                    height: 18.h,
                  ),
                  CommonWidget.sizedBox(width: 10),
                  Expanded(
                    child: CommonWidget.commonText(
                        text: text,
                        textAlign: TextAlign.start,
                        color: appConstants.lightGrey1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/common/right_arrow.svg",
                    color: appConstants.lightGrey3,
                    height: 12.h,
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(color: appConstants.dividerColor)
      ],
    );
  }
}
