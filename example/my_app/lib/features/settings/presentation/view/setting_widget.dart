import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/app_language/app_language_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/order_time_slot/order_time_slot_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/reminder_date/reminder_date_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/setting_cubit/setting_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/view/setting_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bakery_shop_flutter/global.dart';

abstract class SettingWidget extends State<SettingScreen> {
  late SettingCubit settingCubit;
  late OrderTimeSlotCubit orderTimeSlotCubit;
  late ReminderDateCubit reminderDateCubit;

  @override
  void initState() {
    settingCubit = getItInstance<SettingCubit>();
    orderTimeSlotCubit = getItInstance<OrderTimeSlotCubit>();
    reminderDateCubit = getItInstance<ReminderDateCubit>();
    super.initState();
  }

  @override
  void dispose() {
    settingCubit.close();
    orderTimeSlotCubit.close();
    reminderDateCubit.close();
    super.dispose();
  }

  Widget settingListTile({
    required String svgPicturePath,
    required String text,
    Widget? trailing,
    VoidCallback? onTap,
    bool? nextArrow,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return CommonWidget.container(
      color: appConstants.whiteBackgroundColor,
      borderRadius: 8.r,
      width: ScreenUtil().screenWidth,
      isMarginAllSide: false,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: ListTile(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        contentPadding: contentPadding ?? EdgeInsets.only(left: 15.w, right: 10.w),
        leading: SvgPicture.asset(svgPicturePath, height: 20.r),
        title: CommonWidget.commonText(
          text: text,
          style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
        ),
        trailing: nextArrow == true
            ? Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/common/right_arrow.svg",
                  height: 12.r,
                  color: appConstants.default1Color,
                ),
              )
            : trailing,
        onTap: onTap,
      ),
    );
  }

  void orderTimeSlotDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierColor: appConstants.default2Color,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          surfaceTintColor: appConstants.whiteBackgroundColor,
          backgroundColor: appConstants.whiteBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
          insetPadding: EdgeInsets.symmetric(horizontal: 18.w),
          titlePadding: const EdgeInsets.all(0),
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.commonText(
                      text: "Today",
                      style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
                    ),
                    IconButton(
                      onPressed: () => CommonRouter.pop(),
                      icon: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/common/close_icon.svg",
                        height: 22.r,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 0.6, height: 5.h),
              BlocBuilder<OrderTimeSlotCubit, OrderTimeSlotState>(
                bloc: orderTimeSlotCubit,
                builder: (context, state) {
                  if (state is OrderTimeSlotLoadedState) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: CommonWidget.sizedBox(
                        height: 470,
                        width: ScreenUtil().screenWidth,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                child: ListView.builder(
                                  itemCount: orderTimeSlotList.length - 6,
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return timeSlotRowOfOrder(
                                      index: index,
                                      orderTimeSlot: orderTimeSlotList[index],
                                      selectedIndex: state.selectedIndex,
                                      onTap: () {
                                        orderTimeSlotCubit.changeTimeSlot(
                                          index: index,
                                          orderTimeSlot: orderTimeSlotList[index],
                                        );
                                        CommonRouter.pop();
                                      },
                                    );
                                  },
                                ),
                              ),
                              CommonWidget.container(
                                width: ScreenUtil().screenWidth,
                                color: appConstants.greyBackgroundColor,
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                child: CommonWidget.commonText(
                                  text: "Tomorrow",
                                  style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                        color: appConstants.default1Color,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                child: ListView.builder(
                                  itemCount: orderTimeSlotList.length - 6,
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return timeSlotRowOfOrder(
                                      index: index + 6,
                                      orderTimeSlot: orderTimeSlotList[index + 6],
                                      selectedIndex: state.selectedIndex,
                                      onTap: () {
                                        orderTimeSlotCubit.changeTimeSlot(
                                          index: index + 6,
                                          orderTimeSlot: orderTimeSlotList[index + 6],
                                        );
                                        CommonRouter.pop();
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is AppLanguageLoadingState) {
                    return CommonWidget.loadingIos();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget timeSlotRowOfOrder({
    required int index,
    required int selectedIndex,
    required String orderTimeSlot,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/common/timer_clock.svg",
                  height: 18.r,
                  fit: BoxFit.contain,
                  color: selectedIndex == index ? appConstants.primary1Color : appConstants.default4Color,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Row(
                    children: [
                      CommonWidget.commonText(
                        text: orderTimeSlot,
                        style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                              color: selectedIndex == index ? appConstants.primary1Color : appConstants.default1Color,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: selectedIndex == index,
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/round_sclected_arrow.svg",
              height: 18.r,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  List<String> orderTimeSlotList = [
    "08:00 AM - 09:00 AM",
    "10:00 AM - 01:00 PM",
    "12:00 PM - 03:00 PM",
    "01:00 PM - 05:00 PM",
    "04:00 PM - 07:00 PM",
    "06:00 PM - 09:00 PM",
    "08:00 AM - 09:00 AM",
    "10:00 AM - 01:00 PM",
    "12:00 PM - 03:00 PM",
    "01:00 PM - 05:00 PM",
    "04:00 PM - 07:00 PM",
    "06:00 PM - 09:00 PM",
  ];
}
