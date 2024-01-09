import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/products/data/models/temp_product_model.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoveProductBar extends StatefulWidget {
  final TempProductData productData;
  final CartLoadedState state;
  const RemoveProductBar({super.key, required this.productData, required this.state});
  @override
  State<RemoveProductBar> createState() => _RemoveProductBarState();
}

class _RemoveProductBarState extends State<RemoveProductBar> {
  @override
  Widget build(BuildContext context) {
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
          Divider(height: 1.h, thickness: 0.8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.state.myCartData.cart.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                TempProductData productData = TempProductData(
                  productId: 1,
                  productImage: "",
                  productName: "productName",
                  isVegProduct: true,
                  productRating: 100,
                  productQuantityList: [],
                  ratingPeopleCount: 100,
                  isFavorite: false,
                  productCartCount: 100,
                  productCartPrice: 100,
                  selectedRedio: 0,
                  isBestSeller: true,
                );
                TempProductQuatityModel quatityModel = productData.productQuantityList[productData.selectedRedio];
                if (productData.productId == widget.productData.productId) {
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidget.sizedBox(
                                  width: 200,
                                  child: CommonWidget.commonText(
                                    text: productData.productName,
                                    style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                          color: appConstants.default1Color,
                                        ),
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    CommonWidget.commonText(
                                      text: "(${quatityModel.quantity} ${quatityModel.quantityType}) - ",
                                      style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                            color: appConstants.default1Color,
                                          ),
                                    ),
                                    CommonWidget.commonText(
                                      text: quatityModel.offerPrice.toString(),
                                      style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                            color: appConstants.default1Color,
                                          ),
                                    ),
                                  ],
                                ),
                                CommonWidget.commonText(
                                  text: TranslationConstants.edit.translate(context),
                                  style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                        color: appConstants.primary1Color,
                                      ),
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
                                      InkWell(
                                        onTap: () {
                                          // BlocProvider.of<TempCartCubit>(context)
                                          //     .removeProduct(productData: productData, index: index);
                                          // if (quatityModel.cartCounts == 0) {
                                          //   CommonRouter.pop();
                                          // }
                                        },
                                        child: Container(
                                          height: 25.h,
                                          width: 20.h,
                                          alignment: Alignment.center,
                                          child: CommonWidget.sizedBox(
                                            height: 20,
                                            child: CommonWidget.imageButton(
                                              svgPicturePath: "assets/photos/svg/common/minus_icon.svg",
                                              color: appConstants.primary1Color,
                                              iconSize: 2.2.sp,
                                              onTap: () {
                                                // BlocProvider.of<TempCartCubit>(context)
                                                //     .removeProduct(productData: productData, index: index);
                                                // if (quatityModel.cartCounts == 0) {
                                                //   CommonRouter.pop();
                                                // }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      CommonWidget.commonText(
                                        text: productData.productQuantityList[productData.selectedRedio].cartCounts
                                            .toString(),
                                        style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                              color: appConstants.primary1Color,
                                            ),
                                      ),
                                      CommonWidget.imageButton(
                                        svgPicturePath: "assets/photos/svg/common/plus_icon.svg",
                                        color: appConstants.primary1Color,
                                        iconSize: 12.sp,
                                        onTap: () {
                                          // if (productData.productQuantityList.length > 1) {
                                          //   BlocProvider.of<TempCartCubit>(context).addProduct(
                                          //     index: index,
                                          //     totalItem: (productData
                                          //             .productQuantityList[productData.selectedRedio].cartCounts +
                                          //         1),
                                          //     productData: productData,
                                          //   );
                                          // } else {
                                          //   BlocProvider.of<TempCartCubit>(context).addProduct(
                                          //     index: index,
                                          //     totalItem: 1,
                                          //     productData: productData,
                                          //   );
                                          // }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                CommonWidget.commonText(
                                  text: quatityModel.cartPrice.formatCurrency(),
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
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // Expanded(
          //   child: BlocBuilder<TempCartCubit, TempCartState>(
          //     builder: (context, state) {
          //       if (state is TempCartLoadedState) {
          //         return ;
          //       } else if (state is TempCartLoadingState) {
          //         return CommonWidget.loadingIos();
          //       } else if (state is TempCartErrorState) {
          //         return CommonWidget.dataNotFound(
          //           context: context,
          //           heading: TranslationConstants.something_went_wrong.translate(context),
          //           subHeading: state.errorMessage,
          //           buttonLabel: TranslationConstants.try_again.translate(context),
          //           // onTap: () => productCategoryCubit.getCategory(),
          //         );
          //       }
          //       return const SizedBox.shrink();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
