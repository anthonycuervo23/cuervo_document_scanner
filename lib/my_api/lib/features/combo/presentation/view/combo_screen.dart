import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/view/combo_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:flutter/material.dart';

class ComboScreen extends StatefulWidget {
  const ComboScreen({super.key});

  @override
  State<ComboScreen> createState() => _ComboScreenState();
}

class _ComboScreenState extends ComboWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.backGroundColor,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        context,
        title: TranslationConstants.combo_list.translate(context),
        titleCenter: false,
        onTap: () => CommonRouter.pushReplacementNamed(RouteList.app_home),
      ),
      body: screenView(context),
    );
  }
}
