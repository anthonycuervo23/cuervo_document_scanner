import 'dart:async';

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/add_expense_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/add_expanses/add_expense_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/bottom_bar/open_bottom_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_image_pick_textfeild.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AddExpensesWidget extends State<AddExpansesScreen> {
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController categorySerchedDataController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController partyNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController editCategoryController = TextEditingController();
  DateTime selectedTime = DateTime.now();
  int? categoryIndex = 0;
  String? selectedCategoryType = availablCategoryType[0];
  List banks = ["Bank Of Baroda", "Canera", "HDFC", "Hindustan Bank"];
  bool isshow = true;

  @override
  void initState() {
    super.initState();
    expensesCubit.loadAddExpenseScreenData(
      navigationFrom: widget.args.navigateFrom,
      itemsData: widget.args.selectCategoryModel?.itemList,
      index: widget.args.itemsDetailsIndex ?? 0,
      payMentType: widget.args.selectCategoryModel?.expansesModel.paymentType,
    );
    loadData(args: widget.args);
    expensesCubit.loaded();
  }

  @override
  void dispose() {
    super.dispose();
    expensesCubit.clearAddScreenData();
  }

// App Bar
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      context,
      dividerColor: appConstants.grey.withOpacity(0.2),
      title: widget.args.navigateFrom == AddExpenseNavigation.edit
          ? TranslationConstants.edit_expense.translate(context)
          : TranslationConstants.add_expense.translate(context),
      titleCenter: false,
      onTap: () => Navigator.pop(context),
      trailing: saveButton(context),
    );
  }

  Widget saveButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: CommonWidget.commonButton(
        context: context,
        height: 33.h,
        width: 80.w,
        alignment: Alignment.center,
        borderRadius: 40.r,
        color: appConstants.theme1Color,
        child: CommonWidget.commonText(
            text: TranslationConstants.save.translate(context),
            fontSize: 16,
            color: appConstants.white,
            fontWeight: FontWeight.w500),
        onTap: () {
          CommonRouter.pop();
          CustomSnackbar.show(
            snackbarType: SnackbarType.SUCCESS,
            message: TranslationConstants.details_saved.translate(context),
          );
        },
      ),
    );
  }

// screen view
  Widget screenView(ExpensesLoadedState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        commanLable(title: "${TranslationConstants.expense.translate(context)} #1"),
        expenseWithGst(state: state),
        CommonWidget.sizedBox(height: 10),
        commonTextFiledExpense(
          controller: invoiceNumberController,
          headinh1: TranslationConstants.expense_invoice_number.translate(context),
          headinh2: "(${TranslationConstants.optional.translate(context)})",
          hint: TranslationConstants.expense_invoice_number_hint.translate(context),
        ),
        Visibility(
          visible: expensesCubit.switchButton,
          child: Column(
            children: [
              commonSizeBox(),
              commonTextFiledExpense(
                controller: partyNameController,
                headinh1: TranslationConstants.expense_party_name.translate(context),
                hint: TranslationConstants.expense_party_name_hint.translate(context),
              ),
            ],
          ),
        ),
        commonSizeBox(),
        expenseCategory(state: state),
        commonSizeBox(),
        categoryTypeAndDate(context, state),
        commonSizeBox(),
        itemDetails(state: state),
        commonSizeBox(),
        paymentType(state: state),
        commonSizeBox(),
        selectBank(state: state),
        commonSizeBox(),
        Container(
          constraints: BoxConstraints(maxHeight: 100.h),
          child: commonTextFiledExpense(
            controller: notesController,
            maxLines: 2,
            headinh1: TranslationConstants.expense_notes.translate(context),
            hint: TranslationConstants.expense_notes_hint.translate(context),
          ),
        ),
        commonSizeBox(),
        addAttachments(),
        Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      ],
    );
  }

// Gst toggle button and Party name
  Widget expenseWithGst({required ExpensesLoadedState state}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: commanLable(title: TranslationConstants.expense_with_GST.translate(context)),
        ),
        CommonWidget.toggleButton(
          value: expensesCubit.switchButton,
          activeTrackColor: appConstants.editbuttonColor,
          onChanged: (value) {
            expensesCubit.changeSwitchButton(state: state);
          },
        ),
      ],
    );
  }

