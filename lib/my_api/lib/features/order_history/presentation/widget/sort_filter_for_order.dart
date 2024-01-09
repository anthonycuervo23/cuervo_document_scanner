import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/order_cubit/order_history_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/sort_filter_for_order/sort_filter_for_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> deliverySortingList = [
  'All',
  'Pending',
  'Delivered',
  'Customer Cancel',
  'Reject Order',
  'Return Order',
];

List<String> paymentSortingList = [
  'All',
  'Cash',
  'Upi',
  'Credit Card',
  'Paid',
  'Un Paid',
];

List<String> settlementSortingList = [
  'All',
  'Pending',
  'Done',
];

List<String> types = [
  'Delivery',
  'Payment',
];

List<String> filterCategoryByName = [
  'Name : A to Z',
  'Name : Z to A',
  'Amount : High to Low',
  'Amount : Low to High',
];

Future<dynamic> sortFilterForOrderDialog({
  required BuildContext context,
  required CounterCubit counterCubit,
  required SortFilterForOrderCubit sortFilterForOrderCubit,
  required OrderHistoryCubit orderCubit,
  required OrderHistoryLoadedState orderState,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<SortFilterForOrderCubit, SortFilterForOrderState>(
        bloc: sortFilterForOrderCubit,
        builder: (context, state) {
          if (state is SortFilterForOrderLoadedState) {
            return AlertDialog(
              surfaceTintColor: appConstants.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              contentPadding: EdgeInsets.all(16.h),
              titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
              content: SizedBox(
                width: ScreenUtil().screenWidth,
                child: dialogView(
                    context: context,
                    counterCubit: counterCubit,
                    sortFilterForOrderCubit: sortFilterForOrderCubit,
                    state: state,
                    orderState: orderState,
                    orderCubit: orderCubit),
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
  required SortFilterForOrderCubit sortFilterForOrderCubit,
  required SortFilterForOrderLoadedState state,
  required OrderHistoryLoadedState orderState,
  required OrderHistoryCubit orderCubit,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      dialogTitle(context: context),
      customerList(
        counterCubit: counterCubit,
        state: state,
        sortFilterForOrderCubit: sortFilterForOrderCubit,
        orderCubit: orderCubit,
        orderState: orderState,
      ),
      CommonWidget.sizedBox(height: 10.h),
      CommonWidget.commonDashLine(height: 20, width: double.infinity),
      CommonWidget.sizedBox(height: 10.h),
      sortingCategoryByName(context: context, sortFilterForOrderCubit: sortFilterForOrderCubit, state: state),
      CommonWidget.sizedBox(height: 10.h),
      CommonWidget.sizedBox(height: 30.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          comonButton(
            context: context,
            onTap: () => CommonRouter.pop(args: "error"),
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
              String deliveryValue = deliverySortingList[state.deliveryTypeIndex].replaceAll(' ', '');
              String paymentValue = paymentSortingList[state.paymentTypeIndex].replaceAll(' ', '');
              String nameValue = state.selectedFilterByName.isEmpty
                  ? ""
                  : state.selectedFilterByName[0].replaceAll(
                      ' ',
                      '',
                    );
              CommonRouter.pop(args: '$deliveryValue $paymentValue $nameValue');
            },
            bgColor: appConstants.themeColor,
          ),
        ],
      )
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
          onPressed: () => CommonRouter.pop(),
          icon: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/common/close_icon.svg",
            height: 22.r,
          ),
        ),
      ],
    ),
  );
}

