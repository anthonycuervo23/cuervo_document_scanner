import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/reward_coupon_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class RewardCouponScreen extends StatefulWidget {
  const RewardCouponScreen({super.key});

  @override
  State<RewardCouponScreen> createState() => _RewardCouponScreenState();
}

class _RewardCouponScreenState extends RewardCouponWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.reward.translate(context),
      ),
      body: 1 == 1
          ? couponReward(
              ontap: () {
                CommonRouter.pushNamed(RouteList.reward_coupon_details_screen);
              },
            )
          : CommonWidget.dataNotFound(context: context, actionButton: const SizedBox.shrink()),
    );
  }
}
