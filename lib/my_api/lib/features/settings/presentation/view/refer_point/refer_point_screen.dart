import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/refer_point/refer_point_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReferPointScreen extends StatefulWidget {
  const ReferPointScreen({super.key});

  @override
  State<ReferPointScreen> createState() => _ReferPointScreenState();
}

class _ReferPointScreenState extends ReferPointWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          children: [
            commonTextField(
              titleText: TranslationConstants.welcome_point.translate(context),
              hintText: TranslationConstants.enter_welcome_point.translate(context),
            ),
            CommonWidget.sizedBox(height: 10),
            commonTextField(
              titleText: TranslationConstants.new_reward_point.translate(context),
              hintText: TranslationConstants.enter_reward_point.translate(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: submitButton(),
    );
  }
}
