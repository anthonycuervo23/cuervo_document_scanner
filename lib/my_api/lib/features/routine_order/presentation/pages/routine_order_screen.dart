import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/pages/routine_order_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RotineOrderScreen extends StatefulWidget {
  const RotineOrderScreen({super.key});

  @override
  State<RotineOrderScreen> createState() => _RotineOrderScreenState();
}

class _RotineOrderScreenState extends RoutinOrderWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.backGroundColor,
      appBar: appBar(),
      body: Column(
        children: [
          searchFieldAndFilter(),
          CommonWidget.sizedBox(height: 5.h),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => commonBox(index: index),
            ),
          ),
        ],
      ),
    );
  }
}
