import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/pages/customer_all_details/routine_order_details_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoutineOrderDetailsScreen extends StatefulWidget {
  const RoutineOrderDetailsScreen({super.key});

  @override
  State<RoutineOrderDetailsScreen> createState() => _RoutineOrderDetailsScreenState();
}

class _RoutineOrderDetailsScreenState extends RoutineOrderDetailsWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.backGroundColor,
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 14.h),
        child: Container(
          color: appConstants.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customerDetail(),
                        amountDateBalance(),
                      ],
                    ),
                    CommonWidget.sizedBox(height: 14),
                    totalPayPendiongAmount(),
                    CommonWidget.sizedBox(height: 30),
                    CommonWidget.commonText(
                      text: TranslationConstants.routine_order_list.translate(context),
                      fontSize: 15,
                      bold: true,
                    ),
                  ],
                ),
              ),
              Divider(color: appConstants.shadowColor1, height: 5.h),
              CommonWidget.sizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                child: CommonWidget.commonText(
                  text: 'Brown Breads',
                  fontSize: 12,
                  bold: true,
                ),
              ),
              attributeQuantityAndRate(),
              titleBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return commonListView(index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
