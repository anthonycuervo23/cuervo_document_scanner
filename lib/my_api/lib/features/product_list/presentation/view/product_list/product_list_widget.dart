import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/data/models/product_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_list/product_list_state.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/product_list/product_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ProductListWidget extends State<ProductListScreen> {
  late ProductListCubit productListCubit;
  dynamic selectedGroupValue;
  String? selectedValue;

  @override
  void initState() {
    productListCubit = getItInstance<ProductListCubit>();
    super.initState();
  }

  @override
  void dispose() {
    productListCubit.close();
    super.dispose();
  }

  Widget productListCard({
    required ProductListModel productListModel,
    required int index,
    required ProductListLodedState toggleState,
  }) {
    return Card(
      elevation: 3,
      color: appConstants.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      shadowColor: appConstants.buttonColor.withOpacity(0.3),
      child: CommonWidget.container(
        borderRadius: 10.r,
        color: appConstants.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      CommonRouter.pushNamed(
                        RouteList.product_detail_screen,
                        arguments: productListModel,
                      );
                    },
                    child: CommonWidget.imageBuilder(
                      imageUrl: productListModel.image,
                      height: 40.w,
                      width: 40.w,
                      borderRadius: 5.r,
                    ),
                  ),
                  BlocBuilder<ProductListCubit, ProductListState>(
                    bloc: productListCubit,
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(top: 1.h, bottom: 4.h),
                        child: BlocBuilder<ToggleCubit, bool>(
                          bloc: productListCubit.productToggle,
                          builder: (context, state) {
                            return CommonWidget.toggleButton(
                              value: productListModel.isActive,
                              onChanged: (bool value1) {
                                productListCubit.updateProductActiveStatus(
                                  productListModel: productListModel,
                                  isActive: value1,
                                  state: toggleState,
                                );
                                productListCubit.productToggle.setValue(value: value1);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  CommonWidget.commonText(
                    text: TranslationConstants.app_live.translate(context),
                    style: TextStyle(color: appConstants.appliveColor, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: CommonWidget.commonText(
                            text: "#${index + 1}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: appConstants.editbuttonColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: CommonWidget.commonText(
                            text: productListModel.itemName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: appConstants.neutral1Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: GestureDetector(
                            onTap: () => CommonRouter.pushNamed(RouteList.add_product_screen),
                            child: CommonWidget.imageBuilder(
                              height: 15.h,
                              width: 15.w,
                              imageUrl: "assets/photos/svg/customer/edit.svg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(
                              noButtonColor: appConstants.theme7Color,
                              context: context,
                              isTitle: true,
                              titleTextStyle: Theme.of(context).textTheme.subTitle3BoldHeading.copyWith(
                                    color: appConstants.themeColor,
                                  ),
                              contentTextStyle: Theme.of(context).textTheme.body2LightHeading.copyWith(
                                    color: appConstants.textColor,
                                  ),
                              width: 200.w,
                              maxLine: 2,
                              onTap: () {},
                              titleText: TranslationConstants.confirm_delete.translate(context),
                              text: TranslationConstants.sure_delete_product.translate(context),
                            );
                          },
                          child: CommonWidget.imageBuilder(
                            height: 15.h,
                            width: 15.w,
                            imageUrl: "assets/photos/svg/customer/delete.svg",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CommonWidget.imageBuilder(
                            imageUrl: "assets/photos/svg/common/star_icon.svg",
                            height: 10.h,
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: CommonWidget.commonText(
                              text: productListModel.rating.toString(),
                              style: TextStyle(fontSize: 9.sp, color: appConstants.black, fontWeight: FontWeight.w400),
                            ),
                          ),
                          CommonWidget.container(
                            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 1.h),
                            borderRadius: 15.r,
                            color: appConstants.hotfavouritColor,
                            child: CommonWidget.commonText(
                              text: TranslationConstants.hotfavourite.translate(context),
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w500,
                                color: appConstants.editbuttonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonWidget.commonText(
                          text: TranslationConstants.selling_status.translate(context),
                          style: TextStyle(fontSize: 9.sp, color: appConstants.black, fontWeight: FontWeight.w400),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: CommonWidget.commonText(
                              text: productListModel.sellingStatus.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 9.sp, fontWeight: FontWeight.w500, color: appConstants.editbuttonColor),
                            ),
                          ),
                        ),
                        CommonWidget.commonText(
                          text: "${TranslationConstants.variant.translate(context)}:",
                          style: TextStyle(fontSize: 9.sp, color: appConstants.black, fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: CommonWidget.container(
                            height: 25,
                            borderRadius: 3.r,
                            color: appConstants.dropdownColor,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                                  child: CommonWidget.commonText(
                                    text: '500 gm',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ),
                                items: _addDividersAfterItems(items),
                                value: toggleState.selectedVariantValue,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    productListCubit.updateSelectedVariantValue(state: toggleState, value: value);
                                  }
                                },
                                buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero, width: 85.w),
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
                                  elevation: 2,
                                  padding: EdgeInsets.zero,
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                  padding: EdgeInsets.zero,
                                  customHeights: _getCustomItemsHeights(),
                                ),
                                iconStyleData: const IconStyleData(openMenuIcon: Icon(Icons.arrow_drop_up)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: CommonWidget.sizedBox(
                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonWidget.commonText(
                              text: "${TranslationConstants.self_point.translate(context)}:",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: appConstants.appliveColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.w, right: 15.w),
                              child: CommonWidget.commonText(
                                text: productListModel.selfPoint.toString(),
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                  color: appConstants.selfpointColor,
                                ),
                              ),
                            ),
                            CommonWidget.commonText(
                              text: "${TranslationConstants.referral_point.translate(context)}:",
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: appConstants.appliveColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.w),
                              child: GestureDetector(
                                onTap: () {
                                  referralPointDialog(context: context);
                                },
                                child: CommonWidget.commonText(
                                  text: productListModel.referralPoint.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w600,
                                      color: appConstants.referralCodeColor,
                                      decorationThickness: 1,
                                      decorationStyle: TextDecorationStyle.solid,
                                      decoration: index == 0 ? TextDecoration.underline : null),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CommonWidget.commonText(
                                  text: productListModel.itemCount.toString(),
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    color: appConstants.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: CommonWidget.commonDashLine(),
                    ),
                    BlocBuilder<ProductListCubit, ProductListState>(
                      bloc: productListCubit,
                      builder: (context, state) {
                        if (state is ProductListLodedState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonWidget.commonText(
                                      text: TranslationConstants.price.translate(context),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: appConstants.appliveColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    CommonWidget.commonText(
                                      text: productListModel.price.toString(),
                                      style: TextStyle(
                                          fontSize: 10.sp, color: appConstants.black, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonWidget.commonText(
                                      text: TranslationConstants.discount.translate(context),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: appConstants.appliveColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    CommonWidget.commonText(
                                      text: productListModel.discount,
                                      style: TextStyle(
                                          fontSize: 10.sp, color: appConstants.black, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonWidget.commonText(
                                      text: TranslationConstants.selling_price.translate(context),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: appConstants.appliveColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    CommonWidget.commonText(
                                      text: productListModel.sellingPrice.toString(),
                                      style: TextStyle(
                                          fontSize: 10.sp, color: appConstants.black, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  referralPointDialog({required BuildContext context}) {
    showDialog(
        context: context,
        barrierColor: appConstants.barriarColor,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
            surfaceTintColor: appConstants.white,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonWidget.commonText(
                        text: TranslationConstants.referral_points.translate(context),
                        style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w800, fontSize: 13.sp),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          CommonRouter.pop();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 25.r,
                          color: appConstants.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w, bottom: 10.h),
                    child: buildTable(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  filterDialog({required BuildContext context}) {
    showDialog(
        context: context,
        barrierColor: appConstants.barriarColor,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
            surfaceTintColor: appConstants.white,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.commonText(
                        text: TranslationConstants.sort_filter.translate(context),
                        style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w800, fontSize: 14.sp),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          CommonRouter.pop();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 25.r,
                          color: appConstants.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 5.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            categoryBrandSelection.length,
                            (index) => categoriBreandSellingAction(index: index),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 18.h, left: 15.w, right: 15.w, top: 10.h),
                        child: CommonWidget.sizedBox(
                          height: 250,
                          child: VerticalDivider(
                            color: appConstants.black,
                            thickness: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: BlocBuilder<ProductListCubit, ProductListState>(
                            bloc: productListCubit,
                            builder: (context, state) {
                              if (state is ProductListLodedState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    radioButton(
                                      context: context,
                                      label: TranslationConstants.cakes.translate(context),
                                      groupValue: productListCubit.selectedGroupValue,
                                      radioButtonValue: 1,
                                      onChanged: (value) {
                                        productListCubit.updateSelectedGroupValue(state: state, value: value);
                                      },
                                    ),
                                    radioButton(
                                      context: context,
                                      label: TranslationConstants.new_arrival.translate(context),
                                      groupValue: productListCubit.selectedGroupValue,
                                      radioButtonValue: 2,
                                      onChanged: (value) {
                                        productListCubit.updateSelectedGroupValue(state: state, value: value);
                                      },
                                    ),
                                    radioButton(
                                      context: context,
                                      label: TranslationConstants.pastries.translate(context),
                                      groupValue: productListCubit.selectedGroupValue,
                                      radioButtonValue: 3,
                                      onChanged: (value) {
                                        productListCubit.updateSelectedGroupValue(state: state, value: value);
                                      },
                                    ),
                                    radioButton(
                                      context: context,
                                      label: TranslationConstants.cookies.translate(context),
                                      groupValue: productListCubit.selectedGroupValue,
                                      radioButtonValue: 4,
                                      onChanged: (value) {
                                        productListCubit.updateSelectedGroupValue(state: state, value: value);
                                      },
                                    ),
                                    radioButton(
                                      context: context,
                                      label: TranslationConstants.muffins.translate(context),
                                      groupValue: productListCubit.selectedGroupValue,
                                      radioButtonValue: 5,
                                      onChanged: (value) {
                                        productListCubit.updateSelectedGroupValue(state: state, value: value);
                                      },
                                    ),
                                    radioButton(
                                      context: context,
                                      label: TranslationConstants.doughnuts.translate(context),
                                      groupValue: productListCubit.selectedGroupValue,
                                      radioButtonValue: 6,
                                      onChanged: (value) {
                                        productListCubit.updateSelectedGroupValue(state: state, value: value);
                                      },
                                    ),
                                  ],
                                );
                              } else if (state is ProductListLodingState) {
                                return CommonWidget.loadingIos();
                              } else if (state is ProductListErrorState) {
                                return CustomSnackbar.show(
                                    snackbarType: SnackbarType.ERROR, message: state.errorMessage);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CommonWidget.commonDashLine(width: ScreenUtil().screenWidth),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                  child: Wrap(
                    children: List.generate(
                      sortFiltering.length,
                      (currentIndex) => sortFiler(index: currentIndex),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h, top: 30.h),
                  child: clearApplyActions(),
                ),
              ],
            ),
          );
        });
  }

  Widget radioButton({
    required BuildContext context,
    required String label,
    required dynamic groupValue,
    required dynamic radioButtonValue,
    required void Function(dynamic) onChanged,
  }) {
    return CommonWidget.sizedBox(
      height: 43,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidget.commonText(
            text: label,
            style: radioButtonValue == groupValue
                ? TextStyle(color: appConstants.editbuttonColor, fontWeight: FontWeight.w600, fontSize: 14.sp)
                : TextStyle(color: appConstants.black, fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
          Radio(
              activeColor: appConstants.editbuttonColor,
              fillColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return appConstants.editbuttonColor;
                  } else {
                    return appConstants.appliveColor.withOpacity(0.2);
                  }
                },
              ),
              value: radioButtonValue,
              groupValue: groupValue,
              onChanged: onChanged),
        ],
      ),
    );
  }

  Widget categoriBreandSellingAction({required int index}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: BlocBuilder<ProductListCubit, ProductListState>(
        bloc: productListCubit,
        builder: (context, state) {
          if (state is ProductListLodedState) {
            return GestureDetector(
              onTap: () {
                productListCubit.categoriesBrandSelling(index: index, state: state);
              },
              child: CommonWidget.commonText(
                text: categoryBrandSelection[index],
                style: state.isCatagorySelect == true && state.catagoryIndex == index
                    ? TextStyle(fontWeight: FontWeight.w700, color: appConstants.editbuttonColor, fontSize: 14.sp)
                    : TextStyle(fontWeight: FontWeight.w700, color: appConstants.black, fontSize: 14.sp),
              ),
            );
          } else if (state is ProductListLodingState) {
            return CommonWidget.loadingIos();
          } else if (state is ProductListErrorState) {
            return CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: state.errorMessage);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget sortFiler({required int index}) {
    return Padding(
      padding: EdgeInsets.only(top: 11.h, right: 10.w),
      child: BlocBuilder<ProductListCubit, ProductListState>(
        bloc: productListCubit,
        builder: (context, state) {
          if (state is ProductListLodedState) {
            final isSelect = state.isSortFilterSelect == true && state.sortFilterIndex == index;
            return GestureDetector(
              onTap: () {
                productListCubit.sortFiter(index: index, state: state);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(
                    color: isSelect ? appConstants.editbuttonColor.withOpacity(0.4) : appConstants.transparent,
                  ),
                  color: isSelect ? appConstants.white : appConstants.unselectborderColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonText(
                      text: sortFiltering[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isSelect ? appConstants.editbuttonColor : appConstants.neutral1Color,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Visibility(
                        visible: isSelect,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: CommonWidget.imageButton(
                            svgPicturePath: "assets/photos/svg/common/close_icon.svg",
                            color: appConstants.editbuttonColor,
                            iconSize: 17.sp,
                            onTap: () {
                              productListCubit.sortFiter(index: -1, state: state);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductListLodingState) {
            return CommonWidget.loadingIos();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget addNewButton() {
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
          onTap: () => CommonRouter.pushNamed(RouteList.add_product_screen),
          child: CommonWidget.container(
            height: 40,
            width: newDeviceType == NewDeviceType.phone
                ? 200.w
                : newDeviceType == NewDeviceType.tablet
                    ? ScreenUtil().screenWidth / 1.5
                    : ScreenUtil().screenWidth / 1.2,
            borderRadius: 10.r,
            color: appConstants.buttonColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/customer/add_new.svg",
                  height: 20.h,
                ),
                CommonWidget.sizedBox(width: 10),
                CommonWidget.commonText(
                  text: TranslationConstants.add_new.translate(context),
                  style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clearApplyActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonButton(
          color: appConstants.clearbuttonColor,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 56.w),
          text: TranslationConstants.clear.translate(context),
          alignment: Alignment.center,
          style: TextStyle(fontSize: 13.sp, color: appConstants.buttonColor, fontWeight: FontWeight.w600),
          onTap: () {
            CommonRouter.pop();
          },
          context: context,
        ),
        CommonWidget.commonButton(
          color: appConstants.buttonColor,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 56.w),
          text: TranslationConstants.apply.translate(context),
          alignment: Alignment.center,
          style: TextStyle(fontSize: 13.sp, color: appConstants.white, fontWeight: FontWeight.w600),
          onTap: () {
            CommonRouter.pop();
          },
          context: context,
        ),
      ],
    );
  }

  Widget buildTable() {
    return FittedBox(
      alignment: Alignment.center,
      child: DataTable(
        headingTextStyle: TextStyle(color: appConstants.white),
        headingRowColor: MaterialStatePropertyAll(appConstants.theme1Color),
        dataRowColor: MaterialStatePropertyAll(appConstants.white),
        columnSpacing: 0,
        horizontalMargin: 0,
        clipBehavior: Clip.antiAlias,
        border: TableBorder(borderRadius: BorderRadius.circular(10.r)),
        headingRowHeight: 50.h,
        dataRowMaxHeight: 50.h,
        columns: [
          DataColumn(
            label: containtBox(
              borderColor: appConstants.datacolumColor,
              text: "#",
              boxColor: appConstants.theme1Color,
              width: 50.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: appConstants.datacolumColor,
              text: "Level",
              boxColor: appConstants.theme1Color,
              width: 200.w,
              textColor: appConstants.white,
            ),
          ),
          DataColumn(
            label: containtBox(
              borderColor: appConstants.datacolumColor,
              text: "Point",
              boxColor: appConstants.theme1Color,
              width: 100.w,
              textColor: appConstants.white,
            ),
          ),
        ],
        rows: referPointModel
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    containtBox(
                      borderColor: appConstants.datacelColor,
                      text: e.count,
                      boxColor: appConstants.white,
                      width: 50.w,
                      textColor: appConstants.black,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: appConstants.datacelColor,
                      text: e.levels,
                      boxColor: appConstants.white,
                      width: 200.w,
                      textColor: appConstants.black,
                    ),
                  ),
                  DataCell(
                    containtBox(
                      borderColor: appConstants.datacelColor,
                      text: e.point.toString(),
                      boxColor: appConstants.white,
                      width: 100.w,
                      textColor: appConstants.black,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget containtBox({
    required Color boxColor,
    required String text,
    required Color borderColor,
    required double width,
    required Color textColor,
    List<ReferPointModel>? list,
    bool isOpenDialog = false,
    double? padding,
  }) {
    return InkWell(
      onTap: () {},
      child: CommonWidget.container(
        width: width,
        isBorder: true,
        padding: EdgeInsets.only(left: padding ?? 0),
        borderColor: borderColor,
        borderWidth: 1,
        isBorderOnlySide: true,
        color: boxColor,
        alignment: padding == null ? Alignment.center : Alignment.centerLeft,
        child: CommonWidget.commonText(
          color: textColor,
          fontSize: 15.sp,
          textAlign: TextAlign.center,
          text: text,
          maxLines: 2,
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                item,
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ),
          if (item != items.last)
            DropdownMenuItem<String>(
              enabled: false,
              child: Divider(color: appConstants.grey.withOpacity(0.5)),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(30);
      }
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }
}
