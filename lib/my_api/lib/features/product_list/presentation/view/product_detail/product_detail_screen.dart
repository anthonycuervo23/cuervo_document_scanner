import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/data/models/product_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/product_detail/product_detail_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductListModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ProductDetailWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          context,
          onTap: () => CommonRouter.pop(),
          title: "Item ${widget.productModel.hashtagCount}",
          titleCenter: false,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  CommonRouter.pushNamed(RouteList.add_product_screen);
                },
                child: CommonWidget.commonText(
                  text: TranslationConstants.edit.translate(context),
                  style: TextStyle(color: appConstants.editbuttonColor, fontSize: 15.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: GestureDetector(
                  onTap: () {
                    showAlertDialog(
                      noButtonColor: appConstants.theme7Color,
                      context: context,
                      isTitle: true,
                      titleText: TranslationConstants.confirm_delete.translate(context),
                      text: TranslationConstants.sure_delete_item.translate(context),
                      titleTextStyle: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                            color: appConstants.themeColor,
                          ),
                      contentTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                            color: appConstants.textColor,
                          ),
                      width: 200.w,
                      maxLine: 2,
                      onNoTap: () {
                        CommonRouter.pop();
                      },
                      onTap: () {
                        CommonRouter.pop();
                      },
                    );
                  },
                  child: CommonWidget.commonText(
                    text: TranslationConstants.delete.translate(context),
                    style: TextStyle(color: appConstants.deletebuttonColor, fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            productDetails(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                height: 0.5,
                thickness: 0.5,
                color: appConstants.dividerColor,
              ),
            ),
            productDiscription(),
          ],
        ),
      ),
    );
  }
}
