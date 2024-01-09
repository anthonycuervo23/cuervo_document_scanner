import 'package:bakery_shop_admin_flutter/features/return_order/presentation/pages/return_order_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReturnOrderScreen extends StatefulWidget {
  const ReturnOrderScreen({super.key});

  @override
  State<ReturnOrderScreen> createState() => _ReturnOrderScreenState();
}

class _ReturnOrderScreenState extends ReturnOrderWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appConstants.backGroundColor,
        appBar: appBar(),
        body: Column(
          children: [
            CommonWidget.sizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: textField(
                width: ScreenUtil().screenWidth,
                context: context,
                isSufix: true,
                onTap: () {},
                controller: TextEditingController(),
                onChanged: (p0) {},
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                primary: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return commonOrderBox(index: index);
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }
}
