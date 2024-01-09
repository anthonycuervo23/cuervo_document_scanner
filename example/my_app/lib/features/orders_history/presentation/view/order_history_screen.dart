// ignore_for_file: library_private_types_in_public_api, unrelated_type_equality_checks

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/orders_history/presentation/order_history_cubit/orders_history_cubit.dart';
import 'package:bakery_shop_flutter/features/orders_history/presentation/order_history_cubit/orders_history_state.dart';
import 'package:bakery_shop_flutter/features/orders_history/presentation/view/order_history_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends OrderHistoryWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      bloc: orderHistoryCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appConstants.greyBackgroundColor,
          appBar: customAppBar(
            context,
            onTap: () => CommonRouter.pop(),
            title: TranslationConstants.order_history.translate(context),
          ),
          body: Column(
            children: [
              orderhistorycategory(context: context),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      1 == 0
                          ? CommonWidget.sizedBox(
                              height: ScreenUtil().screenHeight,
                              child: CommonWidget.dataNotFound(
                                context: context,
                                actionButton: const SizedBox.shrink(),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().screenWidth * 0.05,
                                vertical: ScreenUtil().screenHeight * 0.02,
                              ),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: orderHistoryCubit.isSelected == 0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CommonWidget.commonText(
                                          text: TranslationConstants.new_order.translate(context),
                                          style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                                color: appConstants.default1Color,
                                                letterSpacing: 2.r,
                                                wordSpacing: 2.r,
                                              ),
                                        ),
                                        commonBox(
                                          clipColor: appConstants.profilePhone1Color,
                                          clipBoxColor: appConstants.profilePhone2Color,
                                          clipName: TranslationConstants.paid.translate(context),
                                          isVegitarian: true,
                                          poductPicture: "assets/photos/dummy/cake.png",
                                          price: 500,
                                          productName: 'Dutch Chocolate Truffle Cake',
                                          rating: 4.3,
                                          ratingPerson: 1780,
                                          isDotedLine: true,
                                          widget: commonPaidUnpaidActions(),
                                        ),
                                        commonBox(
                                          clipColor: appConstants.profileDob1Color,
                                          clipBoxColor: appConstants.profileDob2Color,
                                          clipName: TranslationConstants.unpaid.translate(context),
                                          isVegitarian: true,
                                          poductPicture: "assets/photos/dummy/cake.png",
                                          price: 500,
                                          productName: 'Dutch Chocolate Truffle Cake',
                                          rating: 4.3,
                                          ratingPerson: 1780,
                                          isDotedLine: true,
                                          widget: commonPaidUnpaidActions(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: orderHistoryCubit.isSelected == 1 || orderHistoryCubit.isSelected == 0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenUtil().screenHeight * 0.02,
                                          ),
                                          child: CommonWidget.commonText(
                                            text: TranslationConstants.recent_order.translate(context),
                                            style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                                  color: appConstants.default1Color,
                                                  letterSpacing: 2.r,
                                                  wordSpacing: 2.r,
                                                ),
                                          ),
                                        ),
                                        commonBox(
                                          clipColor: appConstants.profilePhone1Color,
                                          clipBoxColor: appConstants.profilePhone2Color,
                                          clipName: TranslationConstants.delivered.translate(context),
                                          isVegitarian: true,
                                          poductPicture: "assets/photos/dummy/cake.png",
                                          price: 500,
                                          productName: 'Dutch Chocolate Truffle Cake',
                                          rating: 4.3,
                                          ratingPerson: 1780,
                                          isDotedLine: true,
                                          widget: deliverdActions(
                                            onTap: () => CommonRouter.pushNamed(RouteList.feedback_screen),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: orderHistoryCubit.isSelected == 2 || orderHistoryCubit.isSelected == 0,
                                    child: commonBox(
                                      clipColor: appConstants.profileEmail1Color,
                                      clipBoxColor: appConstants.profileEmail2Color,
                                      clipName: TranslationConstants.cancelled.translate(context),
                                      isVegitarian: false,
                                      poductPicture: "assets/photos/dummy/cake.png",
                                      price: 500,
                                      productName: 'Dutch Chocolate Truffle Cake',
                                      rating: 4.3,
                                      ratingPerson: 1780,
                                      isDotedLine: false,
                                    ),
                                  ),
                                  Visibility(
                                    visible: orderHistoryCubit.isSelected == 3 || orderHistoryCubit.isSelected == 0,
                                    child: commonBox(
                                      clipBoxColor: appConstants.profileAnniversary2Color,
                                      clipColor: appConstants.profileAnniversary1Color,
                                      clipName: TranslationConstants.refund_order.translate(context),
                                      isVegitarian: true,
                                      poductPicture: "assets/photos/dummy/cake.png",
                                      price: 500,
                                      productName: 'Dutch Chocolate Truffle Cake',
                                      rating: 4.3,
                                      ratingPerson: 1780,
                                      isDotedLine: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