// category type and Date txtField
  Widget categoryTypeAndDate(BuildContext context, ExpensesLoadedState state) {
    return Row(
      children: [
        Expanded(
          child: commonTextFiledExpense(
            controller: state.categoryTypeController,
            headinh1: TranslationConstants.category_type.translate(context),
            hint: TranslationConstants.sub_category.translate(context),
            enable: false,
          ),
        ),
        CommonWidget.sizedBox(width: 15),
        Expanded(
            child: GestureDetector(
          onTap: () async {
            List<DateTime?>? date = await CommonWidget.datePicker(context: context, value: [selectedTime]);
            if (date != null) {
              selectedDateController =
                  TextEditingController(text: "${date[0]!.day}/${date[0]!.month}/${date[0]!.year}");
              selectedTime = date[0] ?? DateTime.now();
              expensesCubit.reloadScreen(state: state);
            }
          },
          child: commonTextFiledExpense(
            headinh1: TranslationConstants.date.translate(context),
            hint: TranslationConstants.expense_date_hint.translate(context),
            controller: selectedDateController,
            //   enable: true,
            suffixIconPath: "assets/photos/svg/common/calender_icon.svg",
          ),
        )),
      ],
    );
  }

// select category
  Widget expenseCategory({required ExpensesLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        commanLable(title: TranslationConstants.expense_category.translate(context)),
        InkWell(
            onTap: () => selectCategoryBottomBar(state: state),
            child: CommonWidget.container(
              height: 50,
              color: appConstants.white,
              borderRadius: 5.r,
              isBorder: true,
              borderColor: appConstants.borderColor2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.commonText(
                      fontSize: 14,
                      text: state.dispalyCategory
                          ? state.selctedCategoryIndex < state.searchedCategory.length
                              ? state.searchedCategory[state.selctedCategoryIndex].categoryName
                              : TranslationConstants.cost_of_goods_sold.translate(context)
                          : TranslationConstants.cost_of_goods_sold.translate(context),
                      color: state.dispalyCategory
                          ? state.selctedCategoryIndex < state.searchedCategory.length
                              ? appConstants.neutral1Color
                              : appConstants.neutral12Color
                          : appConstants.neutral1Color,
                      fontWeight: FontWeight.bold,
                    ),
                    CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/common/down_filled_arrow.svg",
                      color: appConstants.neutral1Color,
                      height: 8.h,
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Future<dynamic> selectCategoryBottomBar({required ExpensesLoadedState state}) {
    return openBottomBar(
      context: context,
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
              child: Row(
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.select_category.translate(context),
                    color: appConstants.theme1Color,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => CommonRouter.pop(),
                    child: Icon(
                      Icons.close_rounded,
                      size: 28.h,
                      color: appConstants.theme1Color,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: appConstants.dividerColor),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
              child: Column(
                children: [
                  CommonWidget.sizedBox(height: 5),
                  CommonWidget.sizedBox(
                    height: 50,
                    width: ScreenUtil().screenWidth,
                    child: textField(
                      controller: categorySerchedDataController,
                      context: context,
                      hight: 18.h,
                      onTap: () {},
                      onChanged: (v) => expensesCubit.searchFromcategory(
                        state: state,
                        searchedData: categorySerchedDataController.text,
                        categoryStatus: false,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        editCategoryController = TextEditingController();
                        CommonRouter.pop();
                        addAndEditCategoryBottomBar(expenseState: state);
                        selectedCategoryType = availablCategoryType[0];
                      },
                      child: addNewCategoryButton(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: appConstants.dividerColor),
            categoryList(),
            CommonWidget.sizedBox(height: 30),
            applyButton(state: state),
            CommonWidget.sizedBox(height: 15),
            editCategoryButton(state: state),
            CommonWidget.sizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget categoryList() {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: CommonWidget.container(
        height: 220,
        child: BlocBuilder<ExpensesCubit, ExpensesState>(
          bloc: expensesCubit,
          builder: (context, state) {
            if (state is ExpensesLoadedState) {
              return state.searchedCategory.isEmpty
                  ? CommonWidget.dataNotFound(context: context, actionButton: const SizedBox.shrink())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.searchedCategory.length,
                      itemBuilder: (context, index) {
                        return commonCheckBox(
                          compareIndex: categoryIndex,
                          index: index,
                          onTap: () {
                            categoryIndex = index;
                            selectedCategoryType = state.searchedCategory[index].categoryType;
                            expensesCubit.reloadScreen(state: state);
                          },
                          widget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.commonText(
                                text: state.searchedCategory[index].categoryName,
                                textAlign: TextAlign.start,
                                fontSize: 14,
                                fontWeight: categoryIndex == index ? FontWeight.bold : null,
                                color: appConstants.neutral1Color,
                              ),
                              CommonWidget.commonText(
                                text: state.searchedCategory[index].categoryType,
                                fontSize: 10,
                                color: appConstants.lightGrey,
                              ),
                            ],
                          ),
                        );
                      },
                    );
            } else if (state is ExpensesLoadingState) {
              return CommonWidget.loadingIos();
            } else if (state is ExpensesErrorState) {
              return Center(child: CommonWidget.commonText(text: state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget applyButton({required ExpensesLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: CommonWidget.commonButton(
        //  height: 50,
        text: TranslationConstants.apply.translate(context),
        alignment: Alignment.center,
        context: context,
        textColor: appConstants.white,
        borderRadius: 8.r,
        padding: EdgeInsets.symmetric(vertical: 13.h),
        onTap: () {
          CommonRouter.pop();
          expensesCubit.changeCategory(
            index: categoryIndex,
            state: state,
            categoryType: state.searchedCategory[categoryIndex ?? 0].categoryType,
          );
        },
      ),
    );
  }

  Future<dynamic> addAndEditCategoryBottomBar({
    required ExpensesLoadedState expenseState,
  }) {
    return openBottomBar(
      context: context,
      backgroundColor: appConstants.white,
      isTitleBar: true,
      title: TranslationConstants.add_category.translate(context),
      titleTextStye: TextStyle(
        color: appConstants.theme1Color,
        fontWeight: FontWeight.w900,
        fontSize: 15.sp,
      ),
      child: BlocBuilder<ExpensesCubit, ExpensesState>(
        bloc: expensesCubit,
        builder: (context, state) {
          if (state is ExpensesLoadedState) {
            return Column(
              children: [
                CommonWidget.sizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      commonTextFiledExpense(
                        hint: TranslationConstants.enter_category_name.translate(context),
                        controller: editCategoryController,
                        headinh1: TranslationConstants.category_name.translate(context),
                      ),
                      CommonWidget.sizedBox(height: 12),
                      CommonWidget.commonText(
                        text: TranslationConstants.category_type.translate(context),
                        fontSize: 14,
                        color: appConstants.neutral1Color,
                        fontWeight: FontWeight.w600,
                      ),
                      categoryTypeSelection(state: state),
                    ],
                  ),
                ),
                commonSaveButton(
                  context: context,
                  onTap: () => CommonRouter.pop(),
                ),
              ],
            );
          } else if (state is ExpensesLoadingState) {
            return CommonWidget.loadingIos();
          } else if (state is ExpensesErrorState) {
            return Center(
              child: CommonWidget.commonText(text: state.errorMessage),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget categoryTypeSelection({required ExpensesLoadedState state}) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          availablCategoryType.length,
          (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  selectedCategoryType = availablCategoryType[index];
                  expensesCubit.reloadScreen(state: state);
                },
                child: CommonWidget.container(
                  height: 35,
                  margin: EdgeInsets.only(right: index == 2 ? 0 : 15.w),
                  color: selectedCategoryType == availablCategoryType[index]
                      ? appConstants.paymentTypeBgColor
                      : appConstants.backgroundColor,
                  borderColor: selectedCategoryType == availablCategoryType[index]
                      ? appConstants.editbuttonColor
                      : Colors.transparent,
                  borderRadius: 5,
                  isBorder: true,
                  alignment: Alignment.center,
                  child: CommonWidget.commonText(
                    text: availablCategoryType[index],
                    fontSize: 11,
                    color: selectedCategoryType == availablCategoryType[index]
                        ? appConstants.editbuttonColor
                        : appConstants.neutral1Color,
                    fontWeight: selectedCategoryType == availablCategoryType[index] ? FontWeight.bold : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget addNewCategoryButton() {
    return CommonWidget.container(
      //height: 50,
      borderColor: appConstants.editbuttonColor,
      borderRadius: 5.r,
      isBorder: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidget.commonText(
              text: TranslationConstants.add_new_category.translate(context),
              color: appConstants.editbuttonColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            CommonWidget.imageBuilder(imageUrl: 'assets/photos/svg/common/add_rounded.svg', height: 18.h)
          ],
        ),
      ),
    );
  }

  Widget editCategoryButton({required ExpensesLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: CommonWidget.commonButton(
        //  height: 50,
        context: context,
        color: appConstants.clearbuttonColor,
        borderRadius: 8.r,
        alignment: Alignment.center,
        text: TranslationConstants.edit_category.translate(context),
        padding: EdgeInsets.symmetric(vertical: 13.h),
        style: TextStyle(color: appConstants.theme1Color, fontSize: 16.sp, fontWeight: FontWeight.bold),
        onTap: () {
          if (categoryIndex != null && selectedCategoryType != null) {
            editCategoryController = TextEditingController(
              text: state.searchedCategory[categoryIndex ?? 0].categoryName,
            );
            CommonRouter.pop();
            addAndEditCategoryBottomBar(expenseState: state);
          } else {
            CommonRouter.pop();
            CustomSnackbar.show(
              snackbarType: SnackbarType.ERROR,
              message: TranslationConstants.select_category_warning.translate(context),
            );
          }
        },
      ),
    );
  }

// Item Details
  Widget itemDetails({required ExpensesLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        commanLable(title: TranslationConstants.item_details.translate(context).replaceAll("s", "")),
        CommonWidget.container(
          padding: EdgeInsets.all(5.h),
          width: ScreenUtil().screenWidth,
          isBorder: true,
          borderRadius: 5.r,
          borderColor: appConstants.neutral12Color,
          child: Column(children: [
            CommonWidget.sizedBox(height: 5),
            itemTitle(),
            itemList(state: state),
            CommonWidget.sizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(right: 15.w, top: 8.h, bottom: 8.h, left: 9.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.total_amount.translate(context),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  CommonWidget.commonText(
                    text: 100.formatCurrency(),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget itemList({required ExpensesLoadedState state}) {
    return Column(
      children: List.generate(
        state.listOfItem.length,
        (index) {
          return Row(
            children: [
              itemDetailsField(
                controller: state.listOfItem[index].itemController,
                state: state,
                index: index,
                width: 119,
                hint: TranslationConstants.item.translate(context),
              ),
              itemDetailsField(
                controller: state.listOfItem[index].qtyController,
                state: state,
                index: index,
                width: 70,
                hint: TranslationConstants.qty.translate(context),
                keyboardType: TextInputType.number,
              ),
              itemDetailsField(
                  controller: state.listOfItem[index].amountController,
                  state: state,
                  index: index,
                  width: 80,
                  hint: TranslationConstants.amount.translate(context),
                  keyboardType: TextInputType.number),
              GestureDetector(
                onTap: () => expensesCubit.addItem(state: state, index: index, context: context),
                child: CommonWidget.imageBuilder(
                  imageUrl: 'assets/photos/svg/common/add_icon.svg',
                  color: appConstants.theme1Color,
                  height: 16.r,
                ),
              ),
              CommonWidget.sizedBox(width: 8.w),
              GestureDetector(
                onTap: () => expensesCubit.removeItem(state: state, index: index),
                child: CommonWidget.imageBuilder(
                  imageUrl: 'assets/photos/svg/common/trash.svg',
                  color: appConstants.theme1Color,
                  height: 16.r,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.container(
          padding: EdgeInsets.only(left: 8.w, right: 5.w),
          alignment: Alignment.bottomLeft,
          width: 100,
          child: CommonWidget.commonText(
            text: TranslationConstants.item.translate(context),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: appConstants.neutral1Color,
          ),
        ),
        CommonWidget.container(
          width: 70,
          padding: EdgeInsets.only(left: 8.w),
          child: CommonWidget.commonText(
            text: TranslationConstants.qty.translate(context),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: appConstants.neutral1Color,
          ),
        ),
        CommonWidget.sizedBox(width: 2),
        CommonWidget.container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 15.w),
          width: 90,
          child: CommonWidget.commonText(
            text: TranslationConstants.amount.translate(context),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: appConstants.neutral1Color,
          ),
        ),
      ],
    );
  }

  Widget itemDetailsField({
    required ExpensesLoadedState state,
    required int index,
    required double width,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return CommonWidget.container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      width: width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: TextField(
              keyboardType: keyboardType,
              cursorColor: appConstants.neutral1Color,
              style: TextStyle(color: appConstants.neutral1Color),
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  color: appConstants.hintTextColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          CommonWidget.commonDashLine(width: width),
        ],
      ),
    );
  }

// paymentType
  Widget paymentType({required ExpensesLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: 5),
        commanLable(title: TranslationConstants.expense_payment_type.translate(context)),
        CommonWidget.sizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            PayMentType.values.length,
            (index) => Expanded(
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () => expensesCubit.changePaymentType(state: state, index: index),
                child: paymentTypeContainer(state, index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget paymentTypeContainer(ExpensesLoadedState state, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: CommonWidget.container(
        height: 33,
        isBorder: true,
        alignment: Alignment.center,
        borderRadius: 5.r,
        borderColor: state.payMentType == PayMentType.values[index] ? appConstants.editbuttonColor : Colors.transparent,
        color: state.payMentType == PayMentType.values[index]
            ? appConstants.paymentTypeBgColor
            : appConstants.backgroundColor,
        child: CommonWidget.commonText(
          text: PayMentType.values[index].name.replaceAll('_', ' '),
          fontSize: 11,
          fontWeight: state.payMentType == PayMentType.values[index] ? FontWeight.w600 : FontWeight.w400,
          color: state.payMentType == PayMentType.values[index]
              ? appConstants.editbuttonColor
              : appConstants.neutral1Color,
        ),
      ),
    );
  }

// Bank Bottom Bar
  Widget selectBank({required ExpensesLoadedState state}) {
    return GestureDetector(
      onTap: () => selectBankBottomBar(state: state),
      child: CommonWidget.container(
        height: 45,
        borderColor: appConstants.editbuttonColor,
        borderRadius: 8.r,
        isBorder: true,
        alignment: Alignment.center,
        child: CommonWidget.commonText(
          text: state.dispalyBankName
              ? banks[state.selectedBankIndex]
              : TranslationConstants.select_bank.translate(context),
          color: appConstants.theme1Color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Future<dynamic> selectBankBottomBar({required ExpensesLoadedState state}) {
    return openBottomBar(
      backgroundColor: appConstants.white,
      isTitleBar: true,
      title: TranslationConstants.select_bank.translate(context),
      titleFontSize: 20.sp,
      dividerColor: appConstants.neutral1Color.withOpacity(0.5),
      dividerThickness: 0.3.h,
      isTitleBold: true,
      context: context,
      child: BlocBuilder<ExpensesCubit, ExpensesState>(
        bloc: expensesCubit,
        builder: (context, state) {
          if (state is ExpensesLoadedState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  CommonWidget.sizedBox(
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.all(8.h),
                      child: selectBankView(state),
                    ),
                  ),
                  addNewBankButton(),
                  CommonWidget.sizedBox(height: 20)
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget selectBankView(ExpensesLoadedState state) {
    return ListView.builder(
      itemCount: banks.length,
      itemBuilder: (context, index) {
        return CommonWidget.sizedBox(
          height: 50,
          child: commonCheckBox(
            compareIndex: state.selectedBankIndex,
            index: index,
            widget: CommonWidget.commonText(
              text: banks[index],
              fontSize: 14,
              fontWeight: (state.selectedBankIndex) == index ? FontWeight.bold : null,
              color: appConstants.neutral1Color,
            ),
            onTap: () {
              CommonRouter.pop();
              expensesCubit.changeBankChekBox(value: true, state: state, index: index, bankStatus: true);
            },
          ),
        );
      },
    );
  }

  Widget addNewBankButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: GestureDetector(
        onTap: () {
          CommonRouter.pop();
          addNewBankBottomBar();
        },
        child: CommonWidget.container(
          borderColor: appConstants.editbuttonColor,
          borderRadius: 5.r,
          isBorder: true,
          alignment: Alignment.center,
          height: 50,
          child: CommonWidget.commonText(
            text: TranslationConstants.add_new_bank.translate(context),
            color: appConstants.theme1Color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Future<dynamic> addNewBankBottomBar() {
    return openBottomBar(
      isTitleBar: true,
      context: context,
      isTitleBold: true,
      titleFontSize: 20.sp,
      title: TranslationConstants.add_bank.translate(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.sizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
              child: commonTextFiledExpense(
                controller: bankNameController,
                headinh1: TranslationConstants.bank_name.translate(context),
                hint: TranslationConstants.enter_bank_name.translate(context),
              ),
            ),
            commonSaveButton(
              context: context,
              onTap: () => CommonRouter.pop(),
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 8.w),
            ),
          ],
        ),
      ),
    );
  }

// Attachments txtField
  Widget addAttachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.expanse_add_attachments.translate(context),
          fontSize: 14,
          color: appConstants.neutral1Color,
          fontWeight: FontWeight.w600,
        ),
        CommonWidget.sizedBox(height: 5),
        CommonImagePickTextFeild(
          isMultipleImagePick: false,
          pickImageCubit: expensesCubit.pickImageCubitCubit,
          borderColor: appConstants.textFiledColor,
          borderRadius: 5.r,
        ),
      ],
    );
  }

// Common usage Widgets
  Widget commonCheckBox({
    required int index,
    required int? compareIndex,
    Widget? widget,
    required VoidCallback onTap,
  }) {
    return BlocBuilder<CounterCubit, int>(
      bloc: expensesCubit.counterCubit,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: SizedBox(
            height: 40.h,
            width: ScreenUtil().screenWidth - 15.w,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                onTap.call();
                expensesCubit.counterCubit.chanagePageIndex(index: index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget ?? const SizedBox.shrink(),
                  CommonWidget.imageBuilder(
                    height: 25.h,
                    imageUrl: compareIndex == index
                        ? "assets/photos/svg/expense_module_images/selected_check_box.svg"
                        : "assets/photos/svg/expense_module_images/dis_selected_check_box.svg",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commanLable({required String title, String? title2}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget.commonText(
                text: title,
                fontSize: 14,
                color: appConstants.neutral1Color,
                fontWeight: FontWeight.w600,
                textOverflow: TextOverflow.ellipsis),
            CommonWidget.commonText(
              text: title2 ?? "",
              fontSize: 14,
              color: appConstants.lightGrey,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        CommonWidget.sizedBox(height: 5),
      ],
    );
  }

  Widget commonSaveButton({required BuildContext context, required VoidCallback onTap, EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      child: CommonWidget.commonButton(
        //   height: 50,
        alignment: Alignment.center,
        context: context,
        textColor: appConstants.white,
        borderRadius: 8.r,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        text: TranslationConstants.save.translate(context),
        onTap: () => onTap,
      ),
    );
  }

  Widget commonTextFiledExpense({
    required String hint,
    required TextEditingController controller,
    required String headinh1,
    bool? enable,
    int? maxLines,
    String? headinh2,
    String? suffixIconPath,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        commanLable(title: headinh1, title2: headinh2),
        CommonWidget.textField(
          textInputType: TextInputType.name,
          cursorColor: appConstants.neutral1Color,
          controller: controller,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          // hintSize: 14.sp,
          minLines: 1,
          borderRadius: 5.r,
          hintStyle: TextStyle(color: appConstants.hintTextColor, fontWeight: FontWeight.w400, fontSize: 14.sp),
          hintText: hint,
          maxLines: maxLines ?? 1,
          hintColor: appConstants.neutral12Color,
          issuffixIcon: false,
          style: TextStyle(color: appConstants.neutral1Color),
          enabled: enable ?? true,
          enabledBorderColor: appConstants.borderColor2,
          focusedBorderColor: appConstants.textFiledColor,
          issuffixWidget: true,
          suffixWidget: suffixIconPath != null
              ? CommonWidget.container(
                  margin: EdgeInsets.all(5.h),
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  child: CommonWidget.imageBuilder(
                    imageUrl: suffixIconPath,
                    height: 23.h,
                  ),
                )
              : null,
        ),
      ],
    );
  }

  Widget commonSizeBox() => CommonWidget.sizedBox(height: 15);

// methods
  void loadData({required AddExpenseScreenArgs args}) {
    if (args.navigateFrom == AddExpenseNavigation.edit) {
      selectedDateController =
          TextEditingController(text: args.selectCategoryModel!.itemList[args.itemsDetailsIndex ?? 0].date);
      notesController = TextEditingController(text: args.selectCategoryModel!.expansesModel.notes);
    }
  }
}
