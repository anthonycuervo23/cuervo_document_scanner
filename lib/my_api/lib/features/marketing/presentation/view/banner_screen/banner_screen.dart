import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/data/models/marketing_model.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/domain/entities/argumets/add_ads_argumets.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget bannerView({
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
              return bannerItemView(
                context: contex,
                displayData: displayData,
                index: index,
                marketingCubit: marketingCubit,
                state: state,
              );
            },
          ),
  );
}

Widget bannerItemView({
  required int index,
  required MarketingLoadedState state,
  required List<MarketingDataModel> displayData,
  required BuildContext context,
  required MarketingCubit marketingCubit,
}) {
  return CommonWidget.container(
    borderRadius: 5.r,
    margin: EdgeInsets.only(left: 5.h, right: 5.h, top: 10.h),
    padding: EdgeInsets.all(10.h),
    width: double.infinity,
    color: appConstants.white,
    shadow: [
      BoxShadow(
        color: appConstants.theme1Color.withOpacity(0.1),
        offset: const Offset(0, 2),
        blurRadius: 3,
      ),
    ],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        marketingImageView(height: 100.h, index: index, state: state),
        CommonWidget.sizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.commonText(
              maxLines: 1,
              text: "#${index + 1} ",
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            title(marketingDataModel: displayData[index]),
            CommonWidget.sizedBox(width: 10.w),
            editButton(state: state, index: index),
            CommonWidget.sizedBox(width: 10),
            deleteButton(context: context, index: index, marketingCubit: marketingCubit, state: state),
            CommonWidget.sizedBox(width: 2.w),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 23.w),
          child: Column(
            children: [
              linkText(marketingDataModel: displayData[index]),
              CommonWidget.sizedBox(height: 1.h),
              toggleButtonAndDate(
                context: context,
                displayData: displayData,
                index: index,
                marketingCubit: marketingCubit,
                state: state,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget editButton({required MarketingLoadedState state, required int index}) {
  return CommonWidget.svgIconButton(
    svgPicturePath: "assets/photos/svg/common/edit.svg",
    iconSize: 18.h,
    onTap: () => CommonRouter.pushNamed(
      RouteList.add_ads_screen,
      arguments: AddAdsScreebArgs(
        marketingDataModel: state.marketingData[index],
        selectedTab: state.selectedTab,
        fromEditScreen: true,
      ),
    ),
    color: appConstants.black,
  );
}

Widget deleteButton({
  required BuildContext context,
  required MarketingLoadedState state,
  required int index,
  required MarketingCubit marketingCubit,
}) {
  return CommonWidget.svgIconButton(
    svgPicturePath: "assets/photos/svg/common/trash.svg",
    iconSize: 18.h,
    color: appConstants.black,
    onTap: () => CommonWidget.showAlertDialog(
      maxLines: 2,
      leftColor: appConstants.theme1Color.withOpacity(0.2),
      context: context,
      onTap: () => marketingCubit.deleteItem(state: state, index: index),
      text: TranslationConstants.delete_banner_warning.translate(context),
      textColor: appConstants.black,
      isTitle: true,
      titleText: TranslationConstants.confirm_delete.translate(context),
      titleTextStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: appConstants.theme1Color,
      ),
    ),
  );
}

Widget title({required MarketingDataModel marketingDataModel}) {
  return Expanded(
    child: CommonWidget.container(
      alignment: Alignment.centerLeft,
      child: CommonWidget.commonText(
        text: marketingDataModel.title,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget linkText({required MarketingDataModel marketingDataModel}) {
  return CommonWidget.container(
    alignment: Alignment.centerLeft,
    child: CommonWidget.commonText(
      text: marketingDataModel.link,
      color: appConstants.editbuttonColor,
      fontSize: 12.sp,
    ),
  );
}

Widget marketingImageView({required MarketingLoadedState state, required int index, required double height}) {
  return CommonWidget.imageBuilder(
    imageUrl: state.marketingData[index].image,
    height: height,
    width: double.infinity,
    fit: BoxFit.cover,
    borderRadius: 5.r,
  );
}

Widget toggleButtonAndDate({
  required MarketingLoadedState state,
  required int index,
  required List<MarketingDataModel> displayData,
  required BuildContext context,
  required MarketingCubit marketingCubit,
}) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonWidget.commonText(
                text: "${TranslationConstants.start_date.translate(context)}: ",
                color: appConstants.black,
                fontSize: 10.sp,
              ),
              CommonWidget.commonText(
                text: displayData[index].startDate,
                color: appConstants.black38,
                fontSize: 10.sp,
              ),
            ],
          ),
          CommonWidget.sizedBox(height: 3.h),
          Row(
            children: [
              CommonWidget.commonText(
                text: "${TranslationConstants.end_date.translate(context)}: ",
                color: appConstants.black,
                fontSize: 10.sp,
              ),
              CommonWidget.commonText(
                text: displayData[index].endDate,
                color: appConstants.black38,
                fontSize: 10.sp,
              ),
            ],
          ),
        ],
      ),
      const Spacer(),
      CommonWidget.commonText(
        text: "${TranslationConstants.app_live_status.translate(context).toCamelcase()}:",
        fontSize: 10.sp,
        color: appConstants.black,
      ),
      CommonWidget.sizedBox(width: 7),
      CommonWidget.toggleButton(
        buttnWidth: 25.w,
        activeTrackColor: appConstants.editbuttonColor,
        activeThumbColor: appConstants.white,
        inactiveTrackColor: appConstants.black38,
        value: state.marketingData[index].liveStatus,
        onChanged: (value) {
          marketingCubit.toggleSwitch(index: index, productData: state.marketingData, state: state, value: value);
        },
      ),
    ],
  );
}
