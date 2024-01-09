// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/add_expense_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/single_expenses/single_expense_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

abstract class ExpensesWidget extends State<SingleExpensesScreen> {
  late SelectCategoryModel selectCategoryModel;
  int itemsDetailsIndex = 0;
  int totalQuantity = 0;
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    selectCategoryModel = widget.args.selectCategoryModel;
    getQuantityAndAmountTotal(itemModel: widget.args.selectCategoryModel.itemList[widget.args.index].itemList);
    expensesCubit.loaded();
  }

  @override
  void dispose() {
    expensesCubit.loadingCubit.hide();
    super.dispose();
  }

// App bar
  PreferredSizeWidget? appBar() {
    return CustomAppBar(
      context,
      titleCenter: false,
      actions: editAndDeleteButton(),
      dividerColor: appConstants.grey.withOpacity(0.2),
      elevation: 1,
      fontSize: 17.sp,
      title: TranslationConstants.expenses.translate(context),
      onTap: () => CommonRouter.pop(),
    );
  }

  List<Widget> editAndDeleteButton() {
    return [
      CommonWidget.textButton(
        text: TranslationConstants.edit.translate(context),
        textColor: appConstants.editbuttonColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        onTap: () => CommonRouter.pushNamed(
          RouteList.add_expanses,
          arguments: AddExpenseScreenArgs(
            navigateFrom: AddExpenseNavigation.edit,
            selectCategoryModel: widget.args.selectCategoryModel,
            itemsDetailsIndex: widget.args.index,
          ),
        ),
      ),
      CommonWidget.sizedBox(width: 12),
      CommonWidget.textButton(
        text: TranslationConstants.delete.translate(context),
        textColor: appConstants.deleteBtnColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        onTap: () => deleteButtonTap(),
      ),
      CommonWidget.sizedBox(width: 15),
    ];
  }

  void deleteButtonTap() {
    return CommonWidget.showAlertDialog(
      isTitle: true,
      maxLines: 2,
      context: context,
      leftColor: appConstants.buttonColor,
      textColor: appConstants.neutral1Color,
      leftButtonText: TranslationConstants.no.translate(context),
      rightButtonText: TranslationConstants.yes.translate(context),
      text: TranslationConstants.delete_expense_warning.translate(context),
      titleText: TranslationConstants.confirm_delete.translate(context),
      titleTextStyle: TextStyle(color: appConstants.theme1Color, fontSize: 18.sp, fontWeight: FontWeight.bold),
      onTap: () => CommonRouter.pop(),
    );
  }

