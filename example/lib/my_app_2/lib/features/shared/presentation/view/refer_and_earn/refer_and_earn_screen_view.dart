import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/refer_and_earn/refer_and_earn_widget.dart';
import 'package:flutter/material.dart';
import 'package:bakery_shop_flutter/global.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends ReferAndEarnWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        appBarColor: Colors.transparent,
        iconColor: appConstants.buttonTextColor,
        title: TranslationConstants.refer_earn.translate(context),
        textColor: appConstants.buttonTextColor,
      ),
      body: screenView(context: context),
    );
  }
}
