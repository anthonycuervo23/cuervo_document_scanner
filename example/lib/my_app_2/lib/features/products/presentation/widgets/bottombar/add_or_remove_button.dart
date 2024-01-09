import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_data_for_cart_model.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_model.dart';
import 'package:bakery_shop_flutter/features/products/domain/args/product_details.args.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/update_data/update_data_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/product_details_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/animated_flip_counter.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/common_product_box.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOrRemoveButton extends StatefulWidget {
  final ProductItem model;
  final double total;
  final int selectedProductIndex;
  const AddOrRemoveButton({super.key, required this.model, required this.total, required this.selectedProductIndex});

  @override
  State<AddOrRemoveButton> createState() => _AddOrRemoveButtonState();
}

class _AddOrRemoveButtonState extends State<AddOrRemoveButton> {
  late UpdateDataCubit updateDataCubit;
  late CartCubit cartCubit;
  late ProductItem productModel;
  int selectedProductIndex = 0;

  @override
  void initState() {
    updateDataCubit = getItInstance<UpdateDataCubit>();
    cartCubit = BlocProvider.of<CartCubit>(context);
    productModel = widget.model;
    super.initState();
  }

  List<ProductDataForCartModel> l1 = [];

  @override
  Widget build(BuildContext context) {
    selectedProductIndex = widget.selectedProductIndex;
    return selectedProductIndex != -1 ? plusOrRemove(context: context) : addButton();
  }

