import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/reward_coupon_details_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class RewardCouponDetailsScreen extends StatefulWidget {
  const RewardCouponDetailsScreen({super.key});

  @override
  State<RewardCouponDetailsScreen> createState() => _RewardCouponDetailsScreenState();
}

class _RewardCouponDetailsScreenState extends RewardCouponDetailsWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.reward.translate(context),
      ),
      body: Column(
        children: [
          CommonWidget.sizedBox(height: 15),
          couponContainer(),
          CommonWidget.sizedBox(height: 10),
          couponDetailsWidget(),
        ],
      ),
    );
  }
}
