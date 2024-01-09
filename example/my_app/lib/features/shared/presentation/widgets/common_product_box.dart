// ignore_for_file: iterable_contains_unrelated_type

import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_model.dart';
import 'package:bakery_shop_flutter/features/products/domain/args/product_details.args.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/add_or_remove_button.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/product_details_bar.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget commonProductBox({
  required int productIndex,
  required ProductListLoadedState state,
  required ProductListCubit productListCubit,
  required CartCubit cartCubit,
  required ProductItem productModel,
  required BuildContext context,
  required int index,
}) {
  int selectedProductIndex = localCartDataStore.indexWhere(
    (element) => element.productName == productModel.name,
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    child: GestureDetector(
      onTap: () async {
        await commonBottomSheet(
          context: context,
          bottomBarWidget: CommonWidget.sizedBox(
            height: ScreenUtil().screenHeight * 0.5,
            child: ProductDetailsBar(
              productDetailsArgs: ProductDetailsArgs(
                visibleImage: true,
                productData: productModel,
              ),
            ),
          ),
          height: productModel.productQuantityAttributesPrice.isNotEmpty
              ? ScreenUtil().screenHeight * 0.8
              : ScreenUtil().screenHeight * 0.7,
        );
        productListCubit.updateScreenData(state: state);
      },
      child: CommonWidget.container(
        color: appConstants.whiteBackgroundColor,
        borderRadius: 15.r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productImage(
                    productModel: productModel,
                    productIndex: productIndex,
                    state: state,
                  ),
                  productDetails(productModel: productModel, context: context),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                moreDetailsButton(productModel: productModel, productState: state, context: context),
                productAddOrRemoveCart(
                  cartCubit: cartCubit,
                  selectedProductIndex: selectedProductIndex,
                  state: state,
                  index: index,
                  productListCubit: productListCubit,
                  productModel: productModel,
                  context: context,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget productAddOrRemoveCart({
  required ProductItem productModel,
  required BuildContext context,
  required ProductListCubit productListCubit,
  required ProductListLoadedState state,
  required int index,
  required CartCubit cartCubit,
  required int selectedProductIndex,
}) {
  int totalProductItemCount = 0;
  for (var e in localCartDataStore) {
    if (e.productName == productModel.name) {
      totalProductItemCount += e.totalProduct;
    }
  }
  productListCubit.updateScreenData(state: state);
  return CommonWidget.container(
    isBorderOnlySide: true,
    width: 95.w,
    height: 43.h,
    bottomRight: 15.r,
    topLeft: 10.r,
    color: appConstants.whiteBackgroundColor,
    child: AddOrRemoveButton(
      model: productModel,
      total: totalProductItemCount.toDouble(),
      selectedProductIndex: selectedProductIndex,
    ),
  );
}

Widget moreDetailsButton({
  required ProductItem productModel,
  required ProductListLoadedState productState,
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: Row(
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.more_details.translate(context),
          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                color: appConstants.default3Color,
              ),
        ),
        CommonWidget.commonIcon(
          icon: Icons.keyboard_arrow_right,
          iconColor: appConstants.default3Color,
          iconSize: 18.sp,
        ),
      ],
    ),
  );
}

Widget productDetails({
  required ProductItem productModel,
  required BuildContext context,
}) {
  ProductQuantityAttributesPrice? attributes;
  if (productModel.productQuantityAttributesPrice.isNotEmpty && productModel.productQuantityAttributesPrice != []) {
    attributes = productModel.productQuantityAttributesPrice.first;
  }
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonWidget.imageBuilder(
                    imageUrl: productModel.vegNonVeg
                        ? "assets/photos/svg/common/vegetarian_icon.svg"
                        : "assets/photos/svg/common/nonVegetarian_icon.svg",
                    height: 16.sp,
                  ),
                  bestSellerContainer(visible: productModel.isBestseller, context: context),
                  coinContainer(context: context),
                ],
              ),
              CommonWidget.sizedBox(height: 5),
              CommonWidget.commonText(
                text: productModel.name,
                style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                      color: appConstants.default1Color,
                      height: 1.1,
                    ),
                maxLines: 2,
              ),
              CommonWidget.sizedBox(height: 5),
              Visibility(
                visible: attributes?.slugs != [] && attributes?.slugs.isNotEmpty == true,
                child: Builder(builder: (context) {
                  return CommonWidget.commonText(
                    text: '(${attributes?.slugs.first.toString().replaceAll('-', ' ')})',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                          color: appConstants.default1Color,
                          height: 1,
                        ),
                  );
                }),
              ),
              CommonWidget.sizedBox(height: 5),
              Row(
                children: [
                  CommonWidget.commonText(
                    text: double.tryParse(attributes?.discountedPrice.price ?? productModel.discountedPrice.price)
                            ?.formatCurrency(decimalDigits: 2) ??
                        '',
                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                          color: appConstants.primary1Color,
                          height: 1,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: CommonWidget.commonText(
                      text: double.parse(attributes?.price ?? productModel.price).formatCurrency(),
                      style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                            color: appConstants.default4Color,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: appConstants.default4Color,
                            height: 1,
                          ),
                    ),
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 5),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/star_icon.svg", height: 12.r),
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: CommonWidget.commonText(
                    text: "100",
                    style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                          color: appConstants.starRateColor,
                          height: 1,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: CommonWidget.commonText(
                    text: "(100)",
                    style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                          color: appConstants.default3Color,
                          height: 1,
                        ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: productModel.productQuantityAttributes.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: CommonWidget.commonText(
                  text: TranslationConstants.customizable.translate(context),
                  style: Theme.of(context).textTheme.overLineBookHeading.copyWith(color: appConstants.default4Color),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget bestSellerContainer({
  required bool visible,
  required BuildContext context,
}) {
  return Visibility(
    visible: visible,
    child: Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: CommonWidget.container(
        borderRadius: 5.r,
        padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 2.h),
        color: appConstants.bestSeller2Color,
        child: CommonWidget.commonText(
          text: TranslationConstants.bestseller.translate(context),
          fontSize: 16.sp,
          style: Theme.of(context).textTheme.overLineBoldHeading.copyWith(color: appConstants.bestSeller1Color),
        ),
      ),
    ),
  );
}

Widget coinContainer({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.only(left: 4.w),
    child: CommonWidget.container(
      borderRadius: 5.r,
      padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 2.h),
      color: appConstants.secondary2Color,
      child: Row(
        children: [
          CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/product_screen/productlist_coins.svg",
            color: appConstants.primary1Color,
            height: 10.sp,
          ),
          CommonWidget.sizedBox(width: 5),
          CommonWidget.commonText(
            text: '100',
            style: Theme.of(context).textTheme.overLineBoldHeading.copyWith(color: appConstants.default1Color),
          ),
        ],
      ),
    ),
  );
}

Widget productImage({
  required ProductItem productModel,
  required int productIndex,
  required ProductListLoadedState state,
}) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Container(
          alignment: Alignment.center,
          height: 107.h,
          width: 107.h,
          child: CommonWidget.imageBuilder(
            imageUrl: productModel.thumbnail.isEmpty
                ? accountInfoEntity?.defaultImage ?? "assets/photos/svg/common/no_data.svg"
                : productModel.thumbnail,
            fit: (productModel.thumbnail.isEmpty && accountInfoEntity?.defaultImage.isEmpty == true)
                ? BoxFit.contain
                : BoxFit.cover,
            height: 107.h,
            width: 107.h,
            borderRadius: appConstants.prductCardRadius,
          ),
        ),
      ),
    ],
  );
}

Future<dynamic> commonBottomSheet({
  required BuildContext context,
  required Widget bottomBarWidget,
  required double height,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    useSafeArea: true,
    enableDrag: false,
    barrierColor: appConstants.default2Color,
    backgroundColor: appConstants.whiteBackgroundColor,
    builder: (context) {
      return CommonWidget.sizedBox(
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(26.r), topRight: Radius.circular(26.r)),
          child: bottomBarWidget,
        ),
      );
    },
  );
}
