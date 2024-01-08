import 'package:bakery_shop_admin_flutter/features/marketing/data/models/marketing_model.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/banner_screen/banner_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget notificationView({
  required MarketingLoadedState state,
  required List<MarketingDataModel> displayData,
  required BuildContext context,
  required MarketingCubit marketingCubit,
}) {
  return CommonWidget.container(
    color: appConstants.transparent,
    child: displayData.isEmpty
        ? CommonWidget.dataNotFound(
            context: context,
            actionButton: Container(),
          )
        : ListView.builder(
            itemCount: displayData.length,
            padding: EdgeInsets.only(bottom: 10.h),
            itemBuilder: (contex, index) {
              return notificationItemView(
                index: index,
                state: state,
                displayData: displayData,
                context: context,
                marketingCubit: marketingCubit,
              );
            },
          ),
  );
}

Widget notificationItemView({
  required int index,
  required MarketingLoadedState state,
  required List<MarketingDataModel> displayData,
  required BuildContext context,
  required MarketingCubit marketingCubit,
}) {
  return CommonWidget.container(
    borderRadius: 5.r,
    margin: EdgeInsets.only(left: 5.h, right: 5.h, top: 15.h),
    padding: EdgeInsets.all(8.h),
    width: double.infinity,
    color: appConstants.white,
    shadow: [
      BoxShadow(
        color: appConstants.black12,
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.container(
          height: 55.w,
          width: 55.w,
          color: appConstants.transparent,
          child: marketingImageView(height: 55.h, index: index, state: state),
        ),
        CommonWidget.sizedBox(width: 7.w),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonWidget.commonText(
                    text: "#${index + 1} ",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  title(marketingDataModel: displayData[index]),
                  CommonWidget.sizedBox(width: 10.w),
                  editButton(state: state, index: index),
                  CommonWidget.sizedBox(width: 10),
                  deleteButton(context: context, index: index, marketingCubit: marketingCubit, state: state),
                ],
              ),
              CommonWidget.container(
                alignment: Alignment.centerLeft,
                child: CommonWidget.commonText(
                  text: displayData[index].desription,
                  color: appConstants.black38,
                  fontSize: 12.sp,
                ),
              ),
              CommonWidget.container(
                alignment: Alignment.centerLeft,
                child: linkText(marketingDataModel: displayData[index]),
              ),
              CommonWidget.sizedBox(height: 2.h),
              toggleButtonAndDate(
                displayData: displayData,
                index: index,
                marketingCubit: marketingCubit,
                state: state,
                context: context,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
