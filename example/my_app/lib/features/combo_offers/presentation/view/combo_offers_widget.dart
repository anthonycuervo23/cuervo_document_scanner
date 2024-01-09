// ignore_for_file: use_build_context_synchronously

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/combo_offers/data/models/combo_offer_model.dart';
import 'package:bakery_shop_flutter/features/combo_offers/presentation/cubit/combo_offer_cubit.dart';
import 'package:bakery_shop_flutter/features/combo_offers/presentation/view/combo_offers_screen.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_data_for_cart_model.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/animated_flip_counter.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ComboOfferScreenWidget extends State<ComboOffersScreen> {
  late ComboOfferCubit comboOfferCubit;
  @override
  void initState() {
    comboOfferCubit = getItInstance<ComboOfferCubit>();
    comboOfferCubit.loadInitialData();
    super.initState();
  }

  @override
  void dispose() {
    comboOfferCubit.close();
    super.dispose();
  }

  Widget comboBox({
    required int index,
    required ComboProductModel productData,
    required ComboOfferLoadedState state,
    required ComboOfferCubit comboOfferCubit,
  }) {
    int selectedIndex = localCartDataStore.indexWhere((element) => element.productName == productData.name);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Material(
        shadowColor: appConstants.default11Color.withOpacity(0.2),
        borderOnForeground: true,
        elevation: 6,
        borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
        color: Colors.transparent,
        child: ClipPath(
          clipper: CuponClipper(holeRadius: 7.r),
          child: Container(
            decoration: BoxDecoration(
              color: appConstants.whiteBackgroundColor,
              borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
            ),
            padding: EdgeInsets.only(top: 3.h, bottom: 10.h, right: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              insetPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              content: SizedBox(
                                width: ScreenUtil().screenWidth * 0.9,
                                height: ScreenUtil().screenWidth * 0.8,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      child: Center(
                                        child: CarouselSlider.builder(
                                          itemCount: productData.images.length,
                                          options: CarouselOptions(
                                            onPageChanged: (index, reason) {
                                              comboOfferCubit.counterCubit.chanagePageIndex(index: index);
                                            },
                                            autoPlay: productData.images.length == 1 ? false : true,
                                            enlargeCenterPage: true,
                                            viewportFraction: 1,
                                            initialPage: 0,
                                            autoPlayCurve: Curves.easeInQuad,
                                            autoPlayInterval: const Duration(seconds: 4),
                                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                          ),
                                          itemBuilder: (context, itemIndex, pageViewIndex) {
                                            return ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(26.r),
                                                topRight: Radius.circular(26.r),
                                              ),
                                              child: CommonWidget.imageBuilder(
                                                imageUrl: productData.images[itemIndex],
                                                borderRadius: 15.r,
                                                width: ScreenUtil().screenWidth * 0.95,
                                                height: ScreenUtil().screenHeight * 0.5,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                        height: ScreenUtil().screenWidth * 0.35,
                                        child: BlocBuilder<CounterCubit, int>(
                                          bloc: comboOfferCubit.counterCubit,
                                          builder: (context, state) {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: List.generate(
                                                productData.images.length,
                                                (index) => Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                  child: CommonWidget.container(
                                                    height: 2.h,
                                                    width: 20.w,
                                                    borderRadius: appConstants.prductCardRadius,
                                                    color: state == index
                                                        ? appConstants.whiteBackgroundColor
                                                        : appConstants.default7Color,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.h, top: 10.h),
                        child: CommonWidget.imageBuilder(
                          imageUrl: productData.thumbnail,
                          width: 98.w,
                          height: 98.h,
                          fit: BoxFit.cover,
                          borderRadius: appConstants.prductCardRadius,
                        ),
                      ),
                    ),
                    comboOfferDetail(
                      productData: productData,
                      index: index,
                      state: state,
                      selectProductIndex: selectedIndex,
                      comboOfferCubit: comboOfferCubit,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  child: CommonWidget.commonDashLine(),
                ),
                bottomComboOfferDate(productData: productData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget comboOfferDetail({
    required ComboProductModel productData,
    required int index,
    required ComboOfferLoadedState state,
    required int selectProductIndex,
    required ComboOfferCubit comboOfferCubit,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: CommonWidget.commonText(
                text: productData.name,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CommonWidget.commonText(
                        textOverflow: TextOverflow.ellipsis,
                        text: '₹${productData.discountedPrice.price}',
                        style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                              height: 1,
                              color: appConstants.primary1Color,
                            ),
                      ),
                      CommonWidget.sizedBox(width: 10),
                      CommonWidget.commonText(
                        textOverflow: TextOverflow.ellipsis,
                        text: "₹${productData.price}",
                        style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                              color: appConstants.default4Color,
                              decorationColor: appConstants.default4Color,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => showAlertDialog(context: context, productData: productData),
                    child: CommonWidget.commonText(
                      text: TranslationConstants.more_detail.translate(context),
                      style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                            color: appConstants.default3Color,
                            decorationColor: appConstants.default3Color,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
                CommonWidget.container(
                  height: 30,
                  width: 90,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: selectProductIndex != -1
                      ? CommonWidget.container(
                          color: appConstants.primary1Color,
                          height: 50,
                          borderRadius: 5.r,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              minusButtton(
                                productData: productData,
                                index: index,
                                state: state,
                                selectProductIndex: selectProductIndex,
                                comboOfferCubit: comboOfferCubit,
                              ),
                              AnimatedFlipCounter(
                                value: localCartDataStore[selectProductIndex].totalProduct,
                                textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                      color: appConstants.buttonTextColor,
                                      fontSize: 14.sp,
                                    ),
                              ),
                              plusButton(
                                index: index,
                                productData: productData,
                                state: state,
                                selectProductIndex: selectProductIndex,
                                comboOfferCubit: comboOfferCubit,
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            ProductDataForCartModel model = ProductDataForCartModel(
                              productId: productData.id,
                              productName: productData.name,
                              productPrice: double.parse(productData.price.replaceAll(',', '')),
                              productAttributsId: 0,
                              slugs: [],
                              productSlugPrice: 0,
                              totalProduct: 1,
                            );
                            localCartDataStore.add(model);
                            bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
                            bakeryBox.get(HiveConstants.CART_DATA_STORE);
                            BlocProvider.of<CartCubit>(context).addQuantityData(
                              isCallGetCartApi: true,
                              parms: AddProductMyCartParms(qty: model.totalProduct, productId: model.productId),
                            );
                            comboOfferCubit.updateScreen(state: state);
                          },
                          child: CommonWidget.container(
                            height: 50,
                            color: appConstants.secondary2Color,
                            borderRadius: 5.r,
                            alignment: Alignment.center,
                            child: CommonWidget.commonText(
                              text: TranslationConstants.add.translate(context),
                              style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                    color: appConstants.primary1Color,
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

  Widget minusButtton({
    required int index,
    required ComboOfferLoadedState state,
    required int selectProductIndex,
    required ComboOfferCubit comboOfferCubit,
    required ComboProductModel productData,
  }) {
    return InkWell(
      onTap: () async {
        var data = await CommonWidget.showAlertDialog(
          context: context,
          text: TranslationConstants.delete_warning.translate(context),
        );

        if (data) {
          ProductDataForCartModel model = ProductDataForCartModel(
            productId: localCartDataStore[selectProductIndex].productId,
            productName: localCartDataStore[selectProductIndex].productName,
            productPrice: double.parse(productData.price.replaceAll(',', '')),
            productAttributsId: 0,
            slugs: [],
            productSlugPrice: 0,
            totalProduct: localCartDataStore[selectProductIndex].totalProduct - 1,
          );
          if (model.totalProduct == 0) {
            localCartDataStore.removeAt(selectProductIndex);
            BlocProvider.of<CartCubit>(context).addQuantityData(
              isCallGetCartApi: true,
              parms: AddProductMyCartParms(qty: 0, productId: productData.id),
            );
          } else {
            localCartDataStore[selectProductIndex] = model;
            BlocProvider.of<CartCubit>(context).addQuantityData(
              isCallGetCartApi: true,
              parms: AddProductMyCartParms(qty: model.totalProduct, productId: model.productId),
            );
          }
          bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
          bakeryBox.get(HiveConstants.CART_DATA_STORE);

          comboOfferCubit.updateScreen(state: state);
          // CommonRouter.pop();
        }
        comboOfferCubit.updateScreen(state: state);
      },
      child: CommonWidget.container(
        height: 20,
        width: 20,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        color: appConstants.primary1Color,
        child: CommonWidget.imageBuilder(
          imageUrl: "assets/photos/svg/common/minus_icon.svg",
        ),
      ),
    );
  }

  Widget plusButton({
    required int index,
    required ComboOfferLoadedState state,
    required int selectProductIndex,
    required ComboOfferCubit comboOfferCubit,
    required ComboProductModel productData,
  }) {
    return InkWell(
      onTap: () {
        ProductDataForCartModel model = ProductDataForCartModel(
          productId: localCartDataStore[selectProductIndex].productId,
          productName: localCartDataStore[selectProductIndex].productName,
          productPrice: double.parse(productData.price.replaceAll(',', '')),
          productAttributsId: 0,
          slugs: [],
          productSlugPrice: 0,
          totalProduct: localCartDataStore[selectProductIndex].totalProduct + 1,
        );
        localCartDataStore[selectProductIndex] = model;
        bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
        bakeryBox.get(HiveConstants.CART_DATA_STORE);
        BlocProvider.of<CartCubit>(context).addQuantityData(
          isCallGetCartApi: true,
          parms: AddProductMyCartParms(qty: model.totalProduct, productId: model.productId),
        );
        comboOfferCubit.updateScreen(state: state);
      },
      child: CommonWidget.container(
        height: 20,
        width: 20,
        color: appConstants.primary1Color,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: CommonWidget.imageBuilder(
          imageUrl: "assets/photos/svg/common/plus_icon.svg",
        ),
      ),
    );
  }

  Widget bottomComboOfferDate({required ComboProductModel productData}) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, bottom: 5.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${TranslationConstants.offer_date.translate(context)} : ",
                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                      color: appConstants.primary1Color,
                    ),
              ),
              TextSpan(
                text: productData.startDate,
                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              TextSpan(
                text: " ${TranslationConstants.to.translate(context)} ",
                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                      color: appConstants.primary1Color,
                    ),
              ),
              TextSpan(
                text: productData.endDate,
                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog({
    required BuildContext context,
    required ComboProductModel productData,
  }) {
    showDialog(
      context: context,
      barrierColor: appConstants.default2Color,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          surfaceTintColor: appConstants.whiteBackgroundColor,
          backgroundColor: appConstants.whiteBackgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          titlePadding: EdgeInsets.zero,
          title: Column(
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.only(left: 16.w, top: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.commonText(
                      text: TranslationConstants.combo_products.translate(context),
                      style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                    IconButton(
                      onPressed: () => CommonRouter.pop(),
                      icon: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/common/close_icon.svg",
                        height: 22.r,
                        width: 22.r,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 3.h, color: appConstants.default7Color),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                child: Column(
                  children: List.generate(
                    productData.relatedProducts.length,
                    (int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.commonText(
                              text: "${(index + 1)}.",
                              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                            CommonWidget.sizedBox(width: 5),
                            Expanded(
                              child: CommonWidget.commonText(
                                text: productData.relatedProducts[index].name,
                                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                      color: appConstants.default1Color,
                                    ),
                              ),
                            ),
                            CommonWidget.sizedBox(width: 30),
                            CommonWidget.commonText(
                              text: '₹${productData.relatedProducts[index].price}',
                              style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h, right: 8.w),
                  child: CommonWidget.commonDashLine(width: 80.w, color: appConstants.default7Color),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.h, right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonWidget.commonText(
                      text: '${TranslationConstants.total.translate(context)} : ',
                      style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                    CommonWidget.sizedBox(width: 15),
                    CommonWidget.commonText(
                      text: '₹${productData.price}',
                      style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CuponClipper extends CustomClipper<Path> {
  final double holeRadius;

  CuponClipper({
    required this.holeRadius,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    path
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    Path holePath = Path();
    int numberOfHoles = (size.width / (holeRadius * 2.5)).floor();

    for (int i = 9; i <= 17; i++) {
      holePath.addOval(
        Rect.fromCircle(
          center: Offset(
            (size.width / numberOfHoles) * i,
            -2,
          ),
          radius: holeRadius,
        ),
      );
    }
    for (int i = 2; i <= 10; i++) {
      holePath.addOval(
        Rect.fromCircle(
          center: Offset(
            (size.width / numberOfHoles) * i,
            size.height + 2,
          ),
          radius: holeRadius,
        ),
      );
    }

    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
