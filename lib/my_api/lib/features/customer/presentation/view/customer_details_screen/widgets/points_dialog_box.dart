import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dataView({required CustomerDetailModel customerDetailModel, required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.only(right: 8.w, left: 8.w, bottom: 8.h),
    child: CommonWidget.container(
      color: appConstants.white,
      isBorder: true,
      borderRadius: 10.r,
      borderWidth: 1,
      borderColor: appConstants.tableBorderColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Column(
          children: [
            Row(
              children: [
                tableTileRow(title: TranslationConstants.has, width: 30.w, fontSize: 13.sp),
                SizedBox(
                    width: 80.w,
                    child: tableTileRow(title: TranslationConstants.date.translate(context), fontSize: 13.sp)),
                Expanded(child: tableTileRow(title: TranslationConstants.source.translate(context), fontSize: 13.sp)),
                SizedBox(
                    width: 70.w,
                    child: tableTileRow(title: TranslationConstants.points.translate(context), fontSize: 13.sp)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customerDetailModel.referList[0].pointList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var customerData = customerDetailModel.referList[0].pointList[index];
                  return Row(
                    children: [
                      tableDataBox(
                        customerDetailModel: customerDetailModel,
                        text: "${index + 1}",
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: tableDataBox(
                          customerDetailModel: customerDetailModel,
                          text: customerData.date,
                          padding: 5,
                        ),
                      ),
                      Expanded(
                        child: tableDataBox(
                          customerDetailModel: customerDetailModel,
                          text: customerData.sources,
                          padding: 5,
                        ),
                      ),
                      SizedBox(
                        width: 70.w,
                        child: tableDataBox(
                            customerDetailModel: customerDetailModel,
                            text: customerData.point.toString(),
                            textColor: const Color.fromRGBO(67, 146, 241, 1)),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget tableDataBox({
  required CustomerDetailModel customerDetailModel,
  required String text,
  double? width,
  double? padding,
  Color? textColor,
}) {
  return containtBox(
    text: text,
    padding: padding,
    boxColor: appConstants.white,
    width: width ?? 35.w,
    textColor: textColor ?? appConstants.black,
    isOpenDialog: true,
    list: customerDetailModel.referList[0].pointList,
  );
}

Widget tableTileRow({required String title, double? width, double? fontSize}) {
  return containtBox(
    borderColor: appConstants.theme2Color,
    text: title,
    boxColor: appConstants.theme1Color,
    width: width ?? 35.w,
    fontSize: fontSize ?? 10.sp,
    isOpenDialog: true,
    textColor: appConstants.white,
  );
}

Widget containtBox({
  required Color boxColor,
  required String text,
  Color? borderColor,
  double? width,
  double? fontSize,
  required Color textColor,
  List<PointListModel>? list,
  bool isOpenDialog = false,
  double? padding,
}) {
  return CommonWidget.container(
    width: width,
    height: 50.h,
    isBorder: true,
    padding: EdgeInsets.only(left: padding ?? 0),
    borderColor: borderColor ?? const Color.fromRGBO(240, 240, 240, 1),
    borderWidth: 0.8,
    // isBorderOnlySide: true,
    color: boxColor,
    alignment: padding == null ? Alignment.center : Alignment.centerLeft,
    child: CommonWidget.commonText(
      color: textColor,
      fontSize: fontSize ?? 10.sp,
      textAlign: TextAlign.center,
      text: text,
      maxLines: 2,
    ),
  );
}

void showDiolg({required CustomerDetailModel customerDetailModel, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        surfaceTintColor: appConstants.white,
        backgroundColor: appConstants.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        titlePadding: EdgeInsets.only(top: 10.h),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(10.h),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.commonText(
                      text: TranslationConstants.pointer_list.translate(context),
                      color: const Color.fromRGBO(8, 66, 119, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  InkWell(
                    onTap: () => CommonRouter.pop(),
                    child: CommonWidget.container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      child: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/common/close_icon.svg",
                        height: 28.h,
                        color: const Color.fromRGBO(8, 66, 119, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color.fromRGBO(41, 56, 71, 0.1)),
          ],
        ),
        content: Container(
            constraints: BoxConstraints(maxHeight: 550.h),
            padding: EdgeInsets.all(10.h),
            width: ScreenUtil().screenWidth,
            child: dataView(context: context, customerDetailModel: customerDetailModel)),
      );
    },
  );
}
