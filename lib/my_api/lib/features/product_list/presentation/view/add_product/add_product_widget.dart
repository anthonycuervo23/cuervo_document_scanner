import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/data/models/choose_attribute_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/add_new_product/add_product_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/add_new_product/add_product_state.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/add_product/add_product_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/bottom_bar/open_bottom_bar.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_image_pick_textfeild.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/drop_down.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AddProductWidget extends State<AddProductScreen> {
  late AddNewProductCubit addNewCategoryCubit;
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    addNewCategoryCubit = getItInstance<AddNewProductCubit>();
    super.initState();
  }

  @override
  void dispose() {
    addNewCategoryCubit.close();
    super.dispose();
  }

// Category Barnd Details:

  Widget productTextFields({
    required String title,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 7.h),
          child: CommonWidget.commonText(
            text: title,
            style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: CommonWidget.container(
            height: 50,
            width: double.infinity,
            borderRadius: 8.r,
            isBorder: true,
            padding: EdgeInsets.only(left: 10.w),
            borderColor: appConstants.buttonColor.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: hintText,
                  style: TextStyle(color: appConstants.hintTextColor, fontSize: 13.sp),
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 40.r,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget selectItem({
    required int index,
    required int selectedIndex,
    required String itemText,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: CommonWidget.commonText(
              text: itemText,
              style: TextStyle(
                color: appConstants.black,
                fontWeight: selectedIndex == index ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
          selectedIndex == index
              ? CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/common/round_sclected_arrow.svg",
                  color: appConstants.editbuttonColor,
                  height: 18.r,
                  fit: BoxFit.contain,
                )
              : CommonWidget.container(
                  height: 20,
                  width: 18,
                  borderRadius: 10.r,
                  isBorder: true,
                  color: appConstants.transparent,
                  borderColor: appConstants.dividerColor.withOpacity(0.9),
                ),
        ],
      ),
    );
  }

  selectCategoryAndBrandBottomSheet({
    required String title,
    required List<String> itemList,
    required Function(int) onTap,
    required Function() onAddNewItem,
    required AddNewProductCubit cubit,
    required bool isBrand,
  }) {
    return openBottomBar(
      heightFactor: 0.80.h,
      backgroundColor: appConstants.white,
      context: context,
      child: Container(
        color: appConstants.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.commonText(
                    text: title,
                    style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w800, fontSize: 13.sp),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => CommonRouter.pop(),
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
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: CommonWidget.sizedBox(
                height: 50,
                child: CommonWidget.textField(
                  fillColor: appConstants.transparent,
                  textInputType: TextInputType.multiline,
                  maxLines: 1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: appConstants.orderScreenSearchFieldBorderColor,
                    ),
                  ),
                  borderColor: appConstants.orderScreenSearchFieldBorderColor,
                  enabledBorderColor: appConstants.orderScreenSearchFieldBorderColor,
                  focusedBorderColor: appConstants.orderScreenSearchFieldBorderColor,
                  disabledBorderColor: appConstants.orderScreenSearchFieldBorderColor,
                  isfocusedBorderColor: true,
                  cursorColor: appConstants.editbuttonColor,
                  isPrefixIcon: true,
                  isPrefixWidget: true,
                  focusNode: searchFocusNode,
                  prefixWidget: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/customer/search.svg",
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                  hintText: isBrand
                      ? TranslationConstants.search_brand.translate(context)
                      : TranslationConstants.search_category.translate(context),
                  hintStyle: TextStyle(color: appConstants.hintTextColor),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              child: GestureDetector(
                onTap: () {
                  CommonRouter.pop();
                  onAddNewItem();
                },
                child: CommonWidget.container(
                  borderRadius: 8.r,
                  isBorder: true,
                  borderColor: appConstants.editbuttonColor,
                  color: appConstants.transparent,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidget.commonText(
                        text: isBrand
                            ? TranslationConstants.add_new_brand.translate(context)
                            : TranslationConstants.add_new_category.translate(context),
                        style: TextStyle(color: appConstants.editbuttonColor),
                      ),
                      CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/add_product/add_category.svg",
                        height: 20.r,
                        width: 20.r,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Divider(color: appConstants.dividerColor),
            ),
            Expanded(
              child: BlocBuilder<AddNewProductCubit, AddNewProductState>(
                bloc: addNewCategoryCubit,
                builder: (context, state) {
                  if (state is AddNewProductLoadedState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: ListView.builder(
                        itemCount: itemList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return isBrand
                              ? selectBrand(
                                  index: index,
                                  brand: itemList[index],
                                  selectedIndex: state.selectedBrandIndex ?? 0,
                                  onTap: () {
                                    cubit.changeBrand(index: index, brand: itemList[index], state: state);
                                  },
                                )
                              : selectCategory(
                                  index: index,
                                  category: itemList[index],
                                  selectedIndex: state.selectedCategoryIndex ?? 0,
                                  onTap: () {
                                    cubit.changeCategory(index: index, category: itemList[index], state: state);
                                  },
                                );
                        },
                      ),
                    );
                  } else if (state is AddNewProductLoadingState) {
                    return CommonWidget.loadingIos();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Visibility(
              visible: !searchFocusNode.hasPrimaryFocus,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: CommonWidget.container(
                    color: appConstants.buttonColor,
                    padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
                    borderRadius: 10.r,
                    child: Center(
                      child: CommonWidget.commonText(
                        text: TranslationConstants.submit.translate(context),
                        style: TextStyle(fontSize: 15.sp, color: appConstants.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectCategoryBottomSheet({required AddNewProductLoadedState state}) {
    selectCategoryAndBrandBottomSheet(
      title: TranslationConstants.select_category.translate(context),
      itemList: selectedCategoryList,
      onTap: (index) {
        addNewCategoryCubit.changeCategory(index: index, category: selectedCategoryList[index], state: state);
      },
      onAddNewItem: () {
        addNewCategoryBottomSheet();
      },
      cubit: addNewCategoryCubit,
      isBrand: false,
    );
  }

  void selectBrandBottomSheet({required AddNewProductLoadedState state}) {
    selectCategoryAndBrandBottomSheet(
      title: TranslationConstants.select_brand.translate(context),
      itemList: selectedBrandList,
      onTap: (index) {
        addNewCategoryCubit.changeBrand(index: index, brand: selectedBrandList[index], state: state);
      },
      onAddNewItem: () {
        addNewBrandBottomSheet();
      },
      cubit: addNewCategoryCubit,
      isBrand: true,
    );
  }

  Future<dynamic> addBrandAndCategoryBottomSheet({
    required String title,
    required String hintText,
  }) {
    TextEditingController textController = TextEditingController();

    return openBottomBar(
      context: context,
      heightFactor: 0.26.h,
      backgroundColor: appConstants.white,
      child: Container(
        color: appConstants.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonWidget.commonText(
                      text: title,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w800, fontSize: 13.sp),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => CommonRouter.pop(),
                    child: Icon(
                      Icons.close_rounded,
                      size: 25.r,
                      color: appConstants.buttonColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: appConstants.dividerColor),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 15.h),
                  child: CommonWidget.sizedBox(
                    height: 45,
                    child: CommonWidget.textField(
                      controller: textController,
                      fillColor: appConstants.transparent,
                      cursorColor: appConstants.editbuttonColor,
                      textInputType: TextInputType.multiline,
                      hintText: hintText,
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        color: appConstants.hintTextColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      focusedBorderColor: appConstants.editbuttonColor,
                      disabledBorderColor: appConstants.buttonColor.withOpacity(0.5),
                      isfocusedBorderColor: true,
                      borderColor: appConstants.buttonColor.withOpacity(0.5),
                      enabledBorderColor: appConstants.buttonColor.withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        CommonRouter.pop();
                      },
                      child: CommonWidget.container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        borderRadius: 10.r,
                        color: appConstants.buttonColor,
                        child: Center(
                          child: CommonWidget.commonText(
                            text: TranslationConstants.create.translate(context),
                            style: TextStyle(fontSize: 15.sp, color: appConstants.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addNewBrandBottomSheet() {
    addBrandAndCategoryBottomSheet(
      title: TranslationConstants.add_brand.translate(context),
      hintText: TranslationConstants.enter_brand.translate(context),
    );
  }

  addNewCategoryBottomSheet() {
    addBrandAndCategoryBottomSheet(
      title: TranslationConstants.add_category.translate(context),
      hintText: TranslationConstants.enter_category.translate(context),
    );
  }

  Widget selectCategory({
    required int index,
    required int selectedIndex,
    required String category,
    required VoidCallback onTap,
  }) {
    return selectItem(index: index, selectedIndex: selectedIndex, itemText: category, onTap: onTap);
  }

  Widget selectBrand({
    required int index,
    required int selectedIndex,
    required String brand,
    required VoidCallback onTap,
  }) {
    return selectItem(index: index, selectedIndex: selectedIndex, itemText: brand, onTap: onTap);
  }

// Product Attributes:

  Widget productAttribute({required AddNewProductLoadedState state}) {
    return CustomDropdownButton(
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w),
      useTextField: true,
      titleTextAlignment: Alignment.centerLeft,
      selectedOptions: "Weight",
      dataList: const [
        "Weight",
        "Liter",
        "Packs",
      ],
      size: 40.r,
      height: 150.h,
      scrolllingHeight: 80.h,
      onOptionSelected: (v) {},
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
        color: appConstants.black,
      ),
    );
  }

// Choose Attributes

  Widget chooseAttribute({required AddNewProductLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        chooseAttributes(state: state),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Visibility(
            visible: state.chooseAttributeshow ?? false,
            child: chooseattributeexpandview(state: state),
          ),
        ),
      ],
    );
  }

  Widget chooseAttributes({required AddNewProductLoadedState state}) {
    return GestureDetector(
      onTap: () {
        addNewCategoryCubit.selectChooseAttributesoption(
          state: state,
          value: !(state.chooseAttributeshow ?? true),
        );
      },
      child: CommonWidget.container(
        height: 48,
        width: double.infinity,
        isBorder: true,
        borderColor: appConstants.neutral6Color,
        borderRadius: 10.r,
        padding: EdgeInsets.only(left: 10.w),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addNewCategoryCubit.chooseattributeList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      itemCount: addNewCategoryCubit.chooseattributeList.length,
                      itemBuilder: (context, index) {
                        return addNewCategoryCubit.chooseattributeList[index].isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: CommonWidget.container(
                                  color: appConstants.buttonColor.withOpacity(0.3),
                                  borderRadius: 5.r,
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonWidget.commonText(
                                        text: addNewCategoryCubit.chooseattributeList[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: appConstants.black,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: CommonWidget.imageButton(
                                          svgPicturePath: "assets/photos/svg/common/close_icon.svg",
                                          color: appConstants.black,
                                          iconSize: 17.sp,
                                          onTap: () {
                                            addNewCategoryCubit.removeAttribute(
                                                index: index, isSelect: true, state: state);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : CommonWidget.container();
                      },
                    ),
                  )
                : CommonWidget.commonText(
                    text: TranslationConstants.choose_attributs.translate(context),
                    style: TextStyle(
                      color: appConstants.hintTextColor,
                      fontSize: 13.sp,
                    ),
                  ),
            Icon(
              state.chooseAttributeshow != true ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
              size: 40.r,
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseattributeexpandview({required AddNewProductLoadedState state}) {
    return CommonWidget.container(
      height: 135,
      width: 150,
      isBorder: true,
      borderColor: appConstants.buttonColor.withOpacity(0.2),
      color: appConstants.white,
      borderRadius: 10.r,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w, left: 3.w, top: 1.h, bottom: 5.h),
        child: Theme(
          data: Theme.of(context).copyWith(
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(appConstants.buttonColor),
            ),
          ),
          child: Scrollbar(
            controller: addNewCategoryCubit.scrollController,
            radius: Radius.circular(20.r),
            thickness: 8,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: chooseAttributeDetails.length,
              itemBuilder: (context, index) {
                bool isCurrentIndexSelected =
                    addNewCategoryCubit.chooseattributeList.contains(chooseAttributeDetails[index].name);

                return InkWell(
                  onTap: () {
                    addNewCategoryCubit.selectChooseAttributesoption(state: state, value: !isCurrentIndexSelected);
                    addNewCategoryCubit.changeChooseAttributesOptions(
                      chooseAttributesOption: chooseAttributeDetails[index].name,
                      state: state,
                    );
                    if (!isCurrentIndexSelected) {
                      addNewCategoryCubit.chooseattributeList.add(chooseAttributeDetails[index].name);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 7.w, right: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonWidget.commonText(
                          text: chooseAttributeDetails[index].name,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: isCurrentIndexSelected ? appConstants.editbuttonColor : appConstants.black,
                          ),
                        ),
                        if (isCurrentIndexSelected)
                          CommonWidget.imageBuilder(
                            imageUrl: "assets/photos/svg/common/round_sclected_arrow.svg",
                            color: appConstants.editbuttonColor,
                            height: 18.r,
                            fit: BoxFit.contain,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

// variants: customize

  Widget variant({required AddNewProductLoadedState state}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 7.h),
          scrollDirection: Axis.vertical,
          primary: false,
          itemCount: addNewCategoryCubit.chooseattributeList.length,
          itemBuilder: (context, index) {
            final variants = addNewCategoryCubit.chooseattributeList[index];
            return variants.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (index == 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidget.commonText(
                              text: TranslationConstants.customize_variant.translate(context),
                              style: TextStyle(color: appConstants.black, fontSize: 15.sp, fontWeight: FontWeight.w600),
                            ),
                            BlocBuilder<ToggleCubit, bool>(
                              bloc: addNewCategoryCubit.customizetoggleCubit,
                              builder: (context, state) {
                                return CommonWidget.toggleButton(
                                  value: state,
                                  onChanged: (bool value) {
                                    addNewCategoryCubit.customizetoggleCubit.setValue(value: value);
                                    if (value) {
                                      addNewCategoryCubit.priceController.text =
                                          addNewCategoryCubit.autoPriceController.text;
                                      addNewCategoryCubit.discountController.text =
                                          addNewCategoryCubit.autoDiscountController.text;
                                      addNewCategoryCubit.sellingPriceController.text =
                                          addNewCategoryCubit.autoSellingPriceController.text;
                                      addNewCategoryCubit.quantityController.text =
                                          addNewCategoryCubit.autoQuantityController.text;
                                      addNewCategoryCubit.selfPointController.text =
                                          addNewCategoryCubit.autoSelfPointController.text;
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: appConstants.black, width: 1),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidget.commonText(
                              text: "${TranslationConstants.variant.translate(context)} :",
                              style: TextStyle(color: appConstants.black, fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            CommonWidget.commonText(
                              text: variants,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: appConstants.editbuttonColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: commonTextField(
                                title: TranslationConstants.price.translate(context),
                                hinttext: "Ex: 10",
                                height: 50.r,
                                width: 157.w,
                                showTaxContainer: true,
                                textInputType: TextInputType.number,
                                controller: addNewCategoryCubit.autoPriceController,
                              ),
                            ),
                            CommonWidget.sizedBox(width: 15),
                            Expanded(
                              child: commonTextField(
                                title: TranslationConstants.discount.translate(context),
                                hinttext: "Ex: 10%",
                                height: 50.r,
                                width: 157.w,
                                showDiscountContainer: true,
                                textInputType: TextInputType.number,
                                controller: addNewCategoryCubit.autoDiscountController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: commonTextField(
                              title: TranslationConstants.selling_price.translate(context),
                              hinttext: "Ex: ₹100",
                              height: 50.r,
                              width: 157.w,
                              textInputType: TextInputType.number,
                              controller: addNewCategoryCubit.autoSellingPriceController,
                            ),
                          ),
                          CommonWidget.sizedBox(width: 15),
                          Expanded(
                            child: commonTextField(
                              title: TranslationConstants.quantity.translate(context),
                              hinttext: "Ex: 10",
                              height: 50.r,
                              width: 157.w,
                              textInputType: TextInputType.number,
                              controller: addNewCategoryCubit.autoQuantityController,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: commonTextField(
                                title: TranslationConstants.self_point.translate(context),
                                hinttext: "Ex: 10",
                                height: 50.r,
                                width: 157.w,
                                textInputType: TextInputType.number,
                                controller: addNewCategoryCubit.autoSelfPointController,
                              ),
                            ),
                            CommonWidget.sizedBox(width: 15),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  referralBottomSheet(state: state);
                                },
                                child: commonTextField(
                                  title: TranslationConstants.referral_point.translate(context),
                                  hinttext: TranslationConstants.add.translate(context),
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: appConstants.white,
                                  ),
                                  height: 50.r,
                                  width: 157.w,
                                  enable: false,
                                  fillColor: appConstants.buttonColor,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 60.w),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget commonTextField({
    required String title,
    required String hinttext,
    double? height,
    double? width,
    Color? fillColor,
    int? maxline,
    bool enable = true,
    bool showTaxContainer = false,
    bool showDiscountContainer = false,
    int? hintMaxline,
    TextEditingController? controller,
    TextInputType? textInputType,
    TextStyle? hintStyle,
    EdgeInsets? contentPadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<AddNewProductCubit, AddNewProductState>(
          bloc: addNewCategoryCubit,
          builder: (context, state) {
            if (state is AddNewProductLoadedState) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: title,
                    style: TextStyle(color: appConstants.black, fontWeight: FontWeight.w600),
                  ),
                  if (showTaxContainer)
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          selectTaxBottomSheet(title: TranslationConstants.select_tax.translate(context));
                        },
                        child: CommonWidget.container(
                          height: 30,
                          borderRadius: 5.r,
                          color: appConstants.buttonColor.withOpacity(0.3),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonWidget.commonText(
                                text: addNewCategoryCubit.selectedTaxValue == 1 ? "Without Tax" : "With Tax",
                                style: TextStyle(
                                  color: appConstants.black,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/svg/common/bottom_arrow.svg",
                                  height: 5.r,
                                  width: 5.r,
                                  color: appConstants.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (showDiscountContainer)
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          selectDiscountBottomSheet(title: TranslationConstants.select_discount.translate(context));
                        },
                        child: CommonWidget.container(
                          borderRadius: 5.r,
                          color: appConstants.buttonColor.withOpacity(0.3),
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonWidget.commonText(
                                text: addNewCategoryCubit.selectedDiscountValue == 1 ? 'Percentage' : 'Discount',
                                style: TextStyle(
                                  color: appConstants.black,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/svg/common/bottom_arrow.svg",
                                  height: 5.r,
                                  width: 5.r,
                                  color: appConstants.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            } else if (state is AddNewProductLoadingState) {
              return CommonWidget.loadingIos();
            } else if (state is AddNewProductErrorState) {
              return CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: state.errorMessage);
            }
            return const SizedBox.shrink();
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: CommonWidget.sizedBox(
            height: height,
            width: width,
            child: CommonWidget.textField(
              enabled: enable,
              fillColor: fillColor ?? appConstants.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: appConstants.buttonColor.withOpacity(0.5),
                ),
              ),
              textInputType: textInputType,
              borderColor: appConstants.buttonColor.withOpacity(0.5),
              enabledBorderColor: appConstants.buttonColor.withOpacity(0.5),
              focusedBorderColor: appConstants.buttonColor.withOpacity(0.5),
              disabledBorderColor: appConstants.buttonColor.withOpacity(0.5),
              isfocusedBorderColor: true,
              hintText: hinttext,
              hintStyle: hintStyle ??
                  TextStyle(
                    fontSize: 13.sp,
                    color: appConstants.hintTextColor,
                  ),
              maxLines: maxline ?? 1,
              controller: controller,
              cursorColor: appConstants.buttonColor,
              contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            ),
          ),
        ),
      ],
    );
  }

  selectTaxBottomSheet({required String title}) {
    return openBottomBar(
      context: context,
      heightFactor: 0.22.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: title,
                  style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w900, fontSize: 15.sp),
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
          Divider(
            color: appConstants.dividerColor,
          ),
          BlocBuilder<AddNewProductCubit, AddNewProductState>(
            bloc: addNewCategoryCubit,
            builder: (context, state) {
              if (state is AddNewProductLoadedState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      radioButton(
                        context: context,
                        label: "Without Tax",
                        groupValue: addNewCategoryCubit.selectedTaxValue,
                        radioButtonValue: 1,
                        onChanged: (value) {
                          addNewCategoryCubit.updateSelectedTaxValue(value: value, state: state);
                        },
                      ),
                      radioButton(
                        context: context,
                        label: "With Tax",
                        groupValue: addNewCategoryCubit.selectedTaxValue,
                        radioButtonValue: 2,
                        onChanged: (value) {
                          addNewCategoryCubit.updateSelectedTaxValue(value: value, state: state);
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is AddNewProductLoadingState) {
                return CommonWidget.loadingIos();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  selectDiscountBottomSheet({required String title}) {
    return openBottomBar(
      context: context,
      heightFactor: 0.22.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: title,
                  style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w900, fontSize: 15.sp),
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
          Divider(color: appConstants.dividerColor),
          BlocBuilder<AddNewProductCubit, AddNewProductState>(
            bloc: addNewCategoryCubit,
            builder: (context, state) {
              if (state is AddNewProductLoadedState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      radioButton(
                        context: context,
                        label: "Percentage",
                        groupValue: addNewCategoryCubit.selectedDiscountValue,
                        radioButtonValue: 1,
                        onChanged: (value) {
                          addNewCategoryCubit.updateDiscountValue(value: value, state: state);
                        },
                      ),
                      radioButton(
                        context: context,
                        label: "Discount",
                        groupValue: addNewCategoryCubit.selectedDiscountValue,
                        radioButtonValue: 2,
                        onChanged: (value) {
                          addNewCategoryCubit.updateDiscountValue(value: value, state: state);
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is AddNewProductLoadingState) {
                return CommonWidget.loadingIos();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
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
                  return appConstants.neutral1Color;
                }
              },
            ),
            value: radioButtonValue,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

// Refferal Points Bottomsheet

  referralBottomSheet({required AddNewProductLoadedState state}) {
    return openBottomBar(
      heightFactor: 0.80.h,
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.referral_points.translate(context),
                  style: TextStyle(color: appConstants.buttonColor, fontWeight: FontWeight.w900, fontSize: 15.sp),
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
          Divider(
            color: appConstants.dividerColor,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
              child: BlocBuilder<AddNewProductCubit, AddNewProductState>(
                bloc: addNewCategoryCubit,
                builder: (context, state) {
                  if (state is AddNewProductLoadedState) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidget.commonText(
                              text: TranslationConstants.srNo.translate(context),
                              style: TextStyle(
                                color: appConstants.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 18.w, right: 102.w),
                              child: CommonWidget.commonText(
                                text: TranslationConstants.levels.translate(context),
                                style: TextStyle(
                                  color: appConstants.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                            CommonWidget.commonText(
                              text: TranslationConstants.points.translate(context),
                              style: TextStyle(
                                color: appConstants.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: referralPointView(),
                        ),
                        Divider(
                          color: appConstants.dividerColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  addNewCategoryCubit.incrementItemCount(state: state);
                                },
                                child: CommonWidget.container(
                                  borderRadius: 8.r,
                                  color: appConstants.buttonColor,
                                  height: 45,
                                  width: 100,
                                  child: Center(
                                    child: CommonWidget.commonText(
                                      text: TranslationConstants.add.translate(context),
                                      style: TextStyle(
                                        color: appConstants.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is AddNewProductLoadingState) {
                    return CommonWidget.loadingIos();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
              child: CommonWidget.container(
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                color: appConstants.buttonColor,
                borderRadius: 10.r,
                child: Center(
                  child: CommonWidget.commonText(
                    text: TranslationConstants.submit.translate(context),
                    style: TextStyle(fontSize: 15.sp, color: appConstants.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget referralPointView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const BouncingScrollPhysics(),
      itemCount: addNewCategoryCubit.itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 15.w),
                child: CommonWidget.commonText(
                  text: index.toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: appConstants.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              commonReferralfields(hintText: "Ex: Level $index"),
              commonReferralfields(hintText: "Ex: 20 Point"),
            ],
          ),
        );
      },
    );
  }

  Widget commonReferralfields({required String hintText}) {
    return CommonWidget.sizedBox(
      height: 50,
      width: 130,
      child: CommonWidget.textField(
        fillColor: appConstants.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: appConstants.buttonColor.withOpacity(0.5)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: appConstants.hintTextColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      ),
    );
  }

// Product Selling Status:

  Widget productSelling({required AddNewProductLoadedState state}) {
    return CustomDropdownButton(
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w),
      useTextField: true,
      titleTextAlignment: Alignment.centerLeft,
      size: 40.r,
      selectedOptions: "Product Selling Status",
      dataList: const [
        "New Arrival",
        "Hot Favoutite",
        "Seasonal",
      ],
      height: 150.h,
      scrolllingHeight: 82.h,
      onOptionSelected: (v) {},
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
        color: appConstants.black,
      ),
    );
  }

// upload image/video and cateloge Img

  Widget uploadImag() {
    return CommonImagePickTextFeild(
      isMultipleImagePick: true,
      pickImageCubit: addNewCategoryCubit.pickUploadImagCubit,
      isShowImag: true,
      isEdit: false,
    );
  }

  Widget catalogeImage() {
    return CommonImagePickTextFeild(
      isMultipleImagePick: true,
      pickImageCubit: addNewCategoryCubit.pickCatelogImagCubit,
      isEdit: true,
      isShowImag: false,
    );
  }

  List<String> selectedCategoryList = [
    "Cakes",
    "Breads",
    "Pastries",
    "Cookies",
    "Cakes",
    "Breads",
    "Pastries",
    "Cookies",
    "Cakes",
    "Breads",
    "Pastries",
    "Cookies",
  ];
  List<String> selectedBrandList = [
    "Britannia Bread",
    "Harvest Gold",
    "Kanha",
    "Fresho",
  ];
}
