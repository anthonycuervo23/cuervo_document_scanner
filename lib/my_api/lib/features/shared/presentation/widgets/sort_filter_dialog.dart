import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';

import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List filterDataList = [
  'All',
  'New Customer',
  'Repeat Customer',
  'Refer Customer',
  'Loyal Customer',
];

List filterByNameAndCategory = [
  'Name : A to Z',
  'Name : Z to A',
  'Amount : High to Low',
  'Amount : Low to High',
];

List<String> filterCategoryByName = [
  'Name : A to Z',
  'Name : Z to A',
  'Amount : High to Low',
  'Amount : Low to High',
];
List filterCategoryByPrice = [
  'Amount : High to Low',
  'Amount : Low to High',
];

int filterIndex = 0;

Future<dynamic> sortFilterDialog({
  required BuildContext context,
  required CounterCubit counterCubit,
  required SortFilterCubit sortFilterCubit,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<SortFilterCubit, SortFilterState>(
        bloc: sortFilterCubit,
        builder: (context, state) {
          if (state is SortFilterLoadedState) {
            return AlertDialog(
              surfaceTintColor: appConstants.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
              title: SizedBox(
                width: ScreenUtil().screenWidth,
                child: dialogView(
                  context: context,
                  counterCubit: counterCubit,
                  sortFilterCubit: sortFilterCubit,
                  state: state,
                ),
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
  required CounterCubit counterCubit,
  required SortFilterCubit sortFilterCubit,
  required SortFilterLoadedState state,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      dialogTitle(context: context),
      SizedBox(height: 250.h, child: customerList(counterCubit: counterCubit)),
      CommonWidget.sizedBox(height: 5.h),
      CommonWidget.commonDashLine(height: 20, width: double.infinity),
      CommonWidget.sizedBox(height: 15.h),
      SizedBox(
          height: 100.h,
          child: sortingCategoryByName(context: context, sortFilterCubit: sortFilterCubit, state: state)),
      CommonWidget.sizedBox(height: 40.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          comonButton(
            context: context,
            onTap: () => CommonRouter.pop(args: 'clear'),
            text: TranslationConstants.clear.translate(context),
            textColor: appConstants.themeColor,
            bgColor: const Color(0xffDCE8F3),
          ),
          SizedBox(width: 15.w),
          comonButton(
            context: context,
            text: TranslationConstants.apply.translate(context),
            textColor: appConstants.white,
            onTap: () {
              String value = "";

              if (state.selectedFilterByName.isNotEmpty && state.selectedFilterByPrice.isNotEmpty) {
                for (String e in filterCategoryByName) {
                  if (e == state.selectedFilterByName[0]) {
                    value =
                        "${filterDataList[filterIndex]} _ ${state.selectedFilterByName[0]} _ ${state.selectedFilterByPrice[0]}";
                  }
                }
              } else if (state.selectedFilterByPrice.isNotEmpty) {
                for (String e in filterCategoryByPrice) {
                  if (e == state.selectedFilterByPrice[0]) {
                    value = "${filterDataList[filterIndex]} _ $e";
                  }
                }
              } else if (state.selectedFilterByName.isNotEmpty) {
                for (String e in filterCategoryByName) {
                  if (e == state.selectedFilterByName[0]) {
                    value = "${filterDataList[filterIndex]} _ $e";
                  }
                }
              } else {
                value = "${filterDataList[filterIndex]}";
              }
              CommonRouter.pop(args: value);
            },
            bgColor: appConstants.themeColor,
          ),
        ],
      ),
      CommonWidget.sizedBox(height: 10.h),
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
          text: "Sort Filter",
          style: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                color: appConstants.theme1Color,
              ),
        ),
        IconButton(
          onPressed: () => CommonRouter.pop(args: 'error'),
          icon: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/common/close_icon.svg",
            height: 22.r,
          ),
        ),
      ],
    ),
  );
}

Widget customerList({required CounterCubit counterCubit}) {
  return ListView.builder(
    primary: false,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: filterDataList.length,
    itemBuilder: (context, index) => commonFilterItem(
      index: index,
      counterCubit: counterCubit,
    ),
  );
}

Widget commonFilterItem({required int index, required CounterCubit counterCubit}) {
  return BlocBuilder<CounterCubit, int>(
    bloc: counterCubit,
    builder: (context, state) {
      filterIndex = state;
      return InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () => counterCubit.chanagePageIndex(index: index),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidget.commonText(
              text: filterDataList[index],
              style: TextStyle(
                fontSize: 16.r,
                color: index == state ? const Color(0xff4392F1) : const Color(0xff293847).withOpacity(0.8),
              ),
            ),
            Transform.scale(
              scale: 1.5,
              child: Radio(
                value: index,
                groupValue: state,
                fillColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Color(0xff4392F1);
                    } else {
                      return appConstants.black45;
                    }
                  },
                ),
                onChanged: (value) {
                  counterCubit.chanagePageIndex(index: value!);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget sortingCategoryByName({
  required BuildContext context,
  required SortFilterCubit sortFilterCubit,
  required SortFilterLoadedState state,
}) {
  return BlocBuilder<SortFilterCubit, SortFilterState>(
    bloc: sortFilterCubit,
    builder: (context, state) {
      if (state is SortFilterLoadedState) {
        return Wrap(
          spacing: 10.r,
          runSpacing: 10.r,
          children: List.generate(
            filterCategoryByName.length,
            (index) => commonSortingButton(
              visible: state.selectedFilterByName.contains(filterCategoryByName[index]) ? true : false,
              text: filterCategoryByName[index],
              color: state.selectedFilterByName.contains(filterCategoryByName[index])
                  ? appConstants.transparent
                  : const Color(0xffF1F1F1),
              borderColor: state.selectedFilterByName.contains(filterCategoryByName[index])
                  ? const Color(0xff4392F1)
                  : appConstants.transparent,
              onTap: () {
                sortFilterCubit.applyFilterByName(item: filterCategoryByName[index]);
              },
              onTapDeleteIcon: () {
                sortFilterCubit.removeFilter(
                  state: state,
                  item: filterCategoryByName[index],
                  selectedFilter: state.selectedFilterByName,
                  checkRemove: true,
                );
              },
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    },
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

Widget comonButton({
  required BuildContext context,
  required String text,
  required Color textColor,
  required Color bgColor,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: Container(
      child: CommonWidget.commonButton(
        context: context,
        alignment: Alignment.center,
        onTap: onTap,
        text: text,
        textColor: textColor,
        color: bgColor,
        borderRadius: 8.r,
        padding: EdgeInsets.symmetric(vertical: 8.h),
      ),
    ),
  );
}
