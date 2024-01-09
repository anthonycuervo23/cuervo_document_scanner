import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/features/products/domain/parms/product_data_args.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/checkout_itembar.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/price_filter_options.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/common_product_box.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/view/product_list/product_list_screen.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ProductListWidget extends State<ProductListScreen> {
  late ProductListCubit productListCubit;
  late CartCubit cartCubit;
  @override
  void initState() {
    productListCubit = getItInstance<ProductListCubit>();
    cartCubit = BlocProvider.of<CartCubit>(context);
    productListCubit.fetchProductData(
      argas: ProductDataParms(categoryId: widget.productCategoryArgs.categroyId),
      selectedFilter: [],
    );
    super.initState();
  }

  @override
  void dispose() {
    productListCubit.loadingCubit.hide();
    productListCubit.close();
    super.dispose();
  }

  Widget cartTotalCalculation({required BuildContext context}) {
    double totalPrice = 00;
    for (var e in localCartDataStore) {
      double total = e.productPrice * e.totalProduct;
      totalPrice += total;
    }
    return BlocBuilder<CartCubit, CartState>(
      bloc: cartCubit,
      builder: (context, state) {
        if (state is CartLoadedState) {
          return Visibility(
            visible: state.myCartData.cart.isNotEmpty,
            child: CommonWidget.container(
              color: appConstants.primary1Color,
              height: 50.h,
              isBorderOnlySide: true,
              topLeft: 15.r,
              topRight: 15.r,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.container(
                    color: appConstants.primary1Color,
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
                          text: CommonWidget.sringToCurrencyFormate(text: totalPrice),
                          style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                                color: appConstants.buttonTextColor,
                              ),
                        ),
                        InkWell(
                          onTap: () => commonBottomSheet(
                            context: context,
                            bottomBarWidget: CheckoutItemBar(totalPrice: totalPrice),
                            height: ScreenUtil().screenHeight * 0.7,
                          ),
                          child: Container(
                            height: 100.h,
                            width: 15.w,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CommonWidget.imageButton(
                              svgPicturePath: "assets/photos/svg/common/up_filled_arrow.svg",
                              iconSize: 6.r,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CommonWidget.textButton(
                    text: TranslationConstants.check_out.translate(context),
                    textStyle: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                          color: appConstants.buttonTextColor,
                        ),
                    onTap: () {
                      for (var e in localCartProduct) {
                        int index = localCartProduct.indexWhere((element) => element.productId == e.productId);
                        localCartDataStore[index] = e;
                        cartCubit.addQuantityData(
                          isLoaderShow: true,
                          isCallGetCartApi: true,
                          parms: AddProductMyCartParms(
                            qty: e.totalProduct,
                            productId: e.productId,
                          ),
                        );
                      }
                      CommonRouter.popUntil(RouteList.app_home);
                      BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(3);
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget sortingCategoryNew({required ProductListLoadedState state}) {
    return ListView.builder(
      itemCount: ProductFilterEnum.values.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        ProductFilterEnum item = ProductFilterEnum.values[index];
        return commonSortingButton(
          state: state,
          text: item.name.translate(context),
          color: state.selectedFilter.contains(item) ? appConstants.secondary2Color : appConstants.textFiledColor,
          borderColor: state.selectedFilter.contains(item) ? appConstants.primary1Color : appConstants.default5Color,
          visible: state.selectedFilter.contains(item),
          onTap: () async {
            if (item == ProductFilterEnum.pricing) {
              await commonBottomSheet(
                height: 250.h,
                context: context,
                bottomBarWidget: PriceFilterOptions(
                  categoryId: widget.productCategoryArgs.categroyId,
                  state: state,
                  productListCubit: productListCubit,
                ),
              );
            } else {
              if (state.selectedFilter.contains(item) == false) {
                productListCubit.filterApply(
                  state: state,
                  filter: item.name,
                  categoryId: widget.productCategoryArgs.categroyId,
                );
              }
            }
          },
          onTapDeleteIcon: () => productListCubit.removeFilter(
            index: index,
            categoryId: widget.productCategoryArgs.categroyId,
            state: state,
            item: item,
          ),
        );
      },
    );
  }

  Widget commonSortingButton({
    required String text,
    required VoidCallback onTap,
    required ProductListLoadedState state,
    Color? color,
    Color? borderColor,
    bool? visible,
    VoidCallback? onTapDeleteIcon,
  }) {
    // return Padding(
    //   padding: EdgeInsets.fromLTRB(5.w, 14.h, 5.w, 0.h),
    //   child: GestureDetector(
    //     onTap: onTap,
    //     child: CommonWidget.container(
    //       color: color,
    //       height: 50.h,
    //       borderColor: borderColor,
    //       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
    //       borderRadius: 50.r,
    //       isBorder: true,
    //       child: Row(
    //         children: [
    //           CommonWidget.commonText(
    //             text: text,
    //             style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
    //           ),
    //           Visibility(
    //             visible: visible ?? (false),
    //             child: GestureDetector(
    //               onTap: onTapDeleteIcon,
    //               child: Padding(
    //                 padding: EdgeInsets.only(left: 5.w),
    //                 child: CommonWidget.imageButton(
    //                   svgPicturePath: "assets/photos/svg/common/close_icon.svg",
    //                   color: appConstants.primary1Color,
    //                   iconSize: 15.sp,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: GestureDetector(
        onTap: onTap,
        child: CommonWidget.container(
          color: color,
          height: 50.h,
          borderColor: borderColor,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          borderRadius: 50.r,
          isBorder: true,
          child: Row(
            children: [
              CommonWidget.commonText(
                text: text,
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
              ),
              Visibility(
                visible: visible ?? (false),
                child: GestureDetector(
                  onTap: onTapDeleteIcon,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: CommonWidget.imageButton(
                      svgPicturePath: "assets/photos/svg/common/close_icon.svg",
                      color: appConstants.primary1Color,
                      iconSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
