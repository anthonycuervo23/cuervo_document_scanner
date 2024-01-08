import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/setting_widget.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends SettingWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.my_business.translate(context),
                bold: true,
                fontSize: 14.sp,
              ),
              SizedBox(height: 10.h),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/customer_type.svg",
                text: TranslationConstants.customer_type.translate(context),
                onTap: () {},
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/product_type.svg",
                text: TranslationConstants.product_type.translate(context),
                onTap: () {},
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/product_listing_status.svg",
                text: TranslationConstants.product_listing_status.translate(context),
                onTap: () {},
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/expense_category_list.svg",
                text: TranslationConstants.expense_category_list_create.translate(context),
                onTap: () {},
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/delivery_time_slot.svg",
                text: TranslationConstants.delivery_time_slot.translate(context),
                onTap: () => CommonRouter.pushNamed(RouteList.delivery_time_slot_screen),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/family_detail.svg",
                text: TranslationConstants.family_details_table_list.translate(context),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.r),
                child: CommonWidget.commonText(
                    text: TranslationConstants.others.translate(context), bold: true, fontSize: 14.sp),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/change_password.svg",
                text: TranslationConstants.change_password.translate(context),
                onTap: () => CommonRouter.pushNamed(RouteList.change_paswword_screen),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/bill_copy_format.svg",
                text: TranslationConstants.bill_copy_format_customer.translate(context),
                onTap: () {},
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/product_wise_point.svg",
                text: TranslationConstants.product_wise_point.translate(context),
                onTap: () {},
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/refer_point.svg",
                text: TranslationConstants.refer_point.translate(context),
                onTap: () => CommonRouter.pushNamed(RouteList.refer_point_screen),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/delivery_area.svg",
                text: TranslationConstants.delivery_area_with_pin_code.translate(context),
                onTap: () => CommonRouter.pushNamed(RouteList.area_with_pincode_screen),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/point_wise_color_button.svg",
                text: TranslationConstants.point_wise_color_button.translate(context),
                onTap: () => CommonRouter.pushNamed(RouteList.point_wise_color_btn_screen),
              ),
              settingListTile(
                svgPicturePath: "assets/photos/svg/settings_screen/term_and_condition.svg",
                text: TranslationConstants.terms_and_conditions.translate(context),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
