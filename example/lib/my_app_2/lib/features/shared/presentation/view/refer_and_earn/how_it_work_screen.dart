import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/refer_and_earn/how_it_work_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';

class HowItWorkScreen extends StatefulWidget {
  const HowItWorkScreen({super.key});

  @override
  State<HowItWorkScreen> createState() => _HowItWorkScreenState();
}

class _HowItWorkScreenState extends HowItWorkWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.how_it_work.translate(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            inviteFriendLorem(),
            howItWorkLoremText(),
          ],
        ),
      ),
    );
  }
}