// expenseCategoryAndDate
  Widget expenseCategoryAndDate({required ExpensesLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.expense_category.translate(context),
                  color: appConstants.lightGrey,
                  fontSize: 12,
                ),
                CommonWidget.sizedBox(height: 5),
                CommonWidget.commonText(
                  text: selectCategoryModel.category.categoryName,
                  color: appConstants.neutral1Color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          CommonWidget.sizedBox(width: 28),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.date.translate(context),
                  color: appConstants.lightGrey,
                  fontSize: 12,
                ),
                CommonWidget.sizedBox(height: 5),
                CommonWidget.commonText(
                  text: selectCategoryModel.itemList[widget.args.index].date,
                  color: appConstants.neutral1Color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// itemDetails
  Widget itemDetails({required ExpensesLoadedState state}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: CommonWidget.commonText(
            text: TranslationConstants.item_details.translate(context),
            color: appConstants.neutral1Color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        itemDetailsHeading(),
        CommonWidget.sizedBox(height: 5),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: selectCategoryModel.itemList[widget.args.index].itemList.length,
          itemBuilder: (context, index) {
            return itemBox(
              itemModel: selectCategoryModel.itemList[widget.args.index].itemList[index],
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.sizedBox(
                width: 183,
                child: CommonWidget.commonText(
                  text: TranslationConstants.total.translate(context),
                  textAlign: TextAlign.start,
                  color: appConstants.neutral1Color,
                  fontSize: 12,
                ),
              ),
              CommonWidget.commonText(
                text: totalQuantity.toString(),
                color: appConstants.neutral1Color,
                fontSize: 12,
              ),
              const Spacer(),
              CommonWidget.sizedBox(
                width: 50,
                child: CommonWidget.commonText(
                  textAlign: TextAlign.end,
                  text: totalAmount.formatCurrency(),
                  color: appConstants.neutral1Color,
                  bold: true,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Divider(color: appConstants.dividerColor, height: 2),
        totalAmountView(),
      ],
    );
  }

  Widget totalAmountView() {
    return CommonWidget.container(
      height: 45,
      color: appConstants.titleBgColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidget.sizedBox(
              width: 130,
              child: CommonWidget.commonText(
                textAlign: TextAlign.start,
                text: TranslationConstants.total_amount.translate(context),
                color: appConstants.neutral1Color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: CommonWidget.commonText(
                textAlign: TextAlign.end,
                text: totalAmount.formatCurrency(),
                color: appConstants.neutral1Color,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDetailsHeading() {
    return CommonWidget.container(
      height: 40,
      color: appConstants.titleBgColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: headingText(text: TranslationConstants.item_name.translate(context))),
            headingText(text: TranslationConstants.qty.translate(context)),
            CommonWidget.sizedBox(width: 32),
            headingText(text: TranslationConstants.rate.translate(context)),
            CommonWidget.sizedBox(width: 28),
            headingText(text: TranslationConstants.amount.translate(context)),
          ],
        ),
      ),
    );
  }

  Widget headingText({required String text}) {
    return CommonWidget.commonText(
      textAlign: TextAlign.start,
      text: text,
      color: appConstants.neutral1Color,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
  }

  Widget itemBox({required ItemModel itemModel}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.container(
                width: 183,
                child: itemBoxText(
                  itemModel: itemModel,
                  textAlign: TextAlign.start,
                  text: itemModel.itemName,
                  bold: false,
                ),
              ),
              CommonWidget.container(
                width: 30,
                alignment: Alignment.centerLeft,
                child: itemBoxText(
                  itemModel: itemModel,
                  text: itemModel.itemQty,
                  bold: false,
                ),
              ),
              Expanded(
                child: CommonWidget.container(
                  alignment: Alignment.center,
                  child: itemBoxText(itemModel: itemModel, text: int.parse(itemModel.itemRate).formatCurrency()),
                ),
              ),
              Expanded(
                child: CommonWidget.container(
                  alignment: Alignment.centerRight,
                  child: itemBoxText(
                    itemModel: itemModel,
                    text: (double.parse(itemModel.itemQty) * double.parse(itemModel.itemRate)).formatCurrency(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(color: appConstants.dividerColor, height: 2),
      ],
    );
  }

  Widget itemBoxText({
    required ItemModel itemModel,
    required String text,
    bool? bold,
    TextAlign? textAlign,
  }) {
    return CommonWidget.commonText(
      text: text,
      textAlign: textAlign,
      color: appConstants.neutral1Color,
      fontSize: 12,
      bold: bold ?? true,
      fontWeight: FontWeight.bold,
    );
  }

// Payment Mode
  Widget paymentMode({required ExpensesLoadedState state}) {
    return otherInfoView(
      title: TranslationConstants.paymet_mode.translate(context),
      data: selectCategoryModel.expansesModel.paymentType.name.replaceAll("_", " "),
    );
  }

// Comments and Notes
  Widget noteComments({required ExpensesLoadedState state}) {
    return otherInfoView(
      title: TranslationConstants.note_comments.translate(context),
      data: selectCategoryModel.expansesModel.notes,
    );
  }

  // attach file
  Widget attachedFile({required ExpensesLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.attched_file.translate(context),
            color: appConstants.neutral1Color,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          CommonWidget.sizedBox(height: 10),
          Row(
            children: [
              CommonWidget.container(
                  height: 85,
                  width: 80,
                  color: appConstants.titleBgColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                    child: CommonWidget.cachedNetworkImage(
                      borderRadius: const BorderRadius.all(Radius.zero),
                      imagePath: selectCategoryModel.expansesModel.imagePath,
                      fit: BoxFit.fill,
                    ),
                  )),
              CommonWidget.sizedBox(width: 14),
              Column(
                children: [
                  attachFileButton(
                    imagePath: 'assets/photos/svg/common/download.svg',
                    onTap: () => downloadAndShareImage(),
                  ),
                  CommonWidget.sizedBox(height: 10),
                  attachFileButton(
                    imagePath: 'assets/photos/svg/common/share.svg',
                    onTap: () => downloadAndShareImage(shareImage: true),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget attachFileButton({
    required String imagePath,
    required VoidCallback onTap,
    required,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: appConstants.buttonBgColor,
        radius: 14.r,
        child: CommonWidget.imageBuilder(
          imageUrl: imagePath,
          height: 14.r,
          color: appConstants.theme1Color,
        ),
      ),
    );
  }

// Bottom Bar
  Widget bottomBarButton({required ExpensesLoadedState state}) {
    return Row(
      children: [
        bottoBarButon(
          buttonname: TranslationConstants.delete.translate(context),
          buttonColor: appConstants.clearbuttonColor,
          textColor: appConstants.theme1Color,
          onTap: () {
            deleteButtonTap();
          },
        ),
        bottoBarButon(
          buttonname: TranslationConstants.edit.translate(context),
          buttonColor: appConstants.theme1Color,
          textColor: appConstants.white,
          onTap: () {
            CommonRouter.pushNamed(
              RouteList.add_expanses,
              arguments: AddExpenseScreenArgs(
                navigateFrom: AddExpenseNavigation.edit,
                selectCategoryModel: widget.args.selectCategoryModel,
                itemsDetailsIndex: widget.args.index,
              ),
            );
            expensesCubit.expensesEdit(state: state, selectCategoryModel: selectCategoryModel);
          },
        ),
      ],
    );
  }

  Widget bottoBarButon({
    required String buttonname,
    required VoidCallback onTap,
    required Color buttonColor,
    required Color textColor,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
        child: CommonWidget.commonButton(
          height: 45,
          text: buttonname,
          alignment: Alignment.center,
          context: context,
          textColor: textColor,
          onTap: onTap,
          borderRadius: 8.r,
          color: buttonColor,
        ),
      ),
    );
  }

//Common
  Padding otherInfoView({required String title, required String data}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonWidget.commonText(
            textAlign: TextAlign.start,
            text: title,
            color: appConstants.neutral1Color,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          CommonWidget.sizedBox(
            width: 150,
            child: CommonWidget.commonText(
              textAlign: TextAlign.end,
              text: data,
              color: appConstants.neutral1Color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

// Methods
  Future<void> downloadAndShareImage({bool shareImage = false}) async {
    try {
      final http.Response response = await http.get(Uri.parse(selectCategoryModel.expansesModel.imagePath));
      final tempDir = await getTemporaryDirectory();
      var tempPath = shareImage ? '${tempDir.path}/image.png' : tempDir.path;
      final file = shareImage ? File(tempPath) : File('$tempPath.jpeg');
      await file.writeAsBytes(response.bodyBytes);
      if (shareImage) {
        await Future.delayed(const Duration(microseconds: 200));
        await Share.shareXFiles([XFile(file.path)], text: 'Share');
      } else {
        CustomSnackbar.show(snackbarType: SnackbarType.SUCCESS, message: "Download");
      }
    } catch (e) {
      shareImage
          ? CustomSnackbar.show(snackbarType: SnackbarType.PROCESSING, message: "Plese wait")
          : CustomSnackbar.show(snackbarType: SnackbarType.SUCCESS, message: e.toString());
    }
  }

  void getQuantityAndAmountTotal({required List<ItemModel> itemModel}) {
    int a = 0;
    int quantityAns = 0;

    for (var value in itemModel) {
      a = int.parse(value.itemQty);
      quantityAns = a + quantityAns;
    }
    totalQuantity = quantityAns;

    int b = 0;
    int amountAns = 0;
    for (var value in itemModel) {
      b = int.parse(value.itemQty) * int.parse(value.itemRate);
      amountAns = amountAns + b;
    }
    totalAmount = amountAns;
  }
}
