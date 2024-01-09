import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/add_expense_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/expense_category_item_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/expanses_category_item/expanses_category_item_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/bottom_bar/open_bottom_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ExpansesCategoryItemWidget extends State<ExpansesCategoryItemScreen> {
  late SelectCategoryModel selectCategoryModel;
  TextEditingController category = TextEditingController();
  String initialCategoryType = "";
  @override
  void initState() {
    super.initState();
    selectCategoryModel = widget.selectCategoryModel;
    initialCategoryType = selectCategoryModel.category.categoryType;
    category = TextEditingController(text: selectCategoryModel.category.categoryName);
    expensesCubit.loaded();
  }

  @override
  void dispose() {
    expensesCubit.loadingCubit.hide();
    super.dispose();
  }

// app Bar
  PreferredSizeWidget? appBar({required SelectCategoryModel model, required ExpensesLoadedState state}) {
    return CustomAppBar(
      context,
      titleCenter: false,
      onTap: () => CommonRouter.pop(),
      actions: [
        CommonWidget.textButton(
          text: TranslationConstants.edit.translate(context),
          textColor: appConstants.editbuttonColor,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          onTap: () => editCategoryBottomBar(state: state),
        ),
        CommonWidget.sizedBox(width: 12),
        CommonWidget.textButton(
          text: TranslationConstants.delete.translate(context),
          textColor: appConstants.deleteBtnColor,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          onTap: () => deleteButtonTap(),
        ),
        CommonWidget.sizedBox(width: 15),
      ],
      titleWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            textAlign: TextAlign.left,
            text: model.category.categoryName,
            fontSize: 18,
            color: appConstants.neutral1Color,
            fontWeight: FontWeight.w600,
          ),
          CommonWidget.commonText(
            textAlign: TextAlign.left,
            text: "${TranslationConstants.type.translate(context)}: ${model.category.categoryType}",
            fontSize: 12,
            color: appConstants.neutral6Color,
          ),
        ],
      ),
    );
  }

  void deleteButtonTap() {
    return CommonWidget.showAlertDialog(
      context: context,
      isTitle: true,
      maxLines: 2,
      leftColor: appConstants.clearbuttonColor,
      leftButtonText: TranslationConstants.cancel.translate(context),
      rightButtonText: TranslationConstants.save.translate(context),
      textColor: appConstants.successAnimationColor,
      text: TranslationConstants.delete_expense_category_warning.translate(context),
      titleText: TranslationConstants.confirm_delete.translate(context),
      titleTextStyle: TextStyle(color: appConstants.theme1Color, fontSize: 18.sp, fontWeight: FontWeight.bold),
      onTap: () => CommonRouter.pop(),
    );
  }

