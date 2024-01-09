// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/orders_history/presentation/order_history_cubit/orders_history_cubit.dart';
import 'package:bakery_shop_flutter/features/orders_history/presentation/view/order_history_screen.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/global.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class OrderHistoryWidget extends State<OrderHistoryScreen> {
  late OrderHistoryCubit orderHistoryCubit;

  @override
  void initState() {
    super.initState();
    orderHistoryCubit = getItInstance<OrderHistoryCubit>();
    orderHistoryCubit.selectedTapOrderHistory(0);
  }

  @override
  void deactivate() {
    super.deactivate();
    orderHistoryCubit.close();
  }

  Widget deliverdActions({required void Function()? onTap}) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonWidget.textButton(
              text: TranslationConstants.give_your_feedback.translate(context),
              textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.primary1Color),
              onTap: onTap),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/right_arrow.svg",
              height: 14.sp,
              color: appConstants.primary1Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget commonPaidUnpaidActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidget.commonButton(
          color: appConstants.secondary2Color,
          padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 32.w),
          text: TranslationConstants.cancel_order.translate(context),
          alignment: Alignment.center,
          style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.primary1Color),
          onTap: () async {
            var data = await CommonWidget.showAlertDialog(
              context: context,
              isTitle: true,
              titleText: TranslationConstants.cancel_order.translate(context),
              text: TranslationConstants.sure_cancel_order.translate(context),
              textColor: appConstants.default4Color,
            );
            if (data) {}
          },
          context: context,
        ),
        CommonWidget.sizedBox(width: 10),
        CommonWidget.commonButton(
          padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 32.w),
          text: TranslationConstants.order_status.translate(context),
          alignment: Alignment.center,
          style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.buttonTextColor),
          onTap: () => CommonRouter.pushNamed(RouteList.order_status_screen),
          context: context,
        ),
      ],
    );
  }

  Widget commonButton({
    required OrderHistoryCubit orderHistoryCubit,
    required String buttonText,
    required VoidCallback onTap,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        color: orderHistoryCubit.isSelected == index ? appConstants.primary1Color : appConstants.whiteBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: const BorderSide(color: Colors.transparent),
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        minWidth: ScreenUtil().screenWidth * 0.15,
        elevation: 0,
        onPressed: onTap,
        child: CommonWidget.commonText(
          style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                color:
                    orderHistoryCubit.isSelected == index ? appConstants.buttonTextColor : appConstants.default3Color,
              ),
          text: buttonText,
        ),
      ),
    );
  }

  Widget commonBox({
    required String poductPicture,
    required bool isVegitarian,
    required double rating,
    required int ratingPerson,
    required String productName,
    required double price,
    required String clipName,
    required Color clipColor,
    required Color clipBoxColor,
    bool isDotedLine = false,
    Widget? widget,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: CommonWidget.container(
        color: appConstants.whiteBackgroundColor,
        borderRadius: 14.r,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: CommonWidget.imageBuilder(
                      imageUrl: poductPicture,
                      height: ScreenUtil().screenHeight * 0.10,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CommonWidget.imageBuilder(
                                imageUrl: isVegitarian == true
                                    ? "assets/photos/svg/common/vegetarian_icon.svg"
                                    : "assets/photos/svg/common/nonVegetarian_icon.svg",
                                height: 12.r,
                              ),
                              InkWell(
                                onTap: () => CommonRouter.pushNamed(RouteList.review_and_feedback_screen),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                                      child: CommonWidget.imageButton(
                                        svgPicturePath: "assets/photos/svg/common/star_icon.svg",
                                        iconSize: 12.r,
                                      ),
                                    ),
                                    CommonWidget.commonText(
                                      text: "$rating",
                                      style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                                            color: appConstants.starRateColor,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: CommonWidget.commonText(
                                        text: "($ratingPerson)",
                                        style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                                              color: appConstants.default3Color,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 20.h,
                            ),
                            child: CommonWidget.commonText(
                                text: productName,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                      color: appConstants.default1Color,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 9.h),
                            child: CommonWidget.sizedBox(
                              height: ScreenUtil().screenHeight * 0.038,
                              child: Row(
                                children: [
                                  CommonWidget.commonText(
                                    text: "₹ ${price.toStringAsFixed(0)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyBoldHeading
                                        .copyWith(color: appConstants.primary1Color),
                                  ),
                                  VerticalDivider(
                                    color: appConstants.default7Color,
                                    endIndent: 3.h,
                                    indent: 3.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: clipBoxColor,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 6.h),
                                    child: CommonWidget.commonText(
                                      text: clipName,
                                      style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                                            color: clipColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isDotedLine,
              child: Padding(
                padding: EdgeInsets.only(top: 13.h),
                child: CommonWidget.commonDashLine(fontSize: 18.sp),
              ),
            ),
            CommonWidget.sizedBox(height: 10),
            widget ?? SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget orderhistorycategory({required BuildContext context}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Row(
          children: [
            commonButton(
              orderHistoryCubit: orderHistoryCubit,
              buttonText: TranslationConstants.all.translate(context),
              index: 0,
              onTap: () => orderHistoryCubit.selectedTapOrderHistory(0),
            ),
            commonButton(
                orderHistoryCubit: orderHistoryCubit,
                buttonText: TranslationConstants.delivered.translate(context),
                index: 1,
                onTap: () => orderHistoryCubit.selectedTapOrderHistory(1)),
            commonButton(
              orderHistoryCubit: orderHistoryCubit,
              buttonText: TranslationConstants.cancelled.translate(context),
              index: 2,
              onTap: () => orderHistoryCubit.selectedTapOrderHistory(2),
            ),
            commonButton(
              orderHistoryCubit: orderHistoryCubit,
              buttonText: TranslationConstants.refunded.translate(context),
              index: 3,
              onTap: () => orderHistoryCubit.selectedTapOrderHistory(3),
            ),
          ],
        ),
      ),
    );
  }
}