  Widget plusOrRemove({required BuildContext context}) {
    return CommonWidget.container(
      isBorderOnlySide: true,
      bottomRight: 15.r,
      topLeft: 10.r,
      color: appConstants.primary1Color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          minusButton(context: context),
          centerTotalText(context: context),
          plusButton(context: context),
        ],
      ),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: () async {
        if (productModel.productQuantityAttributesPrice.isNotEmpty) {
          await commonBottomSheet(
            context: context,
            bottomBarWidget: CommonWidget.sizedBox(
              height: ScreenUtil().screenHeight * 0.5,
              child: ProductDetailsBar(
                productDetailsArgs: ProductDetailsArgs(visibleImage: false, productData: productModel),
              ),
            ),
            height: ScreenUtil().screenHeight * 0.6,
          );
        } else {
          ProductDataForCartModel model = ProductDataForCartModel(
            productId: productModel.id,
            productName: productModel.name,
            productPrice: productModel.productPrice,
            productAttributsId: 0,
            slugs: [],
            productSlugPrice: 0,
            totalProduct: 1,
          );
          localCartDataStore.add(model);
          bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
          bakeryBox.get(HiveConstants.CART_DATA_STORE);
          cartCubit.addQuantityData(parms: AddProductMyCartParms(productId: model.productId, qty: model.totalProduct));
        }
        updateDataCubit.update();
      },
      child: CommonWidget.container(
        isBorderOnlySide: true,
        bottomRight: 15.r,
        topLeft: 15.r,
        color: appConstants.secondary1Color,
        alignment: Alignment.center,
        child: Center(
          child: CommonWidget.commonText(
            text: TranslationConstants.add.translate(context),
            style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                  color: appConstants.primary1Color,
                ),
          ),
        ),
      ),
    );
  }

  Widget centerTotalText({required BuildContext context}) {
    return AnimatedFlipCounter(
      value: widget.total,
      fractionDigits: 0,
      textStyle: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
            color: appConstants.buttonTextColor,
          ),
    );
  }

  Widget plusButton({required BuildContext context}) {
    return Expanded(
      child: Center(
        child: InkWell(
          onTap: () async {
            if (localCartDataStore[selectedProductIndex].slugs.isEmpty) {
              ProductDataForCartModel model = ProductDataForCartModel(
                productId: localCartDataStore[selectedProductIndex].productId,
                productName: localCartDataStore[selectedProductIndex].productName,
                productPrice: localCartDataStore[selectedProductIndex].productPrice,
                productAttributsId: 0,
                slugs: [],
                productSlugPrice: 0,
                totalProduct: localCartDataStore[selectedProductIndex].totalProduct + 1,
              );
              if (localCartProduct.isNotEmpty) {
                int index = localCartProduct.indexWhere((element) => element.productName == model.productName);
                if (index == -1) {
                  localCartProduct.add(model);
                } else {
                  localCartProduct[index] = model;
                }
              } else {
                localCartProduct.add(model);
              }
              localCartDataStore[selectedProductIndex] = model;
              // bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
              // bakeryBox.get(HiveConstants.CART_DATA_STORE);
              // cartCubit.addQuantityData(
              //   parms: AddProductMyCartParms(
              //     qty: model.totalProduct,
              //     productId: model.productId,
              //   ),
              // );
            } else {
              localCartProduct1 = [];
              for (var e in localCartDataStore) {
                if (e.productName == productModel.name) {
                  localCartProduct1.add(e);
                }
              }
              await yourCustomisationsBottomSheets(
                selectedIndex: selectedProductIndex,
                updateDataCubit: updateDataCubit,
                context: context,
                productModel: productModel,
                cartCubit: cartCubit,
                localCartProduct1: localCartProduct1,
              );
            }
          },
          child: CommonWidget.container(
            height: 20.h,
            width: 25.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            color: appConstants.primary1Color,
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/plus_icon.svg",
            ),
          ),
        ),
      ),
    );
  }

  Widget minusButton({required BuildContext context}) {
    return Expanded(
      child: Center(
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () async {
            if (localCartDataStore[selectedProductIndex].slugs.isEmpty) {
              int productId = 0;
              ProductDataForCartModel model = ProductDataForCartModel(
                productId: localCartDataStore[selectedProductIndex].productId,
                productName: localCartDataStore[selectedProductIndex].productName,
                productPrice: localCartDataStore[selectedProductIndex].productPrice,
                productAttributsId: 0,
                slugs: [],
                productSlugPrice: 0,
                totalProduct: localCartDataStore[selectedProductIndex].totalProduct - 1,
              );
              if (model.totalProduct == 0) {
                productId = localCartDataStore[selectedProductIndex].productId;
                cartCubit.addQuantityData(
                  parms: AddProductMyCartParms(
                    qty: 0,
                    productId: productId,
                  ),
                );
                localCartDataStore.removeAt(selectedProductIndex);
              } else {
                localCartDataStore[selectedProductIndex] = model;
                cartCubit.addQuantityData(
                  parms: AddProductMyCartParms(
                    qty: model.totalProduct,
                    productId: model.productId,
                  ),
                );
              }
              bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
              bakeryBox.get(HiveConstants.CART_DATA_STORE);
            } else {
              localCartProduct1 = [];
              for (var e in localCartDataStore) {
                if (e.productName == productModel.name) {
                  localCartProduct1.add(e);
                }
              }
              if (localCartProduct1.length == 1) {
                ProductDataForCartModel model = ProductDataForCartModel(
                  productId: localCartProduct1[0].productId,
                  productName: localCartProduct1[0].productName,
                  productPrice: localCartProduct1[0].productPrice,
                  productAttributsId: localCartProduct1[0].productAttributsId,
                  slugs: localCartProduct1[0].slugs,
                  productSlugPrice: localCartProduct1[0].productSlugPrice,
                  totalProduct: localCartDataStore[selectedProductIndex].totalProduct - 1,
                );
                if (model.totalProduct == 0) {
                  cartCubit.addQuantityData(
                    parms: AddProductMyCartParms(
                      qty: 0,
                      productId: model.productId,
                      productPriceId: model.productAttributsId,
                    ),
                  );
                  localCartDataStore.removeAt(selectedProductIndex);
                } else {
                  cartCubit.addQuantityData(
                    parms: AddProductMyCartParms(
                      qty: model.totalProduct,
                      productId: model.productId,
                      productPriceId: model.productAttributsId,
                    ),
                  );
                  localCartDataStore[selectedProductIndex] = model;
                }
              } else {
                await yourCustomisationsBottomSheets(
                  selectedIndex: selectedProductIndex,
                  context: context,
                  productModel: productModel,
                  updateDataCubit: updateDataCubit,
                  cartCubit: cartCubit,
                  localCartProduct1: localCartProduct1,
                );
              }
            }
          },
          child: CommonWidget.container(
            height: 20.h,
            width: 25.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            color: appConstants.primary1Color,
            child: CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/minus_icon.svg",
            ),
          ),
        ),
      ),
    );
  }

  Future yourCustomisationsBottomSheets({
    required BuildContext context,
    required ProductItem productModel,
    required CartCubit cartCubit,
    required List<ProductDataForCartModel> localCartProduct1,
    required UpdateDataCubit updateDataCubit,
    required int selectedIndex,
  }) {
    List<String> productIdList = [];
    return commonBottomSheet(
      context: context,
      bottomBarWidget: bottomSheetView(
        updateDataCubit: updateDataCubit,
        localCartProduct1: localCartProduct1,
        productIdList: productIdList,
        productModel: productModel,
        cartCubit: cartCubit,
      ),
      height: ScreenUtil().screenHeight * 0.6,
    );
  }

  Widget bottomSheetView({
    required UpdateDataCubit updateDataCubit,
    required List<ProductDataForCartModel> localCartProduct1,
    required List<String> productIdList,
    required ProductItem productModel,
    required CartCubit cartCubit,
  }) {
    return CommonWidget.container(
      width: ScreenUtil().screenWidth,
      child: BlocBuilder<UpdateDataCubit, double>(
        bloc: updateDataCubit,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sameProductTitleView(context: context),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productListView(
                      localCartProduct1: localCartProduct1,
                      context: context,
                      productIdList: productIdList,
                      updateDataCubit: updateDataCubit,
                    ),
                    addNewItemButton(context: context, productModel: productModel),
                    CommonWidget.sizedBox(height: 10.h),
                    confirmButton(
                      context: context,
                      productIdList: productIdList,
                      cartCubit: cartCubit,
                      localCartProduct1: localCartProduct1,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget confirmButton({
    required BuildContext context,
    required List<String> productIdList,
    required CartCubit cartCubit,
    required List<ProductDataForCartModel> localCartProduct1,
  }) {
    return CommonWidget.commonButton(
      text: TranslationConstants.confirm.translate(context),
      alignment: Alignment.center,
      textColor: appConstants.buttonTextColor,
      height: 50.h,
      width: ScreenUtil().screenWidth,
      context: context,
      onTap: () {
        for (var e in productIdList) {
          List<String> productIdListt = e.split('_');
          int index = localCartDataStore.indexWhere(
            (element) => element.productAttributsId == int.parse(productIdListt[1]),
          );
          localCartDataStore.removeAt(index);

          cartCubit.addQuantityData(
            parms: AddProductMyCartParms(
              qty: 0,
              productId: int.parse(productIdListt[0]),
              productPriceId: int.parse(productIdListt[1]),
            ),
          );
        }
        for (var e in localCartProduct1) {
          int index = localCartDataStore.indexWhere(
            (element) => listEquals(element.slugs, e.slugs),
          );
          localCartDataStore[index] = e;
          cartCubit.addQuantityData(
            parms: AddProductMyCartParms(
              qty: e.totalProduct,
              productId: e.productId,
              productPriceId: e.productAttributsId,
            ),
          );
        }
        CommonRouter.pop();
        updateDataCubit.update();
      },
    );
  }

  Widget addNewItemButton({required BuildContext context, required ProductItem productModel}) {
    return InkWell(
      onTap: () async {
        CommonRouter.pop();
        await commonBottomSheet(
          context: context,
          bottomBarWidget: CommonWidget.sizedBox(
            height: ScreenUtil().screenHeight * 0.7,
            child: ProductDetailsBar(
              productDetailsArgs: ProductDetailsArgs(
                visibleImage: false,
                productData: productModel,
              ),
            ),
          ),
          height: ScreenUtil().screenHeight * 0.6,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/common/plus_rounded.svg"),
          CommonWidget.sizedBox(width: 10),
          CommonWidget.commonText(
            text: TranslationConstants.add_new_customisation.translate(context),
            style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                  color: appConstants.primary1Color,
                ),
          ),
        ],
      ),
    );
  }

  Widget productListView({
    required List<ProductDataForCartModel> localCartProduct1,
    required BuildContext context,
    required List<String> productIdList,
    required UpdateDataCubit updateDataCubit,
  }) {
    return CommonWidget.sizedBox(
      height: 300.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: localCartProduct1.length,
        itemBuilder: (_, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CommonWidget.container(
                        width: 150.w,
                        child: CommonWidget.commonText(
                          text: localCartProduct1[index].productName,
                          style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                      ),
                      CommonWidget.container(
                        width: 150.w,
                        child: CommonWidget.commonText(
                          maxLines: 5,
                          text: "${localCartProduct1[index].slugs}",
                          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                color: appConstants.default3Color,
                              ),
                        ),
                      ),
                      CommonWidget.sizedBox(height: 8),
                      CommonWidget.container(
                        width: 150.w,
                        child: CommonWidget.commonText(
                          maxLines: 5,
                          text: TranslationConstants.edit.translate(context),
                          style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                color: appConstants.primary1Color,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonWidget.container(
                        height: 40.h,
                        borderColor: appConstants.default5Color,
                        borderRadius: 5.r,
                        isBorder: true,
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                if (localCartProduct1[index].totalProduct != 1) {
                                  localCartProduct1[index] = ProductDataForCartModel(
                                    productId: localCartProduct1[index].productId,
                                    productName: localCartProduct1[index].productName,
                                    productPrice: localCartProduct1[index].productPrice,
                                    productAttributsId: localCartProduct1[index].productAttributsId,
                                    slugs: localCartProduct1[index].slugs,
                                    productSlugPrice: localCartProduct1[index].productSlugPrice,
                                    totalProduct: localCartProduct1[index].totalProduct - 1,
                                  );
                                } else {
                                  productIdList.add(
                                    "${localCartProduct1[index].productId}_${localCartProduct1[index].productAttributsId}",
                                  );
                                  localCartProduct1.removeAt(index);
                                }
                                updateDataCubit.update();
                              },
                              child: Container(
                                height: 20.h,
                                width: 20.w,
                                alignment: Alignment.center,
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/svg/common/minus_icon.svg",
                                  color: appConstants.primary1Color,
                                ),
                              ),
                            ),
                            AnimatedFlipCounter(
                              value: localCartProduct1[index].totalProduct,
                              fractionDigits: 0,
                              textStyle: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                    color: appConstants.primary1Color,
                                  ),
                            ),
                            InkWell(
                              onTap: () {
                                localCartProduct1[index] = ProductDataForCartModel(
                                  productId: localCartProduct1[index].productId,
                                  productName: localCartProduct1[index].productName,
                                  productPrice: localCartProduct1[index].productPrice,
                                  productAttributsId: localCartProduct1[index].productAttributsId,
                                  slugs: localCartProduct1[index].slugs,
                                  productSlugPrice: localCartProduct1[index].productSlugPrice,
                                  totalProduct: localCartProduct1[index].totalProduct + 1,
                                );
                                updateDataCubit.update();
                              },
                              child: Container(
                                height: 20.h,
                                width: 20.w,
                                alignment: Alignment.center,
                                child: CommonWidget.imageBuilder(
                                  imageUrl: "assets/photos/svg/common/plus_icon.svg",
                                  color: appConstants.primary1Color,
                                  height: 18.h,
                                  width: 18.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonWidget.sizedBox(height: 8),
                      CommonWidget.commonText(
                        maxLines: 5,
                        text: CommonWidget.sringToCurrencyFormate(
                          text: localCartProduct1[index].productPrice * localCartProduct1[index].totalProduct,
                        ),
                        style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              CommonWidget.sizedBox(height: 10),
              CommonWidget.commonDashLine(),
              CommonWidget.sizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget sameProductTitleView({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.your_customisations.translate(context),
            style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                  color: appConstants.default1Color,
                ),
          ),
          CommonWidget.container(
            height: 30.h,
            width: 30.w,
            alignment: Alignment.center,
            color: Colors.transparent,
            child: CommonWidget.imageButton(
              svgPicturePath: "assets/photos/svg/common/close_icon.svg",
              onTap: () => CommonRouter.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
