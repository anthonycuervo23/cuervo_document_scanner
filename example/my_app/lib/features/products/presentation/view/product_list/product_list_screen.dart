import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/products/domain/parms/product_data_args.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/common_product_box.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/features/products/domain/args/product_category_args.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/view/product_list/product_list_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProductListScreen extends StatefulWidget {
  final ProductCategoryArgs productCategoryArgs;
  const ProductListScreen({super.key, required this.productCategoryArgs});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ProductListWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      bloc: productListCubit,
      builder: (context, state) {
        if (state is ProductListLoadedState) {
          return Scaffold(
            backgroundColor: appConstants.greyBackgroundColor,
            appBar: customAppBar(
              context,
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
                CommonRouter.pop();
              },
              title: widget.productCategoryArgs.categoryName.isEmpty
                  ? TranslationConstants.product.translate(context)
                  : widget.productCategoryArgs.categoryName,
            ),
            body: BlocBuilder<ProductListCubit, ProductListState>(
              bloc: productListCubit,
              builder: (context, state) {
                if (state is ProductListLoadedState) {
                  return state.productDataList.isEmpty
                      ? Center(
                          child: CommonWidget.dataNotFound(
                            context: context,
                            bgColor: appConstants.greyBackgroundColor,
                            onTap: () {
                              productListCubit.fetchProductData(
                                argas: ProductDataParms(
                                  categoryId: widget.productCategoryArgs.categroyId,
                                ),
                              );
                            },
                          ),
                        )
                      : Column(
                          children: [
                            CommonWidget.sizedBox(height: 5),
                            CommonWidget.container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              alignment: Alignment.centerLeft,
                              color: Colors.transparent,
                              child: sortingCategoryNew(state: state),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: LazyLoadScrollView(
                                  scrollDirection: Axis.vertical,
                                  onEndOfPage: () {
                                    if (state.productDataEntity.nextPageUrl.isNotEmpty) {
                                      productListCubit.fetchProductData(
                                        nextPageLoad: true,
                                        argas: ProductDataParms(
                                          categoryId: widget.productCategoryArgs.categroyId,
                                        ),
                                      );
                                    }
                                  },
                                  child: ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: state.productDataList.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return commonProductBox(
                                        index: index,
                                        cartCubit: cartCubit,
                                        productListCubit: productListCubit,
                                        productIndex: index,
                                        state: state,
                                        productModel: state.productDataList[index],
                                        context: context,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                } else if (state is ProductListLoadingState) {
                  return Center(child: CommonWidget.loadingIos());
                } else if (state is ProductListErrorState) {
                  return CommonWidget.dataNotFound(
                    context: context,
                    heading: TranslationConstants.something_went_wrong.translate(context),
                    subHeading: state.errorMessage,
                    buttonLabel: TranslationConstants.try_again.translate(context),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            bottomNavigationBar: localCartDataStore.isEmpty
                ? const SizedBox.shrink()
                : cartTotalCalculation(
                    context: context,
                  ),
          );
        } else if (state is ProductListLoadingState) {
          return CommonWidget.loadingIos();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
