// ignore_for_file: constant_identifier_names

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_state.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SearchCategory { Today, Yesterday, Last_7_Days, Last_30_Days, This_Month, Last_Month, Custom_Range, All }

Future searchFilterDialog({
  required BuildContext context,
  required SearchFilterCubit searchFilterCubit,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return BlocBuilder<SearchFilterCubit, SearchFilterState>(
        bloc: searchFilterCubit,
        builder: (context, state) {
          if (state is SearchFilterLoadedState) {
            return AlertDialog(
              surfaceTintColor: appConstants.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
              insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10),
              title: dialogView(
                context: context,
                state: state,
                searchFilterCubit: searchFilterCubit,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );
    },
  );
}

Column dialogView({
  required BuildContext context,
  required SearchFilterLoadedState state,
  required SearchFilterCubit searchFilterCubit,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      dialogTitle(context: context),
      sortingCategory(context: context, state: state, searchFilterCubit: searchFilterCubit),
      CommonWidget.sizedBox(height: 10.h),
      state.isCustomRange == true
          ? calenderView(context: context, searchFilterCubit: searchFilterCubit)
          : const SizedBox.shrink(),
      SizedBox(height: 20.h),
      searchNowButton(
        searchFilterCubit: searchFilterCubit,
        context: context,
        state: state,
      ),
      SizedBox(height: 15.h),
    ],
  );
}

Widget dialogTitle({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.r),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.search.translate(context).toCamelcase(),
          style: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                color: appConstants.theme1Color,
              ),
        ),
        IconButton(
          onPressed: () {
            CommonRouter.pop(args: 'error');
          },
          icon: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/common/close_icon.svg",
            height: 22.r,
          ),
        ),
      ],
    ),
  );
}

Widget sortingCategory({
  required BuildContext context,
  required SearchFilterLoadedState state,
  required SearchFilterCubit searchFilterCubit,
}) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: List.generate(
      SearchCategory.values.length - 1,
      (index) {
        var selectedFilter = state.selectedFilter.contains(SearchCategory.values[index].name);
        return commonSortingButton(
          text: SearchCategory.values[index].name.toString().replaceAll('_', ' '),
          color: selectedFilter ? appConstants.transparent : const Color(0xffF1F1F1),
          borderColor: selectedFilter ? const Color(0xff4392F1) : appConstants.transparent,
          visible: selectedFilter ? true : false,
          onTap: () => searchFilterCubit.applyFilter(item: SearchCategory.values[index].name),
          onTapDeleteIcon: () => searchFilterCubit.removeFilter(
            item: SearchCategory.values[index].name,
            selectedFilter: state.selectedFilter,
            isCustomRange: state.isCustomRange,
          ),
        );
      },
    ),
  );
}

Widget commonSortingButton({
  required String text,
  required VoidCallback onTap,
  Color? color,
  Color? borderColor,
  bool? visible,
  VoidCallback? onTapDeleteIcon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: CommonWidget.container(
      color: color,
      borderColor: borderColor,
      padding: EdgeInsets.all(8.h),
      borderRadius: 5.r,
      isBorder: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonWidget.commonText(text: text, fontSize: 14),
          Visibility(
            visible: visible ?? (false),
            child: GestureDetector(
              onTap: onTapDeleteIcon,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: CommonWidget.imageButton(
                  svgPicturePath: "assets/photos/svg/common/close_icon.svg",
                  color: appConstants.themeColor,
                  iconSize: 12.sp,
                  onTap: onTapDeleteIcon,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget calenderView({required BuildContext context, required SearchFilterCubit searchFilterCubit}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          pickedDate(context: context, title: 'From', controller: searchFilterCubit.fromdateController),
          CommonWidget.sizedBox(width: 13.w),
          pickedDate(title: 'To', context: context, controller: searchFilterCubit.todateController),
        ],
      ),
      CommonWidget.sizedBox(height: 20.h),
      CommonWidget.commonDashLine(height: 20, width: ScreenUtil().screenWidth),
      datePicker(searchFilterCubit: searchFilterCubit),
    ],
  );
}

Widget pickedDate({required String title, required BuildContext context, required TextEditingController controller}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: title,
          fontWeight: FontWeight.w500,
          fontSize: 10.sp,
          color: const Color(0xff293847).withOpacity(0.4),
        ),
        CommonWidget.textField(
          enabled: false,
          controller: controller,
          contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
          focusedBorderColor: appConstants.theme1Color,
          cursorColor: appConstants.theme1Color,
          borderColor: const Color(0xff8EA3B9).withOpacity(0.4),
        ),
      ],
    ),
  );
}

Widget datePicker({required SearchFilterCubit searchFilterCubit}) {
  var config = CalendarDatePicker2Config(
    themeColor: appConstants.themeColor,
    calendarType: CalendarDatePicker2Type.range,
    weekNameTextStyle: TextStyle(fontSize: 12, color: appConstants.themeColor),
    notSelectedDataTextStyle: const TextStyle(fontSize: 14),
    selectedDataTextStyle: TextStyle(fontSize: 14, color: appConstants.white),
    arrowColor: appConstants.themeColor,
    currentDayBoarderColor: appConstants.themeColor,
  );
  return SizedBox(
    width: ScreenUtil().screenWidth,
    child: CalendarDatePicker2(
      config: config,
      value: [DateTime.now()],
      onValueChanged: (value) => searchFilterCubit.getDate(value: value),
    ),
  );
}

Widget searchNowButton({
  required BuildContext context,
  required SearchFilterLoadedState state,
  required SearchFilterCubit searchFilterCubit,
}) {
  return CommonWidget.commonButton(
    alignment: Alignment.center,
    textColor: appConstants.white,
    height: 40.h,
    text: TranslationConstants.search_now.translate(context),
    context: context,
    onTap: () {
      String value = "";
      if (state.selectedFilter.isNotEmpty) {
        for (int i = 0; i < SearchCategory.values.length; i++) {
          if (SearchCategory.values[i].name.compareTo(state.selectedFilter[0]) == 0) {
            value = state.selectedFilter[0];
          }
        }
      }
      if (value == SearchCategory.Custom_Range.name) {
        value =
            "${SearchCategory.Custom_Range.name} - ${searchFilterCubit.fromdateController.text} - ${searchFilterCubit.todateController.text}";
      }
      CommonRouter.pop(args: value);
    },
  );
}