//Category bottom Bar
  Future<dynamic> editCategoryBottomBar({required ExpensesLoadedState state}) {
    return openBottomBar(
      context: context,
      isTitleBar: true,
      backgroundColor: appConstants.white,
      title: TranslationConstants.edit_category.translate(context),
      titleTextStye: TextStyle(
        color: appConstants.theme1Color,
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      ),
      child: Column(
        children: [
          CommonWidget.sizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                categoryNameAndTextField(),
                CommonWidget.sizedBox(height: 10),
                CommonWidget.commonText(
                  text: TranslationConstants.category_type.translate(context),
                  fontSize: 14,
                  color: appConstants.neutral1Color,
                  fontWeight: FontWeight.w600,
                ),
                categoryTypeSelection(),
              ],
            ),
          ),
          saveButton(
              context: context,
              onTap: () {
                expensesCubit.changeCategoryNameAanType(
                  state: state,
                  selectCategoryModel: selectCategoryModel,
                  categoryName: category.text,
                  categoryType: initialCategoryType,
                );
                CommonRouter.pop();
              }),
        ],
      ),
    );
  }

  Widget categoryNameAndTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.category_name.translate(context),
          fontSize: 14,
          color: appConstants.neutral1Color,
          fontWeight: FontWeight.w600,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: CommonWidget.textField(
            borderRadius: 8.r,
            cursorColor: appConstants.neutral1Color,
            controller: category,
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            hintSize: 12.sp,
            focusedBorderColor: appConstants.neutral12Color,
            hintText: TranslationConstants.enter_category_name.translate(context),
            textInputType: TextInputType.name,
          ),
        ),
      ],
    );
  }

  Widget saveButton({required BuildContext context, required VoidCallback onTap, EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      child: CommonWidget.commonButton(
        // height: 50,
        text: TranslationConstants.save.translate(context),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        context: context,
        textColor: appConstants.white,
        onTap: onTap,
        borderRadius: 8.r,
      ),
    );
  }

  Widget categoryTypeSelection() {
    initialCategoryType = selectCategoryModel.category.categoryType;
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: BlocBuilder<CounterCubit, int>(
        bloc: expensesCubit.counterCubit,
        builder: (context, state) {
          return Row(
            children: List.generate(
              availablCategoryType.length,
              (index) {
                return Expanded(
                  child: InkWell(
                    onTap: () {
                      initialCategoryType = availablCategoryType[index];
                      expensesCubit.counterCubit.chanagePageIndex(index: index);
                    },
                    child: CommonWidget.container(
                      //  height: 40,
                      borderRadius: 5,
                      isBorder: true,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: index == 2 ? 0 : 14.w),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      color: initialCategoryType == availablCategoryType[index]
                          ? appConstants.paymentTypeBgColor
                          : appConstants.backgroundColor,
                      borderColor: initialCategoryType == availablCategoryType[index]
                          ? appConstants.editbuttonColor
                          : appConstants.transparent,
                      child: CommonWidget.commonText(
                        text: availablCategoryType[index],
                        fontSize: 11,
                        fontWeight: initialCategoryType == availablCategoryType[index] ? FontWeight.bold : null,
                        color: initialCategoryType == availablCategoryType[index]
                            ? appConstants.editbuttonColor
                            : appConstants.neutral1Color,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

// total Expense and search field
  Widget totalExpensesAndTextField({required BuildContext context}) {
    return CommonWidget.container(
      width: ScreenUtil().screenWidth,
      color: appConstants.drawerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                CommonWidget.commonText(
                  text: "${TranslationConstants.total_expenses.translate(context)}: ",
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
            searchField(context: context)
          ],
        ),
      ),
    );
  }

  Widget searchField({required BuildContext context}) {
    return textField(
      width: ScreenUtil().screenWidth,
      context: context,
      controller: TextEditingController(),
      hight: 18.h,
      isSufix: true,
      onTap: () {},
      onChanged: (v) {},
    );
  }

// Category Item List view
  Widget listOfCategoryItem({required SelectCategoryModel selectCategoryModel}) {
    return Expanded(
      child: ListView.builder(
        itemCount: selectCategoryModel.itemList.length,
        itemBuilder: (cntext, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: itemBox(index: index, selectCategoryModel: selectCategoryModel),
          );
        },
      ),
    );
  }

  Widget itemBox({required int index, required SelectCategoryModel selectCategoryModel}) {
    return GestureDetector(
      onTap: () => CommonRouter.pushNamed(
        RouteList.single_expenses_screen,
        arguments: ExpenseCategoryItemArgs(index: index, selectCategoryModel: selectCategoryModel),
      ),
      child: CommonWidget.container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        color: appConstants.white,
        borderRadius: 10.r,
        shadow: [
          BoxShadow(
            blurRadius: 0.3,
            spreadRadius: 1,
            color: appConstants.shadowColor,
            offset: const Offset(0, 1),
          ),
        ],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 38.w),
              child: CommonWidget.commonText(
                text: "#${index + 1}",
                fontSize: 14,
                color: appConstants.editbuttonColor,
                fontWeight: FontWeight.w600,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            CommonWidget.sizedBox(width: 5),
            itemDetails(selectCategoryModel, index),
            const Spacer(),
            CommonWidget.container(
              width: 140,
              alignment: Alignment.centerRight,
              child: CommonWidget.commonText(
                text: "${selectCategoryModel.itemList[index].date} | ${selectCategoryModel.itemList[index].time}",
                fontSize: 12,
                color: appConstants.lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDetails(SelectCategoryModel selectCategoryModel, int index) {
    return CommonWidget.container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonWidget.commonText(
                textAlign: TextAlign.left,
                text: "${TranslationConstants.amount.translate(context)}:  ",
                fontSize: 14,
                color: appConstants.neutral1Color,
                fontWeight: FontWeight.w700,
              ),
              CommonWidget.container(
                width: 80,
                alignment: Alignment.centerLeft,
                child: CommonWidget.commonText(
                  text: selectCategoryModel.grandTotal.formatCurrency(),
                  fontSize: 14,
                  color: appConstants.editbuttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              CommonWidget.commonText(
                textAlign: TextAlign.left,
                text: "${TranslationConstants.item.translate(context)}: ",
                fontSize: 13,
                color: appConstants.neutral1Color,
                fontWeight: FontWeight.w500,
                bold: true,
              ),
              CommonWidget.sizedBox(
                width: 100,
                child: CommonWidget.commonText(
                  text: List.generate(
                          selectCategoryModel.itemList[index].itemList.length,
                          (i) =>
                              "${selectCategoryModel.itemList[index].itemList[i].itemName} (${selectCategoryModel.itemList[index].itemList[i].itemQty})")
                      .toList()
                      .join(', '),
                  fontSize: 13,
                  color: appConstants.neutral1Color,
                ),
              ),
            ],
          ),
          CommonWidget.sizedBox(height: 5),
          Row(
            children: [
              CommonWidget.commonText(
                text: "${TranslationConstants.balance.translate(context)}: ",
                textAlign: TextAlign.left,
                fontSize: 14,
                color: appConstants.neutral1Color,
                fontWeight: FontWeight.w500,
              ),
              CommonWidget.container(
                width: 80,
                alignment: Alignment.centerLeft,
                child: CommonWidget.commonText(
                  text: double.parse(selectCategoryModel.itemList[index].balance).formatCurrency(),
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

// bottom button
  Widget bottomButton({required BuildContext context}) {
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
            arguments: const AddExpenseScreenArgs(navigateFrom: AddExpenseNavigation.add),
          ),
          child: addExpenseButton(context),
        ),
      ),
    );
  }

  Widget addExpenseButton(BuildContext context) {
    return Container(
      height: 45.h,
      width: newDeviceType == NewDeviceType.phone
          ? 200.w
          : newDeviceType == NewDeviceType.tablet
              ? ScreenUtil().screenWidth / 1.5
              : ScreenUtil().screenWidth / 1.2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: appConstants.theme1Color),
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
    );
  }
}