Widget customerList({
  required CounterCubit counterCubit,
  required SortFilterForOrderLoadedState state,
  required SortFilterForOrderCubit sortFilterForOrderCubit,
  required OrderHistoryCubit orderCubit,
  required OrderHistoryLoadedState orderState,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Visibility(
            visible: orderState.filterValue.compareTo("supplierReturnList") != 0,
            child: Column(
              children: [
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () => sortFilterForOrderCubit.changeTypes(state: state, index: 0),
                  child: CommonWidget.commonText(
                    text: "Delivery",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.r,
                      color: state.typeIndex == 0 ? const Color(0xff4392F1) : const Color(0xff293847).withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () => sortFilterForOrderCubit.changeTypes(state: state, index: 1),
                  child: CommonWidget.commonText(
                    text: "Payment",
                    style: TextStyle(
                      fontSize: 16.r,
                      fontWeight: FontWeight.bold,
                      color: state.typeIndex == 1 ? const Color(0xff4392F1) : const Color(0xff293847).withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: orderState.filterValue.compareTo("supplierReturnList") == 0,
            child: Column(
              children: [
                CommonWidget.commonText(
                  text: "Settlement",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.r,
                    color: const Color(0xff4392F1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(width: 20.w),
      CommonWidget.container(
        height: state.typeIndex == 0 ? 300.h : 200.h,
        width: 1.w,
        color: const Color(0xff293847).withOpacity(0.2),
      ),
      SizedBox(width: 40.w),
      Expanded(
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orderState.filterValue.compareTo("supplierReturnList") == 0
              ? settlementSortingList.length
              : state.typeIndex == 1
                  ? paymentSortingList.length
                  : deliverySortingList.length,
          itemBuilder: (context, index) => commonFilterItem(
            sortFilterForOrderCubit: sortFilterForOrderCubit,
            state: state,
            index: index,
            title: orderState.filterValue.compareTo("supplierReturnList") == 0
                ? settlementSortingList[index]
                : state.typeIndex == 1
                    ? paymentSortingList[index]
                    : deliverySortingList[index],
          ),
        ),
      ),
    ],
  );
}

Widget commonFilterItem({
  required int index,
  required SortFilterForOrderLoadedState state,
  required SortFilterForOrderCubit sortFilterForOrderCubit,
  required String title,
}) {
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    onTap: () {
      if (state.typeIndex == 0) {
        sortFilterForOrderCubit.deliveryChangeIndex(index: index, state: state);
      } else {
        sortFilterForOrderCubit.paymentChangeIndex(index: index, state: state);
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonText(
          text: title,
          style: TextStyle(
            fontSize: 16.r,
            color: state.typeIndex == 0
                ? index == state.deliveryTypeIndex
                    ? const Color(0xff4392F1)
                    : const Color(0xff293847).withOpacity(0.8)
                : index == state.paymentTypeIndex
                    ? const Color(0xff4392F1)
                    : const Color(0xff293847).withOpacity(0.8),
          ),
        ),
        Transform.scale(
          scale: 1.5,
          child: Radio(
            value: index,
            groupValue: state.typeIndex == 0 ? state.deliveryTypeIndex : state.paymentTypeIndex,
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
              if (state.typeIndex == 0) {
                sortFilterForOrderCubit.deliveryChangeIndex(index: value ?? 1, state: state);
              } else {
                sortFilterForOrderCubit.paymentChangeIndex(index: value ?? 1, state: state);
              }
            },
          ),
        ),
      ],
    ),
  );
}

Widget sortingCategoryByName({
  required BuildContext context,
  required SortFilterForOrderCubit sortFilterForOrderCubit,
  required SortFilterForOrderLoadedState state,
}) {
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
          sortFilterForOrderCubit.applyFilterByName(item: filterCategoryByName[index], state: state);
        },
        onTapDeleteIcon: () {
          sortFilterForOrderCubit.removeFilter(
            item: filterCategoryByName[index],
            selectedFilter: state.selectedFilterByName,
            state: state,
            checkRemove: true,
          );
        },
      ),
    ),
  );
}

// Widget sortingCategoryByPrice({
//   required BuildContext context,
//   required SortFilterForOrderCubit sortFilterForOrderCubit,
//   required SortFilterForOrderLoadedState state,
// }) {
//   return Wrap(
//     spacing: 10.r,
//     runSpacing: 10.r,
//     children: List.generate(
//       filterCategoryByPrice.length,
//       (index) => commonSortingButton(
//         visible: state.selectedFilterByPrice.contains(filterCategoryByPrice[index]) ? true : false,
//         text: filterCategoryByPrice[index],
//         color: state.selectedFilterByPrice.contains(filterCategoryByPrice[index])
//             ? appConstants.transparent
//             : const Color(0xffF1F1F1),
//         borderColor: state.selectedFilterByPrice.contains(filterCategoryByPrice[index])
//             ? const Color(0xff4392F1)
//             : appConstants.transparent,
//         onTap: () {
//           sortFilterForOrderCubit.applyFilterByPrice(item: filterCategoryByPrice[index], state: state);
//         },
//         onTapDeleteIcon: () {
//           sortFilterForOrderCubit.removeFilter(
//             item: filterCategoryByPrice[index],
//             selectedFilter: state.selectedFilterByPrice,
//             state: state,
//             checkRemove: false,
//           );
//         },
//       ),
//     ),
//   );
// }

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
