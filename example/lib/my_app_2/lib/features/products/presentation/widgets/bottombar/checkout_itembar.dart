import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_data_for_cart_model.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/update_data/update_data_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/animated_flip_counter.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutItemBar extends StatefulWidget {
  final double totalPrice;
  const CheckoutItemBar({super.key, required this.totalPrice});

  @override
  State<CheckoutItemBar> createState() => _CheckoutItemBarState();
}

class _CheckoutItemBarState extends State<CheckoutItemBar> {
  late UpdateDataCubit updateDataCubit;

  @override
  void initState() {
    updateDataCubit = getItInstance<UpdateDataCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDataCubit, double>(
      bloc: updateDataCubit,
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.commonText(
                      text: "${TranslationConstants.your_items.translate(context)} :",
                      style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                    CommonWidget.imageButton(
                      svgPicturePath: "assets/photos/svg/common/close_icon.svg",
                      onTap: () => CommonRouter.pop(),
                    ),
                  ],
                ),
              ),
              Divider(height: 1.h, color: appConstants.default7Color),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: localCartDataStore.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ProductDataForCartModel productData = localCartDataStore[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.commonText(
                                text: "${index + 1}.",
                                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                      color: appConstants.default1Color,
                                    ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidget.sizedBox(
                                    width: 200,
                                    child: CommonWidget.commonText(
                                      text: productData.productName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .captionMediumHeading
                                          .copyWith(color: appConstants.default1Color),
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  CommonWidget.sizedBox(
                                    width: ScreenUtil().screenWidth * 0.5,
                                    child: CommonWidget.commonText(
                                      maxLines: 2,
                                      text: productData.slugs.isEmpty
                                          ? CommonWidget.sringToCurrencyFormate(
                                              text: productData.productPrice,
                                            )
                                          : "${List.generate(
                                              productData.slugs.length,
                                              (index) => productData.slugs[index],
                                            )} - ${CommonWidget.sringToCurrencyFormate(
                                              text: productData.productPrice,
                                            )}",
                                      style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                            color: appConstants.default1Color,
                                          ),
                                    ),
                                  ),
                                  CommonWidget.commonText(
                                    text: TranslationConstants.edit.translate(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .captionMediumHeading
                                        .copyWith(color: appConstants.primary1Color),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CommonWidget.container(
                                    borderRadius: 8.r,
                                    width: 80.w,
                                    padding: EdgeInsets.symmetric(vertical: 5.h),
                                    color: appConstants.secondary2Color,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CommonWidget.sizedBox(
                                          height: 20,
                                          child: CommonWidget.imageButton(
                                            svgPicturePath: "assets/photos/svg/common/minus_icon.svg",
                                            color: appConstants.primary1Color,
                                            iconSize: 2.2.sp,
                                            onTap: () {
                                              ProductDataForCartModel model = ProductDataForCartModel(
                                                productId: productData.productId,
                                                productAttributsId: productData.productAttributsId,
                                                productName: productData.productName,
                                                productPrice: productData.productPrice,
                                                productSlugPrice: productData.productSlugPrice,
                                                slugs: productData.slugs,
                                                totalProduct: productData.totalProduct - 1,
                                              );
                                              if (model.totalProduct != 0) {
                                                localCartDataStore[index] = model;
                                              } else {
                                                localCartDataStore.removeAt(index);
                                              }
                                              bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
                                              bakeryBox.get(HiveConstants.CART_DATA_STORE);
                                              BlocProvider.of<CartCubit>(context).addQuantityData(
                                                parms: AddProductMyCartParms(
                                                  qty: model.totalProduct,
                                                  productId: model.productId,
                                                  productPriceId: model.productAttributsId,
                                                ),
                                              );
                                              updateDataCubit.update();
                                            },
                                          ),
                                        ),
                                        AnimatedFlipCounter(
                                          value: productData.totalProduct,
                                          textStyle: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                                color: appConstants.primary1Color,
                                              ),
                                        ),
                                        CommonWidget.imageButton(
                                          svgPicturePath: "assets/photos/svg/common/plus_icon.svg",
                                          color: appConstants.primary1Color,
                                          iconSize: 12.sp,
                                          onTap: () {
                                            ProductDataForCartModel model = ProductDataForCartModel(
                                              productId: productData.productId,
                                              productAttributsId: productData.productAttributsId,
                                              productName: productData.productName,
                                              productPrice: productData.productPrice,
                                              productSlugPrice: productData.productSlugPrice,
                                              slugs: productData.slugs,
                                              totalProduct: productData.totalProduct + 1,
                                            );
                                            localCartDataStore[index] = model;
                                            bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
                                            bakeryBox.get(HiveConstants.CART_DATA_STORE);
                                            BlocProvider.of<CartCubit>(context).addQuantityData(
                                              parms: AddProductMyCartParms(
                                                qty: model.totalProduct,
                                                productId: model.productId,
                                                productPriceId: model.productAttributsId,
                                              ),
                                            );
                                            updateDataCubit.update();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  CommonWidget.sizedBox(height: 10),
                                  CommonWidget.commonText(
                                    text: "${productData.totalProduct * productData.productPrice}",
                                    style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                          color: appConstants.primary1Color,
                                        ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: CommonWidget.container(
            color: appConstants.primary1Color,
            height: 50.h,
            isBorderOnlySide: true,
            topLeft: 15.r,
            topRight: 15.r,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidget.container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      CommonWidget.commonText(
                        text: "${localCartDataStore.length} ${TranslationConstants.item.translate(context)}",
                        style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                              color: appConstants.buttonTextColor,
                            ),
                      ),
                      VerticalDivider(
                        color: appConstants.buttonTextColor,
                        endIndent: 6.h,
                        indent: 6.h,
                        thickness: 1.1.w,
                      ),
                      CommonWidget.commonText(
                        text: CommonWidget.sringToCurrencyFormate(text: widget.totalPrice),
                        style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                              color: appConstants.buttonTextColor,
                              fontSize: 16.sp,
                            ),
                      ),
                      InkWell(
                        onTap: () => CommonRouter.pop(),
                        child: Container(
                          height: 100.h,
                          width: 15.w,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: CommonWidget.imageButton(
                            svgPicturePath: "assets/photos/svg/common/down_filled_arrow.svg",
                            iconSize: 6.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CommonWidget.textButton(
                  text: TranslationConstants.check_out.translate(context),
                  textStyle: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                        color: appConstants.buttonTextColor,
                      ),
                  onTap: () {
                    CommonRouter.popUntil(RouteList.app_home);
                    BlocProvider.of<CartCubit>(context).loadInitialData(isShowLoader: true);
                    BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(3);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
