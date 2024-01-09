import 'package:bakery_shop_admin_flutter/features/marketing/data/models/marketing_model.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/banner_screen/banner_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget popUpView({
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
            itemBuilder: (contex, index) {
              return popItemView(
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

Widget popItemView({
  required int index,
  required MarketingLoadedState state,
  required List<MarketingDataModel> displayData,
  required BuildContext context,
  required MarketingCubit marketingCubit,
}) {
  return CommonWidget.container(
    borderRadius: 6.r,
    margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
    padding: EdgeInsets.all(8.h),
    width: double.infinity,
    color: appConstants.white,
    shadow: [
      BoxShadow(
        spreadRadius: 2,
        color: appConstants.cookingWarning.withOpacity(0.2),
        offset: const Offset(0, 3),
        blurRadius: 3,
      ),
    ],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CommonWidget.commonText(
              text: "#${index + 1} ",
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            title(marketingDataModel: displayData[index]),
            CommonWidget.sizedBox(width: 10.w),
            Icon(
              Icons.close,
              color: appConstants.black26,
            ),
          ],
        ),
        CommonWidget.sizedBox(height: 10.h),
        marketingImageView(height: 335.h, index: index, state: state),
        CommonWidget.sizedBox(height: 10.h),
        Row(
          children: [
            Expanded(child: linkText(marketingDataModel: displayData[index])),
            CommonWidget.sizedBox(width: 10.w),
            editButton(state: state, index: index),
            CommonWidget.sizedBox(width: 10),
            deleteButton(context: context, index: index, marketingCubit: marketingCubit, state: state),
          ],
        ),
        CommonWidget.sizedBox(height: 8.h),
        toggleButtonAndDate(
          context: context,
          displayData: displayData,
          index: index,
          marketingCubit: marketingCubit,
          state: state,
        ),
      ],
    ),
  );
}
