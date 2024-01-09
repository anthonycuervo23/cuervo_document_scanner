import 'package:bakery_shop_admin_flutter/features/profit_loss_sheet/presentation/pages/profit_loss_sheet_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class ProfitLossSheetScreen extends StatefulWidget {
  const ProfitLossSheetScreen({super.key});

  @override
  State<ProfitLossSheetScreen> createState() => _ProfitLossSheetScreenState();
}

class _ProfitLossSheetScreenState extends ProfitLossSheetWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(context),
        body: Center(child: CommonWidget.commonText(text: "Purchase List Screen")),
      ),
    );
  }
}
