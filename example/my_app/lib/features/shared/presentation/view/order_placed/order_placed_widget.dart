import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/order_placed/order_placed_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class OrderPlacedWidget extends State<OrderPlacedScreen> {
  Widget orderPlacedContainer() {
    return CommonWidget.container(
      height: 90.h,
      width: 250.w,
      borderRadius: appConstants.prductCardRadius,
      isBorder: true,
      color: appConstants.whiteBackgroundColor,
      borderColor: appConstants.default7Color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          orderIdDetail(),
          orderAmountDetial(),
        ],
      ),
    );
  }

  Widget orderIdDetail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.order_ID.translate(context),
            style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                  color: appConstants.default1Color,
                ),
          ),
          const Spacer(),
          CommonWidget.commonText(
            text: "mnhyt00125",
            style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                  color: appConstants.default4Color,
                ),
          ),
        ],
      ),
    );
  }

  Widget orderAmountDetial() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.order_amount.translate(context),
            style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                  color: appConstants.default1Color,
                ),
          ),
          const Spacer(),
          CommonWidget.commonText(
            text: "₹815",
            style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                  color: appConstants.default4Color,
                ),
          ),
        ],
      ),
    );
  }

  Widget continusTextButton() {
    return CommonWidget.textButton(
      text: TranslationConstants.continue_shopping.translate(context),
      textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
            color: appConstants.primary1Color,
          ),
      onTap: () {
        CommonRouter.popUntil(RouteList.app_home);
        BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(1);
      },
    );
  }

  Widget orderPlacedImage() {
    return CommonWidget.imageBuilder(
      imageUrl: "assets/photos/svg/order_placed_screen/order_placed.svg",
      height: 186.09.h,
      width: 197.55.w,
    );
  }
}
