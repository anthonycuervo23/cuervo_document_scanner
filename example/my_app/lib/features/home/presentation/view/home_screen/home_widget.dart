import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/home/data/models/home_model.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/home_screen/home_screen.dart';
import 'package:bakery_shop_flutter/features/products/data/models/temp_product_model.dart';
import 'package:bakery_shop_flutter/features/products/domain/args/product_category_args.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class HomeScreenWidget extends State<HomeScreen> with WidgetsBindingObserver {
  ScrollController? scrollController;
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = getItInstance<HomeCubit>();
    homeCubit.loadData();
  }

  @override
  void dispose() {
    homeCubit.loadingCubit.hide();
    homeCubit.close();
    super.dispose();
  }

  Widget slider({required HomeLoadedState state}) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: state.homeDataEntity.banners.length,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              homeCubit.counterCubit.chanagePageIndex(index: index);
            },
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.0,
            initialPage: 0,
            autoPlayCurve: Curves.easeInOut,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          ),
          itemBuilder: (context, index, pageViewIndex) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              child: CommonWidget.imageBuilder(
                imageUrl: state.homeDataEntity.banners[index].banner,
                borderRadius: 15.r,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        BlocBuilder<CounterCubit, int>(
          bloc: homeCubit.counterCubit,
          builder: (context, counterState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.homeDataEntity.banners.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: CommonWidget.container(
                    height: 2.h,
                    width: 20.w,
                    borderRadius: appConstants.prductCardRadius,
                    color: counterState == index ? appConstants.primary1Color : appConstants.default7Color,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget category({required HomeLoadedState state}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.category.translate(context),
                style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(color: appConstants.default1Color),
              ),
              CommonWidget.textButton(
                text: TranslationConstants.view_all.translate(context),
                textStyle: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.primary1Color),
                onTap: () => CommonRouter.pushNamed(RouteList.product_category_screen),
              ),
            ],
          ),
        ),
        Row(
          children: [
            CommonWidget.sizedBox(
              height: 120,
              child: ListView.builder(
                primary: false,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                shrinkWrap: true,
                itemCount: state.homeDataEntity.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  CategoryDataModel model = state.homeDataEntity.categories[index];
                  return categoryProducts(model: model);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget banners({required HomeLoadedState state}) {
    return CommonWidget.sizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: state.homeDataEntity.categories.length,
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 20.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          CategoryDataModel model = state.homeDataEntity.categories[index];
          return InkWell(
            onTap: () {
              CommonRouter.pushNamed(
                RouteList.product_list_screen,
                arguments: ProductCategoryArgs(categroyId: model.id, categoryName: model.name),
              );
            },
            child: hotProductContainer(
              leftPadding: true,
              rightPadding: false,
              model: model,
            ),
          );
        },
      ),
    );
  }

  Widget bestproducts() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.best_product.translate(context),
                style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(color: appConstants.default1Color),
              ),
              CommonWidget.textButton(
                text: TranslationConstants.view_all.translate(context),
                textStyle: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.primary1Color),
                onTap: () {
                  CommonRouter.pushNamed(
                    RouteList.product_list_screen,
                    arguments: const ProductCategoryArgs(
                      categroyId: 0,
                      categoryName: '',
                    ),
                  );
                },
              )
            ],
          ),
        ),
        CommonWidget.sizedBox(
          height: 185,
          child: ListView.builder(
            itemCount: 5,
            primary: false,
            padding: EdgeInsets.only(right: 15.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              TempProductData data = categoriesAndProductList[0].productList[index];
              return Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  builder: (context, state) {
                    if (state is HomeLoadedState) {
                      return productContainer(
                        index: index,
                        isFavorite: data.isFavorite,
                        price: data.productQuantityList[0].price,
                        productName: data.productName,
                        rating: data.productRating.toString(),
                        ratingPeople: data.ratingPeopleCount.toString(),
                        imagePath: data.productImage,
                        onLikeButtonTap: () {
                          // homeCubit.changelike(product: data);
                        },
                        onTap: () {
                          // commonBottomSheet(
                          //   context: context,
                          //   bottomBarWidget: BlocBuilder<ProductListCubit, ProductListState>(
                          //     bloc: productListCubit,
                          //     builder: (context, productState) {
                          //       if (productState is ProductListLoadedState) {
                          //         // return ProductDetailsBar(productData: data, productState: productState);
                          //       }
                          //       return const SizedBox.shrink();
                          //     },
                          //   ),
                          //   height: 0.70.h,
                          // );
                        },
                      );
                    } else if (state is HomeLoadingState) {
                      return CommonWidget.loadingIos();
                    } else if (state is HomeErrorState) {
                      return CommonWidget.dataNotFound(
                        context: context,
                        heading: TranslationConstants.something_went_wrong.translate(context),
                        subHeading: state.errorMessage,
                        buttonLabel: TranslationConstants.try_again.translate(context),
                        // onTap: () => productCategoryCubit.getCategory(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget trendingproduct() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.trending_product.translate(context),
                style: Theme.of(context).textTheme.subTitle2BoldHeading,
              ),
              CommonWidget.textButton(
                text: TranslationConstants.view_all.translate(context),
                textStyle: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.primary1Color),
                onTap: () {
                  CommonRouter.pushNamed(
                    RouteList.product_list_screen,
                    arguments: const ProductCategoryArgs(
                      categroyId: 0,
                      categoryName: '',
                    ),
                  );
                },
              )
            ],
          ),
        ),
        CommonWidget.sizedBox(
          height: 185,
          child: ListView.builder(
            itemCount: categoriesAndProductList[1].productList.length,
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.only(right: 15.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              TempProductData data = categoriesAndProductList[1].productList[index];
              return Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: homeCubit,
                  builder: (context, state) {
                    return productContainer(
                      index: index,
                      isFavorite: data.isFavorite,
                      price: data.productQuantityList[0].price,
                      productName: data.productName,
                      rating: data.productRating.toString(),
                      ratingPeople: data.ratingPeopleCount.toString(),
                      imagePath: data.productImage,
                      onLikeButtonTap: () {
                        // homeCubit.changelike(product: data);
                      },
                      onTap: () {
                        // commonBottomSheet(
                        //   context: context,
                        //   bottomBarWidget: BlocBuilder<ProductListCubit, ProductListState>(
                        //     bloc: productListCubit,
                        //     builder: (context, productState) {
                        //       if (productState is ProductListLoadedState) {
                        //         // return ProductDetailsBar(productData: data, productState: productState);
                        //       }
                        //       return const SizedBox.shrink();
                        //     },
                        //   ),
                        //   height: 0.70.h,
                        // );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget categoryProducts({required CategoryDataModel model}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 7.w,
          ),
          child: GestureDetector(
            onTap: () {
              CommonRouter.pushNamed(
                RouteList.product_list_screen,
                arguments: ProductCategoryArgs(
                  categroyId: model.id,
                  categoryName: model.name,
                ),
              );
            },
            child: CommonWidget.imageBuilder(
              imageUrl: model.image,
              height: 80.h,
              width: 80.h,
              fit: BoxFit.cover,
              borderRadius: appConstants.prductCardRadius,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: CommonWidget.commonText(
            text: model.name,
            style: Theme.of(context).textTheme.captionBookHeading.copyWith(color: appConstants.default1Color),
          ),
        ),
      ],
    );
  }

  Widget productContainer({
    required int index,
    required bool isFavorite,
    required String productName,
    required String rating,
    required double price,
    required String imagePath,
    String? ratingPeople,
    VoidCallback? onTap,
    VoidCallback? onLikeButtonTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CommonWidget.container(
        borderRadius: appConstants.prductCardRadius,
        width: 145,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.r),
                child: Stack(
                  children: [
                    CommonWidget.imageBuilder(
                      imageUrl: imagePath,
                      borderRadius: appConstants.prductCardRadius - 2,
                      fit: BoxFit.cover,
                      height: 110.h,
                      width: 200,
                    ),
                    Positioned(
                      right: 3.w,
                      top: 3.h,
                      child: InkWell(
                        onTap: onLikeButtonTap,
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          alignment: Alignment.center,
                          child: CommonWidget.imageBuilder(
                            imageUrl: isFavorite == true
                                ? "assets/photos/svg/common/filled_heart_icon.svg"
                                : "assets/photos/svg/common/blank_heart_icon.svg",
                            height: 15.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CommonWidget.container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.commonText(
                    text: productName,
                    style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              CommonWidget.imageBuilder(
                                imageUrl: "assets/photos/svg/common/star_icon.svg",
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: CommonWidget.commonText(
                                  text: rating,
                                  style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                        color: appConstants.starRateColor,
                                      ),
                                ),
                              ),
                              CommonWidget.commonText(
                                text: '($ratingPeople)',
                                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                      color: appConstants.default3Color,
                                    ),
                              ),
                            ],
                          ),
                          CommonWidget.commonText(
                            text: price.formatCurrency(),
                            style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                  color: appConstants.default1Color,
                                ),
                          ),
                        ],
                      ),
                      CommonWidget.imageButton(
                        svgPicturePath: "assets/photos/svg/common/add_product_icon.svg",
                        iconSize: 22.h,
                        boxFit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hotProductContainer({
    required bool leftPadding,
    required bool rightPadding,
    required CategoryDataModel model,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding ? 22.w : 0.w, right: rightPadding ? 20.w : 0.w),
      child: CommonWidget.sizedBox(
        width: 210,
        child: Stack(
          children: [
            CommonWidget.sizedBox(
              width: 210,
              child: CommonWidget.imageBuilder(
                fit: BoxFit.cover,
                imageUrl: model.image,
                borderRadius: 15.r,
              ),
            ),
            Positioned(
              bottom: 0.h,
              child: Container(
                decoration: BoxDecoration(
                  color: appConstants.default3Color,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r),
                  ),
                ),
                width: 210.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonWidget.commonText(
                        text: model.name,
                        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                              color: appConstants.greyBackgroundColor,
                            ),
                      ),
                      CommonWidget.imageButton(
                        svgPicturePath: "assets/photos/svg/common/right_arrow.svg",
                        color: appConstants.buttonTextColor,
                        iconSize: 15.sp,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFeildView({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: GestureDetector(
        onTap: () => CommonRouter.pushNamed(RouteList.search_screen),
        child: CommonWidget.container(
          borderRadius: appConstants.buttonRadius,
          borderWidth: 10.h,
          borderColor: appConstants.default9Color,
          child: Row(
            children: [
              CommonWidget.container(
                color: Colors.transparent,
                padding: EdgeInsets.all(13.r),
                child: CommonWidget.imageBuilder(
                  imageUrl: "assets/photos/svg/common/search_icon.svg",
                  height: 18.sp,
                ),
              ),
              CommonWidget.sizedBox(width: 2),
              CommonWidget.commonText(
                text: TranslationConstants.looking_for_something_specific.translate(context),
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.default5Color,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
