import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/widgets/points_dialog_box.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget basicDetailsTab({required CustomerDetailModel customerDetailModel, required BuildContext context}) {
  return Column(
    children: [
      basicDetailsDataView(
        context: context,
        label: TranslationConstants.date_of_birth.translate(context),
        data: customerDetailModel.dateofBirth,
        style: Theme.of(context).textTheme.body2BookHeading.copyWith(
              color: appConstants.themeColor,
            ),
      ),
      basicDetailsDataView(
        context: context,
        style: Theme.of(context).textTheme.body2BookHeading.copyWith(
              color: appConstants.themeColor,
            ),
        label: TranslationConstants.anniversary_date.translate(context),
        data: customerDetailModel.anniversaryDate,
      ),
      basicDetailsDataView(
        context: context,
        style: Theme.of(context).textTheme.body2MediumHeading.copyWith(
              color: appConstants.referralCodeColor,
            ),
        label: TranslationConstants.referral_code.translate(context),
        data: customerDetailModel.referralCode,
      ),
      InkWell(
        onTap: () => showDiolg(customerDetailModel: customerDetailModel, context: context),
        child: basicDetailsDataView(
          context: context,
          style: TextStyle(fontSize: 15, color: appConstants.starColor),
          label: TranslationConstants.points.translate(context),
          data: customerDetailModel.points.toString(),
        ),
      ),
      basicDetailsDataView(
        context: context,
        style: Theme.of(context).textTheme.body2MediumHeading.copyWith(
              color: appConstants.textColor,
            ),
        label: TranslationConstants.total_order_amount.translate(context),
        data: customerDetailModel.totalOrderAmount.formatCurrency(),
      ),
      basicDetailsDataView(
        context: context,
        style: Theme.of(context).textTheme.body2MediumHeading.copyWith(
              color: appConstants.textColor,
            ),
        label: TranslationConstants.gst_no.translate(context),
        data: customerDetailModel.gstNo,
      ),
      basicDetailsDataView(
        context: context,
        style: Theme.of(context).textTheme.body2MediumHeading.copyWith(
              color: appConstants.textColor,
            ),
        label: TranslationConstants.pan_no.translate(context),
        data: customerDetailModel.panNo,
      ),
      CommonWidget.sizedBox(height: 10),
      referListAndFamilyDetailsView(context, customerDetailModel),
    ],
  );
}

Widget referListAndFamilyDetailsView(BuildContext context, CustomerDetailModel customerDetailModel) {
  return CommonWidget.container(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        referListAndFamilyDetails(
          context: context,
          label: TranslationConstants.refer_list.translate(context),
          familydata: [],
          referList: customerDetailModel.referList,
        ),
        referListAndFamilyDetails(
          context: context,
          label: TranslationConstants.family_details.translate(context),
          familydata: customerDetailModel.familyDetails,
          referList: [],
        ),
      ],
    ),
  );
}

Widget basicDetailsDataView(
    {required String label, required String data, required TextStyle style, required BuildContext context}) {
  return CommonWidget.container(
    child: Padding(
      padding: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonWidget.commonText(
            text: label,
            style: Theme.of(context).textTheme.body2BookHeading.copyWith(
                  color: appConstants.textColor,
                ),
          ),
          CommonWidget.commonText(text: data, style: style),
        ],
      ),
    ),
  );
}

Widget referListAndFamilyDetails({
  required String label,
  required List<FamilyDetailModel> familydata,
  required List<ReferDetailModel> referList,
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.only(top: 10.h, left: 14.w, right: 14.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: label,
          style: Theme.of(context).textTheme.body2MediumHeading.copyWith(
                color: appConstants.textColor,
              ),
        ),
        CommonWidget.commonButton(
          text: TranslationConstants.view.translate(context),
          style: Theme.of(context).textTheme.body2MediumHeading.copyWith(color: appConstants.editbuttonColor),
          color: appConstants.viewContainerBackGroundColor,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
          borderRadius: 50.r,
          context: context,
          onTap: () {
            if (familydata.isNotEmpty) {
              familyDialog(
                familydata: familydata,
                context: context,
              );
            } else {
              CommonRouter.pushNamed(RouteList.refer_list_screen, arguments: referList);
            }
          },
        )
      ],
    ),
  );
}

