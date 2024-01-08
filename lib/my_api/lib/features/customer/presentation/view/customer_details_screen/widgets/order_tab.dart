import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_view_cubit/customer_view_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget orderTab({required CustomerViewLoadedState state, required CustomerViewCubit customerViewCubit, required}) {
  return ListView.builder(
    itemCount: state.orderproductData.length,
    itemBuilder: (context, index) {
      return CommonWidget.container(
        margin: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
        borderRadius: 10.r,
        color: appConstants.white,
        shadow: [
          BoxShadow(color: appConstants.black12, blurRadius: 1, offset: Offset(0, 2.h)),
        ],
        padding: EdgeInsets.all(10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 145.w),
                      child: CommonWidget.commonText(
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text: state.orderproductData[index].productName,
                        style: Theme.of(context).textTheme.body2MediumHeading.copyWith(color: appConstants.textColor),
                      ),
                    ),
                    CommonWidget.commonText(
                      textOverflow: TextOverflow.clip,
                      text:
                          " (${state.orderproductData[index].quantity} ${state.orderproductData[index].quantityType})",
                      style: Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.textColor),
                    ),
                  ],
                ),
                CommonWidget.sizedBox(height: 5),
                CommonWidget.commonText(
                  text: state.orderproductData[index].orderDataTime,
                  style: Theme.of(context).textTheme.caption2LightHeading.copyWith(color: appConstants.black38),
                ),
                CommonWidget.sizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonWidget.commonText(
                      text: state.orderproductData[index].price.formatCurrency(),
                      style: Theme.of(context).textTheme.body1BoldHeading.copyWith(color: appConstants.themeColor),
                    ),
                    CommonWidget.sizedBox(width: 10),
                    CommonWidget.imageBuilder(imageUrl: 'assets/photos/svg/common/down_arrow.svg', height: 17.h),
                    CommonWidget.sizedBox(width: 10),
                    CommonWidget.container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                      color: appConstants.red.withOpacity(0.10),
                      borderRadius: 50.r,
                      child: CommonWidget.commonText(
                        text: TranslationConstants.pending.translate(context),
                        style: Theme.of(context).textTheme.overLine1MediumHeading.copyWith(color: appConstants.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonWidget.svgIconButton(
                    svgPicturePath: 'assets/photos/svg/common/bin.svg',
                    iconSize: 20.h,
                    onTap: () {
                      CommonWidget.showAlertDialog(
                          context: context,
                          onTap: () {
                            customerViewCubit.removeOrder(index: index);
                            CommonRouter.pop();
                          },
                          titleText: TranslationConstants.confirm_delete.translate(context),
                          isTitle: true,
                          text: TranslationConstants.sure_delete_order.translate(context),
                          maxLines: 2,
                          leftColor: appConstants.theme1Color,
                          leftTextColor: appConstants.white,
                          titleTextStyle: TextStyle(color: appConstants.theme1Color, fontWeight: FontWeight.bold));
                    },
                  ),
                  CommonWidget.sizedBox(height: 15),
                  CommonWidget.commonButton(
                    text: TranslationConstants.repeat_order.translate(context),
                    style:
                        Theme.of(context).textTheme.caption2BoldHeading.copyWith(color: appConstants.editbuttonColor),
                    color: appConstants.viewContainerBackGroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    borderRadius: 7.r,
                    context: context,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
