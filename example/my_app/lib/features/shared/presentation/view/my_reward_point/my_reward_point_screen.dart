import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/my_reward_point_widget.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRewardPointScreen extends StatefulWidget {
  const MyRewardPointScreen({super.key});

  @override
  State<MyRewardPointScreen> createState() => _MyRewardPointScreenState();
}

class _MyRewardPointScreenState extends MyRewardPointWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.my_reward_point.translate(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTotalPointContainer(),
              CommonWidget.sizedBox(height: 15),
              TabBar(
                overlayColor: MaterialStateProperty.all<Color>(appConstants.whiteBackgroundColor),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                  borderRadius: BorderRadius.circular(5.8.r),
                  borderSide: BorderSide(width: 2.8.w, color: appConstants.primary1Color),
                ),
                tabs: [
                  commonTabbar(
                    titalText: TranslationConstants.total_earining.translate(context),
                    text: "100",
                  ),
                  commonTabbar(
                    titalText: TranslationConstants.redeem.translate(context),
                    text: "50",
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    0 == 1
                        ? CommonWidget.dataNotFound(context: context, actionButton: const SizedBox.shrink())
                        : ListView.builder(
                            primary: false,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return transactionDetailBox(
                                allColor: appConstants.oStatus1Color,
                                name: TranslationConstants.welcome_points.translate(context),
                                borderColor: appConstants.green2Color,
                              );
                            },
                          ),
                    0 == 1
                        ? CommonWidget.dataNotFound(context: context, actionButton: const SizedBox.shrink())
                        : ListView.builder(
                            primary: false,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return transactionDetailBox(
                                couponIndex: index,
                                allColor: appConstants.nonVegColor,
                                name: TranslationConstants.transfer.translate(context),
                                borderColor: appConstants.default7Color,
                              );
                            },
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