void familyDialog({
  required List<FamilyDetailModel> familydata,
  required BuildContext context,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(20.h),
        contentPadding: EdgeInsets.zero,
        content: CommonWidget.container(
          borderRadius: 10.r,
          width: newDeviceType != NewDeviceType.phone ? 350 : ScreenUtil().screenWidth * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: newDeviceType != NewDeviceType.phone
                      ? const EdgeInsets.only(top: 10, right: 10, left: 10)
                      : EdgeInsets.only(top: 12.h, right: 10.w, left: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidget.commonText(
                        text: TranslationConstants.family_details.translate(context),
                        color: appConstants.themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: newDeviceType != NewDeviceType.phone ? 16 : 17,
                      ),
                      CommonWidget.svgIconButton(
                        svgPicturePath: 'assets/photos/svg/common/close_icon.svg',
                        iconSize: newDeviceType != NewDeviceType.phone ? 28 : 22.sp,
                        isChangeColor: true,
                        color: appConstants.themeColor,
                        onTap: () => CommonRouter.pop(),
                      ),
                    ],
                  ),
                ),
                Divider(color: appConstants.black26),
                CommonWidget.sizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: familydata.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => CommonWidget.container(
                      child: Padding(
                        padding: newDeviceType != NewDeviceType.phone
                            ? EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h)
                            : EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                newDeviceType != NewDeviceType.phone
                                    ? CommonWidget.sizedBox(width: 10)
                                    : CommonWidget.sizedBox(width: 10),
                                CommonWidget.commonText(
                                    text: index < 9 ? "0${index + 1}" : "${index + 1}",
                                    color: appConstants.textColor,
                                    fontSize: newDeviceType != NewDeviceType.phone ? 14 : 14),
                                const Expanded(child: SizedBox.shrink()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    labels(
                                      label: TranslationConstants.name.translate(context),
                                      data: familydata[index].name,
                                    ),
                                    CommonWidget.sizedBox(height: 10),
                                    labels(
                                      label: TranslationConstants.date_of_birth.translate(context),
                                      data: familydata[index].dateOfBirth,
                                    ),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    labels(
                                      label: TranslationConstants.relationship.translate(context),
                                      data: familydata[index].relationship,
                                    ),
                                    CommonWidget.sizedBox(height: 10),
                                    labels(
                                      label: TranslationConstants.anniversary_date.translate(context),
                                      data: familydata[index].anniversaryDate,
                                    ),
                                  ],
                                ),
                                newDeviceType != NewDeviceType.phone
                                    ? CommonWidget.sizedBox(width: 15)
                                    : CommonWidget.sizedBox(width: 15),
                              ],
                            ),
                            CommonWidget.sizedBox(height: 15),
                            Visibility(
                              visible: index + 1 != familydata.length,
                              child: Padding(
                                padding: newDeviceType != NewDeviceType.phone
                                    ? EdgeInsets.only(right: 10.w, left: 5.w)
                                    : EdgeInsets.only(right: 10.w, left: 5.w),
                                child: CommonWidget.commonDashLine(),
                              ),
                            ),
                            CommonWidget.sizedBox(height: 15)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                newDeviceType != NewDeviceType.phone
                    ? CommonWidget.sizedBox(height: 10)
                    : CommonWidget.sizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget labels({required String label, required String data}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonWidget.commonText(
          text: label, color: appConstants.black26, fontSize: newDeviceType != NewDeviceType.phone ? 14 : 14),
      (data == "")
          ? CommonWidget.commonText(
              text: "--", color: appConstants.textColor, fontSize: newDeviceType != NewDeviceType.phone ? 14 : 14)
          : CommonWidget.commonText(
              text: data,
              color: appConstants.textColor,
              fontWeight: FontWeight.w500,
              fontSize: newDeviceType != NewDeviceType.phone ? 14 : 14),
    ],
  );
}
