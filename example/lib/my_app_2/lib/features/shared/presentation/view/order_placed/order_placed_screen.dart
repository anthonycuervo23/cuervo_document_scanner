import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/order_placed/order_placed_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends OrderPlacedWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.order_placed.translate(context),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: screenView()),
          CommonWidget.commonDashLine(color: appConstants.default7Color),
          CommonWidget.sizedBox(height: 35),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CommonWidget.commonButton(
              alignment: Alignment.center,
              text: TranslationConstants.go_to_order_status.translate(context),
              context: context,
              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.buttonTextColor),
              height: 51.01.h,
              onTap: () => CommonRouter.pushNamed(RouteList.order_status_screen),
            ),
          ),
          CommonWidget.sizedBox(height: 23),
          continusTextButton(),
          CommonWidget.sizedBox(height: 28),
        ],
      ),
    );
  }

  Widget screenView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        orderPlacedImage(),
        CommonWidget.sizedBox(height: 10),
        CommonWidget.commonText(
          text: TranslationConstants.order_placed.translate(context),
          style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                color: appConstants.default1Color,
              ),
        ),
        CommonWidget.commonText(
          text: TranslationConstants.successfully.translate(context),
          style: Theme.of(context).textTheme.subTitle1MediumHeading.copyWith(
                color: appConstants.green1Color,
              ),
        ),
        CommonWidget.sizedBox(height: 30),
        orderPlacedContainer(),
      ],
    );
  }
}
