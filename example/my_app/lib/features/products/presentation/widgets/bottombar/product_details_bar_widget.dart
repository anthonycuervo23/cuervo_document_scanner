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
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/product_details_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/animated_flip_counter.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ProductDetailsBarWidget extends State<ProductDetailsBar> {
  late ProductListCubit productListCubit;
  late ProductItem productModel;
  late CartCubit cartCubit;
  late CounterCubit counterCubit;
  List<String> listOfProductCategoryType1 = [];
  List<String> listOfProductCategoryType2 = [];
  int totalProductMessaeCharacters = 500;
  double totalPrice = 0;

  @override
  void initState() {
    counterCubit = getItInstance<CounterCubit>();
    cartCubit = BlocProvider.of<CartCubit>(context);
    productListCubit = getItInstance<ProductListCubit>();
    super.initState();
    counterCubit.chanagePageIndex(index: 1);
    productModel = widget.productDetailsArgs.productData;
    loadProductCategoty(productQuantityAttributes: productModel.productQuantityAttributes);
    totalPrice = double.parse(productModel.price.replaceAll(',', ''));
  }

  void loadProductCategoty({
    required List<ProductQuantityAttributes> productQuantityAttributes,
  }) {
    List<String> tempList = [];
    List<String> tempList1 = [];
    for (var e in productQuantityAttributes) {
      tempList.add(e.options[0].value);
      tempList1.add(e.options[0].slug);
    }
    listOfProductCategoryType1 = tempList;
    listOfProductCategoryType2 = tempList1;
  }

  void updatecategoryType({
    required int mainIndex,
    required ProductQuantityAttributes model,
    required int index,
  }) {
    List<String> tempList = listOfProductCategoryType1;
    List<String> tempList1 = listOfProductCategoryType2;
    tempList[mainIndex] = model.options[index].value;
    tempList1[mainIndex] = model.options[index].slug;
    int priceIndex = productModel.productQuantityAttributesPrice.indexWhere(
      (element) => listEquals(element.slugs, listOfProductCategoryType2),
    );
    totalPrice = double.parse(productModel.productQuantityAttributesPrice[priceIndex].price.replaceAll(',', ''));
  }

  void updateLength({required int length}) {
    totalProductMessaeCharacters = 500 - length;
    productListCubit.updateDataCubit.update();
  }

  Widget quantityButton(BuildContext context, ProductListLoadedState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.commonText(
          text: TranslationConstants.quantity.translate(context),
          style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                color: appConstants.default1Color,
              ),
        ),
        CommonWidget.sizedBox(height: 10),
        CommonWidget.sizedBox(
          height: 65,
          child: BlocBuilder<CounterCubit, int>(
            bloc: productListCubit.quantityChangeCubit,
            builder: (context, counterState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.productQuantityList.length,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return CommonWidget.container(
                    width: 100,
                    isBorder: true,
                    borderRadius: 10.r,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    color: counterState == index ? appConstants.secondary2Color : appConstants.whiteBackgroundColor,
                    borderColor: counterState == index ? appConstants.primary1Color : appConstants.default6Color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.commonText(
                          text: state.productQuantityList[index].slugs.first.replaceAll('-', ' '),
                          style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                color: counterState == index ? appConstants.default1Color : appConstants.default1Color,
                              ),
                        ),
                        CommonWidget.commonText(
                          text: double.parse(state.productQuantityList[index].price).formatCurrency(),
                          style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                color: counterState == index ? appConstants.primary1Color : appConstants.default1Color,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget imageView({required ProductItem productModel, required bool visibleImage}) {
    if (productModel.images.isEmpty) {
      return Visibility(
        visible: visibleImage == true,
        child: Container(
          width: ScreenUtil().screenWidth,
          alignment: Alignment.center,
          color: appConstants.greyBackgroundColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CommonWidget.imageBuilder(
                  imageUrl: productModel.thumbnail.isEmpty
                      ? accountInfoEntity?.defaultImage ?? "assets/photos/svg/common/no_data.svg"
                      : productModel.thumbnail,
                  fit: (productModel.thumbnail.isEmpty && accountInfoEntity?.defaultImage.isEmpty == true)
                      ? BoxFit.contain
                      : BoxFit.cover,
                  width: ScreenUtil().screenWidth,
                  height: 200.h,
                ),
              ),
              Container(
                width: ScreenUtil().screenWidth,
                height: 200.h,
                alignment: Alignment.topRight,
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () => CommonRouter.pop(),
                  child: CommonWidget.sizedBox(
                    height: 50,
                    width: 50,
                    child: Container(
                      margin: EdgeInsets.all(10.h),
                      padding: EdgeInsets.all(7.h),
                      decoration: BoxDecoration(
                        color: appConstants.whiteBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/common/close_icon.svg",
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
    return Visibility(
      visible: visibleImage,
      child: productImageSlider(
        productModel: productModel,
        counterCubit: counterCubit,
      ),
    );
  }

  Widget mainTitle({required ProductItem productModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidget.sizedBox(height: 10),
        Row(
          children: [
            CommonWidget.imageBuilder(
              imageUrl: productModel.vegNonVeg
                  ? "assets/photos/svg/common/vegetarian_icon.svg"
                  : "assets/photos/svg/common/nonVegetarian_icon.svg",
              height: 16.sp,
            ),
            Visibility(
              visible: productModel.isBestseller,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: appConstants.bestSeller2Color,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.r,
                    vertical: 3.h,
                  ),
                  child: CommonWidget.commonText(
                    text: TranslationConstants.bestseller.translate(context),
                    style: Theme.of(context).textTheme.overLineBoldHeading.copyWith(
                          color: appConstants.bestSeller1Color,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: CommonWidget.commonText(
            text: productModel.name,
            maxLines: 10,
            style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(color: appConstants.default1Color),
          ),
        ),
        Row(
          children: [
            CommonWidget.commonText(
              text: double.parse(productModel.discountedPrice.price).formatCurrency(),
              style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                    color: appConstants.primary1Color,
                  ),
            ),
            CommonWidget.sizedBox(width: 5),
            CommonWidget.commonText(
              text: double.parse(productModel.price).formatCurrency(),
              style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                    color: appConstants.default4Color,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: appConstants.default4Color,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            CommonWidget.imageBuilder(
              imageUrl: "assets/photos/svg/common/star_icon.svg",
              height: 8.r,
              color: appConstants.starRateColor,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: CommonWidget.commonText(
                text: "100",
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.starRateColor,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: CommonWidget.commonText(
                text: "(100)",
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.default3Color,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget moreDetails({required String description}) {
    return CommonWidget.commonText(
      text: description,
      maxLines: 10,
      style: Theme.of(context).textTheme.captionBookHeading.copyWith(
            color: appConstants.default3Color,
          ),
    );
  }

  Widget addItems({required BuildContext context}) {
    return BlocBuilder<CounterCubit, int>(
      bloc: counterCubit,
      builder: (context, state) {
        String total = (totalPrice * state).formatCurrency();
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: "$state Item : $total",
                    style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                          color: appConstants.primary1Color,
                        ),
                  ),
                  CommonWidget.container(
                    width: 100.w,
                    borderRadius: 10.r,
                    color: appConstants.secondary1Color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => state != 1 ? counterCubit.chanagePageIndex(index: state - 1) : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 11.h),
                            child: CommonWidget.container(
                              height: 20.h,
                              width: 25.w,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              color: appConstants.secondary1Color,
                              child: CommonWidget.imageBuilder(
                                imageUrl: "assets/photos/svg/common/minus_icon.svg",
                                color: appConstants.primary1Color,
                              ),
                            ),
                          ),
                        ),
                        AnimatedFlipCounter(
                          value: state,
                          fractionDigits: 0,
                          textStyle: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                color: appConstants.primary1Color,
                              ),
                        ),
                        InkWell(
                          onTap: () => counterCubit.chanagePageIndex(index: state + 1),
                          child: CommonWidget.container(
                            height: 20.h,
                            width: 25.w,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            color: appConstants.secondary1Color,
                            child: CommonWidget.imageBuilder(
                              imageUrl: "assets/photos/svg/common/plus_icon.svg",
                              color: appConstants.primary1Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => addThisItemClick(state: state),
                child: CommonWidget.container(
                  height: 45.h,
                  width: ScreenUtil().screenWidth * 0.5,
                  alignment: Alignment.center,
                  borderRadius: appConstants.buttonRadius,
                  color: appConstants.primary1Color,
                  child: CommonWidget.commonText(
                    text: TranslationConstants.add_this_item.translate(context),
                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(color: appConstants.buttonTextColor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addThisItemClick({required int state}) {
    int priceIndex = productModel.productQuantityAttributesPrice.indexWhere(
      (element) => listEquals(element.slugs, listOfProductCategoryType2),
    );
    ProductDataForCartModel model = ProductDataForCartModel(
      productId: productModel.id,
      productName: productModel.name,
      productPrice: productModel.productPrice,
      productAttributsId: productModel.productQuantityAttributesPrice.isEmpty
          ? 0
          : productModel.productQuantityAttributesPrice[priceIndex].id,
      slugs: productModel.productQuantityAttributesPrice.isEmpty
          ? []
          : List.generate(
              productModel.productQuantityAttributesPrice[priceIndex].slugs.length,
              (index) => productModel.productQuantityAttributesPrice[priceIndex].slugs[index],
            ),
      productSlugPrice: productModel.productQuantityAttributesPrice.isEmpty
          ? 0
          : productModel.productQuantityAttributesPrice[priceIndex].productPrice,
      totalProduct: state,
    );
    bool checkUpdate = false;
    for (var e in localCartDataStore) {
      if (listEquals(e.slugs, model.slugs)) {
        checkUpdate = true;
        break;
      } else {
        checkUpdate = false;
      }
    }
    if (checkUpdate) {
      int index = localCartDataStore.indexWhere((element) => listEquals(element.slugs, model.slugs));
      localCartDataStore[index] = model;
    } else {
      localCartDataStore.add(model);
    }
    cartCubit.addQuantityData(
      parms: AddProductMyCartParms(
        qty: model.totalProduct,
        productId: model.productId,
        productPriceId: model.productAttributsId,
      ),
    );
    bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
    bakeryBox.get(HiveConstants.CART_DATA_STORE);
    productListCubit.updateDataCubit.update();
    CommonRouter.pop();
  }

  Widget productCategoryList({required BuildContext context}) {
    return productModel.productQuantityAttributes.isEmpty && listOfProductCategoryType1.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              listOfProductCategoryType1.length,
              (mainIndex) {
                ProductQuantityAttributes model = productModel.productQuantityAttributes[mainIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.sizedBox(height: 10),
                    CommonWidget.commonText(
                      text: model.name.isNotEmpty ? model.name : "",
                      style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                    CommonWidget.sizedBox(height: 10),
                    CommonWidget.sizedBox(
                      height: 35,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.options.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          bool isCheckColor = listOfProductCategoryType1[mainIndex] == model.options[index].value;
                          return InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              updatecategoryType(
                                mainIndex: mainIndex,
                                model: model,
                                index: index,
                              );
                              productListCubit.updateDataCubit.update();
                            },
                            child: CommonWidget.container(
                              borderRadius: 50.r,
                              alignment: Alignment.center,
                              color: isCheckColor ? appConstants.secondary2Color : appConstants.textFiledColor,
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              margin: EdgeInsets.only(right: 10.w),
                              isBorder: true,
                              borderColor: isCheckColor ? appConstants.primary1Color : appConstants.default5Color,
                              child: CommonWidget.commonText(
                                text: model.options[index].value,
                                style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                      color: appConstants.default1Color,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            ),
          );
  }

  Widget bottomAddButton({
    required BuildContext context,
  }) {
    return CommonWidget.sizedBox(
      height: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonWidget.sizedBox(
            height: 10.h,
            child: const Divider(),
          ),
          Column(
            children: [
              addItems(context: context),
            ],
          ),
        ],
      ),
    );
  }

  Widget screenView({required BuildContext context}) {
    return Container(
      height: ScreenUtil().screenHeight * 0.7,
      alignment: Alignment.center,
      child: ListView(
        children: [
          imageView(productModel: productModel, visibleImage: widget.productDetailsArgs.visibleImage),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Visibility(
                  visible: widget.productDetailsArgs.visibleImage,
                  child: Column(
                    children: [
                      mainTitle(productModel: productModel),
                      CommonWidget.sizedBox(height: 5),
                      moreDetails(description: productModel.description),
                    ],
                  ),
                ),
              ),
              nameView(context: context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productCategoryList(context: context),
                    CommonWidget.sizedBox(height: 15),
                    CommonWidget.commonDashLine(),
                    CommonWidget.sizedBox(height: 10),
                    CommonWidget.commonText(
                      text: TranslationConstants.message.translate(context),
                      style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                    Column(
                      children: [
                        CommonWidget.textField(
                          context: context,
                          maxLength: 500,
                          textInputType: TextInputType.text,
                          onChanged: (v) => updateLength(length: v.length),
                          hintText: TranslationConstants.enter_your_message.translate(context),
                        ),
                        CommonWidget.sizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonWidget.commonText(
                              text: "$totalProductMessaeCharacters characters left",
                              style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget nameView({required BuildContext context}) {
    return Visibility(
      visible: !widget.productDetailsArgs.visibleImage,
      child: Column(
        children: [
          CommonWidget.sizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ScreenUtil().screenWidth * 0.7,
                  child: CommonWidget.commonText(
                    maxLines: 2,
                    text: productModel.name,
                    style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
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
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget productImageSlider({required ProductItem productModel, required CounterCubit counterCubit}) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: productModel.images.length,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              productListCubit.counterCubit.chanagePageIndex(index: index);
            },
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            initialPage: 0,
            autoPlayCurve: Curves.easeInOut,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          ),
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: 10.h,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(26.r), topRight: Radius.circular(26.r)),
                child: CommonWidget.imageBuilder(
                  imageUrl: productModel.images[itemIndex],
                  borderRadius: 15.r,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        BlocBuilder<CounterCubit, int>(
          bloc: productListCubit.counterCubit,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                productModel.images.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: CommonWidget.container(
                    height: 2.h,
                    width: 20.w,
                    borderRadius: appConstants.prductCardRadius,
                    color: state == index ? appConstants.primary1Color : appConstants.default7Color,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
