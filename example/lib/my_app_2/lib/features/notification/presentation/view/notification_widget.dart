import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/notification/data/models/notification_model.dart';
import 'package:bakery_shop_flutter/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:bakery_shop_flutter/features/notification/presentation/view/notification_view.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class NotificationWidget extends State<NotificationView> {
  late NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();
    notificationCubit = getItInstance<NotificationCubit>();
    notificationCubit.loadData();
  }

  @override
  void dispose() {
    notificationCubit.loadingCubit.hide();
    notificationCubit.close();
    super.dispose();
  }

  Widget commonNotificationBox({
    required int index,
    required NotificationLoadedState state,
    required NotificationModel notificationModel,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: notificationModel.isOpenBox
          ? showNotificationData(index: index, notificationModel: notificationModel, state: state)
          : hideNotificationData(notificationModel: notificationModel, index: index, state: state),
    );
  }

  Widget hideNotificationData({
    required int index,
    required NotificationModel notificationModel,
    required NotificationLoadedState state,
  }) {
    return CommonWidget.container(
      color: appConstants.whiteBackgroundColor,
      width: ScreenUtil().screenWidth,
      borderRadius: appConstants.prductCardRadius,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 10.h,
      ),
      child: Row(
        children: [
          CommonWidget.imageBuilder(
            imageUrl: notificationModel.image,
            fit: BoxFit.cover,
            width: 80.w,
            height: 90.h,
            borderRadius: appConstants.prductCardRadius,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CommonWidget.commonText(
                              text: notificationModel.offerTitle,
                              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                          ),
                          Visibility(
                            visible: notificationModel.hasNavigationLink,
                            child: InkWell(
                              onTap: () => notificationCubit.changeStateOfBox(index: index, state: state),
                              child: Container(
                                height: 25.h,
                                width: 25.w,
                                alignment: Alignment.center,
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/svg/common/bottom_arrow.svg",
                                  height: 8.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CommonWidget.commonText(
                        text: notificationModel.offerDetail,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                              color: appConstants.default4Color,
                            ),
                      ),
                    ],
                  ),
                  CommonWidget.sizedBox(height: 20),
                  Row(
                    children: [
                      CommonWidget.commonText(
                        text: DateFormat.yMd().format(DateTime.now()),
                        style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                              color: appConstants.default4Color,
                            ),
                      ),
                      CommonWidget.sizedBox(
                        height: 15,
                        child: VerticalDivider(
                          color: appConstants.default4Color,
                          thickness: 0.8,
                        ),
                      ),
                      CommonWidget.commonText(
                        text: DateFormat('hh:mm:ss a').format(DateTime.now()),
                        style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                              color: appConstants.default4Color,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showNotificationData({
    required int index,
    required NotificationModel notificationModel,
    required NotificationLoadedState state,
  }) {
    return Visibility(
      visible: notificationModel.isOpenBox,
      child: CommonWidget.container(
        width: ScreenUtil().screenWidth,
        color: appConstants.whiteBackgroundColor,
        borderRadius: appConstants.prductCardRadius,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidget.commonText(
                  text: notificationModel.offerTitle,
                  style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                        color: appConstants.default1Color,
                      ),
                ),
                InkWell(
                  onTap: () => notificationCubit.changeStateOfBox(index: index, state: state),
                  child: Container(
                    height: 25.h,
                    width: 25.w,
                    alignment: Alignment.center,
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/common/up_arrow.svg",
                      height: 8.h,
                    ),
                  ),
                ),
              ],
            ),
            CommonWidget.commonText(
              text: notificationModel.offerDetail,
              style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                    color: appConstants.default1Color,
                  ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: CommonWidget.imageBuilder(
                imageUrl: notificationModel.image,
                fit: BoxFit.cover,
                width: ScreenUtil().screenWidth,
                height: 150.h,
                borderRadius: 7.r,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonWidget.textButton(
                    text: notificationModel.offerLink,
                    textStyle: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                          color: appConstants.primary1Color,
                        ),
                    onTap: () {},
                  ),
                ),
                Row(
                  children: [
                    CommonWidget.commonText(
                      text: DateFormat.yMd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                            color: appConstants.default4Color,
                          ),
                    ),
                    CommonWidget.sizedBox(
                      height: 15,
                      child: VerticalDivider(
                        color: appConstants.default4Color,
                        width: 8.w,
                      ),
                    ),
                    CommonWidget.commonText(
                      text: DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                            color: appConstants.default4Color,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
