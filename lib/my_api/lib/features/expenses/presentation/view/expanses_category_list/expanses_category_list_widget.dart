import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/add_expense_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/expanses_category_list/expanses_category_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ExpensesCategoryListWidget extends State<ExpensesCategoryListScreen> {
  @override
  void initState() {
    super.initState();
    expensesCubit = getItInstance<ExpensesCubit>();
    expensesCubit.loaded();
  }

// App bar
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      elevation: 0.5,
      shadowcolor: appConstants.dividerColor,
      context,
      onTap: () => CommonRouter.pop(),
      titleCenter: false,
      title: TranslationConstants.expenses.translate(context),
      trailing: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(appConstants.transparent),
        ),
        child: CommonWidget.commonText(
          textAlign: TextAlign.left,
          text: TranslationConstants.reset.translate(context),
          color: appConstants.editbuttonColor,
          fontSize: 17,
        ),
      ),
    );
  }

// Total expense and Search Field
  Widget topBar({required BuildContext context}) {
    return CommonWidget.container(
      width: ScreenUtil().screenWidth,
      color: appConstants.drawerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          children: [
            Row(
              children: [
                CommonWidget.commonText(
                  text: "${TranslationConstants.total_expenses.translate(context)}:  ",
                  textAlign: TextAlign.left,
                  fontSize: 14,
                  color: appConstants.editbuttonColor,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(
                  child: CommonWidget.commonText(
                    text: 10000.formatCurrency(),
                    textAlign: TextAlign.left,
                    fontSize: 14,
                    color: appConstants.neutral1Color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            searchField(context),
          ],
        ),
      ),
    );
  }

  Widget searchField(BuildContext context) {
    return textField(
      hight: 18,
      context: context,
      width: ScreenUtil().screenWidth,
      controller: TextEditingController(),
      onTap: () {},
      onChanged: (v) {},
    );
  }

  Widget categoryCommonBox({
    required int index,
    required ExpensesLoadedState state,
    required SelectCategoryModel model,
  }) {
    return CommonWidget.container(
      padding: EdgeInsets.all(10.h),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      color: appConstants.white,
      borderRadius: 10.r,
      shadow: [
        BoxShadow(
          blurRadius: 0.3,
          spreadRadius: 1,
          color: appConstants.shadowColor1,
          offset: const Offset(0, 1),
        ),
      ],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 45.w),
            child: CommonWidget.commonText(
              text: "#${index + 1}",
              fontSize: 16,
              color: appConstants.editbuttonColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          CommonWidget.sizedBox(width: 10),
          CommonWidget.container(
            // width: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.container(
                  width: 200,
                  alignment: Alignment.centerLeft,
                  child: CommonWidget.commonText(
                    text: model.category.categoryName,
                    textAlign: TextAlign.left,
                    fontSize: 15,
                    bold: true,
                    color: appConstants.neutral1Color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.r),
                  child: Row(
                    children: [
                      CommonWidget.commonText(
                        text: "${TranslationConstants.type.translate(context)}: ",
                        textAlign: TextAlign.left,
                        fontSize: 13,
                        color: appConstants.neutral1Color,
                      ),
                      CommonWidget.container(
                        width: 130,
                        alignment: Alignment.centerLeft,
                        child: CommonWidget.commonText(
                          textAlign: TextAlign.left,
                          text: model.category.categoryType,
                          fontSize: 13,
                          color: appConstants.neutral1Color.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonWidget.commonText(text: ""),
              CommonWidget.container(
                width: 80,
                alignment: Alignment.centerRight,
                child: CommonWidget.commonText(
                  text: 10000.formatCurrency(),
                  fontSize: 14,
                  color: appConstants.neutral1Color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// bottom Button
  Widget bottomButton(BuildContext context) {
    return CommonWidget.container(
      height: 80,
      width: newDeviceType == NewDeviceType.phone
          ? ScreenUtil().screenWidth
          : newDeviceType == NewDeviceType.tablet
              ? ScreenUtil().screenWidth
              : double.infinity,
      color: Colors.white,
      child: Center(
        child: GestureDetector(
          onTap: () => CommonRouter.pushNamed(
            RouteList.add_expanses,
            arguments: const AddExpenseScreenArgs(
              navigateFrom: AddExpenseNavigation.add,
            ),
          ),
          child: Container(
            height: 45.h,
            width: newDeviceType == NewDeviceType.phone
                ? 200.w
                : newDeviceType == NewDeviceType.tablet
                    ? ScreenUtil().screenWidth / 1.5
                    : ScreenUtil().screenWidth / 1.2,
            decoration: BoxDecoration(color: appConstants.theme1Color, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/customer/add_new.svg", height: 20.h),
                CommonWidget.sizedBox(width: 10),
                CommonWidget.commonText(
                  text: TranslationConstants.add_expense.translate(context),
                  fontSize: 15,
                  color: appConstants.white,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
