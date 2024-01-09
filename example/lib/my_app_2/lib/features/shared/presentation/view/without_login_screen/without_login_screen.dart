import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class WithoutLoginScreen extends StatefulWidget {
  final bool isApplyAppbar;
  const WithoutLoginScreen({super.key, required this.isApplyAppbar});

  @override
  State<WithoutLoginScreen> createState() => _WithoutLoginScreenState();
}

class _WithoutLoginScreenState extends State<WithoutLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isApplyAppbar ? customAppBar(context, onTap: () => CommonRouter.pop()) : null,
      body: CommonWidget.dataNotFound(
        context: context,
        buttonLabel: TranslationConstants.login.translate(context),
        onTap: () => CommonRouter.pushReplacementNamed(RouteList.login_screen),
      ),
    );
  }
}
