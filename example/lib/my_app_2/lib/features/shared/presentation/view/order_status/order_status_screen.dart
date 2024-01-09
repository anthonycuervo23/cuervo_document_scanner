// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/order_status/order_status_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends OrderStatusWidget {
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        title: TranslationConstants.order_status.translate(context),
        onTap: () => CommonRouter.pop(),
      ),
      body: 1 == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/once_used_picture/no_order_basket.svg",
                    height: 170.h,
                  ),
                  CommonWidget.sizedBox(height: 10),
                  CommonWidget.commonText(
                    text: TranslationConstants.your_basket_feels_lights.translate(context),
                    style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.sizedBox(height: 5),
                  CommonWidget.commonText(
                    text: TranslationConstants.you_have_not_ordered_yet.translate(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default4Color,
                        ),
                  ),
                  CommonWidget.sizedBox(height: 40),
                  CommonWidget.commonButton(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 60.w),
                    text: TranslationConstants.new_order_camel.translate(context),
                    style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.buttonTextColor),
                    context: context,
                    onTap: () => CommonRouter.pop(),
                  ),
                  CommonWidget.sizedBox(height: 100),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        orderCopyId(context: context),
                        orderTimelineWidget(context: context),
                        Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/svg/order_status_screen/order_location.svg",
                                  height: 24.h,
                                  width: 24.h,
                                ),
                              ),
                              CommonWidget.sizedBox(width: 15),
                              CommonWidget.commonText(
                                text: "1234, Swastik Mall, Above -Dairy Don,\nYogi Chowk,Puna Gam Surat-395010.",
                                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                      color: appConstants.default1Color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.imageBuilder(
                                imageUrl: "assets/photos/svg/order_status_screen/order_estimated_time.svg",
                                height: 20.h,
                                width: 20.h,
                              ),
                              CommonWidget.sizedBox(width: 15),
                              CommonWidget.commonText(
                                text: "30 - 40 min estimated delivery time",
                                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                      color: appConstants.default1Color,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                  child: CommonWidget.commonDashLine(
                    color: appConstants.default7Color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.h,
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/png/review_and_feedback_screen/picture.png",
                                ),
                              ),
                              Visibility(
                                visible: isOnline,
                                child: Positioned(
                                  right: 0.w,
                                  bottom: 6.h,
                                  child: Container(
                                    height: 14.h,
                                    width: 14.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: appConstants.oStatus1Color,
                                      border: Border.all(color: appConstants.whiteBackgroundColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CommonWidget.sizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.commonText(
                                text: "Mihir Soni",
                                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                      color: appConstants.default1Color,
                                    ),
                              ),
                              CommonWidget.commonText(
                                text: "Food Courier",
                                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                      color: appConstants.default4Color,
                                    ),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              Uri phoneno = Uri.parse('tel:+91 9876543210');
                              await launchUrl(phoneno);
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: appConstants.oStatus1Color,
                              ),
                              child: Center(
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/svg/order_status_screen/person_call.svg",
                                  height: 20.h,
                                  color: appConstants.whiteBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CommonWidget.sizedBox(height: 20),
                      Row(
                        children: [
                          CommonWidget.container(
                            height: 50.h,
                            width: 50.h,
                            borderRadius: 15.r,
                            color: appConstants.greyBackgroundColor,
                            child: Center(
                              child: CommonWidget.imageButton(
                                svgPicturePath: "assets/photos/svg/bottom_navigation_bar/home_icon.svg",
                                iconSize: 25.h,
                                color: appConstants.default1Color,
                                onTap: () {
                                  CommonRouter.popUntil(RouteList.app_home);
                                  BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
                                },
                              ),
                            ),
                          ),
                          CommonWidget.sizedBox(width: 15),
                          Expanded(
                            child: CommonWidget.commonButton(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              text: TranslationConstants.order_history.translate(context),
                              context: context,
                              alignment: Alignment.center,
                              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                    color: appConstants.buttonTextColor,
                                  ),
                              onTap: () => CommonRouter.pushNamed(RouteList.order_history_screen),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
