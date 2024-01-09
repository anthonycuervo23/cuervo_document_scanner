import 'dart:math';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_data_for_cart_model.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_model.dart';
import 'package:bakery_shop_flutter/features/products/domain/parms/product_data_args.dart';
import 'package:bakery_shop_flutter/features/products/domain/entities/product_data_entities.dart';
import 'package:bakery_shop_flutter/features/products/domain/usecases/product_data_usecases.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/update_data/update_data_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_list_state.dart';

enum ProductFilterEnum { pricing, bestseller, newarrival }
// enum ProductFilterEnum { pricing, rating, bestseller, newarrival, hotfavourite, seasonal }

class ProductListCubit extends Cubit<ProductListState> {
  final CounterCubit counterCubit;
  final CounterCubit quantityChangeCubit;
  final LoadingCubit loadingCubit;
  final GetProductData getProductData;

  final UpdateDataCubit updateDataCubit;
  ProductListCubit({
    required this.counterCubit,
    required this.quantityChangeCubit,
    required this.loadingCubit,
    required this.getProductData,
    required this.updateDataCubit,
  }) : super(ProductListInitalState());
  List<String> l1 = [];
  List<ProductFilterEnum> l2 = [];
  TextEditingController enterMessageController = TextEditingController();
  List productQuantityLis = [];
  List<String> filterValueList = List.generate(ProductFilterEnum.values.length, (index) => '');
  List<String> filterValue = ['', '', '', '', '', ''];
  List priceFilterList = ["Price : Low to High", "Price : High to Low"];

  void updateQuantity({required ProductListLoadedState state, required ProductItem productModel}) {
    List<ProductQuantityAttributesPrice> l1 = [];
    ProductItem model = productModel;
    for (var e in model.productQuantityAttributesPrice) {
      if (listEquals(state.listOfProductCategoryType1, e.slugs)) {
        l1.add(e);
      }
    }
    emit(state.copyWith(productQuantityList: l1, random: Random().nextDouble()));
  }

  void addData({required int total, required ProductListLoadedState state, required bool isIncrement}) {
    emit(state.copyWith(totalProduct: isIncrement ? total + 1 : total - 1, random: Random().nextDouble()));
  }

  void updateScreenData({required ProductListLoadedState state}) {
    // Future.delayed(const Duration(seconds: 3), () {
    //   loadingCubit.show();
    // List<ProductItem> data = commonUpdateData(data: state.productDataList);
    emit(state.copyWith(random: Random().nextDouble()));
    // });
  }

  void updatecategoryType({
    required ProductListLoadedState state,
    required int mainIndex,
    required ProductQuantityAttributes model,
    required int index,
  }) {
    List<String> tempList = [];
    List<String> tempList1 = [];
    tempList = state.listOfProductCategoryType1;
    tempList1 = state.listOfProductCategoryType2;
    tempList[mainIndex] = model.options[index].value;
    tempList1[mainIndex] = model.options[index].slug;
    emit(state.copyWith(
      listOfProductCategoryType1: tempList,
      listOfProductCategoryType2: tempList1,
      random: Random().nextDouble(),
    ));
  }

  void updateLength({required ProductListLoadedState state, required int length}) {
    emit(state.copyWith(totalProductMessaeCharacters: 500 - length, random: Random().nextDouble()));
  }

  List<ProductItem> commonUpdateData({required List<ProductItem> data}) {
    List<ProductItem> productItem = data;
    int item = 0;
    for (var e in productItem) {
      item = 0;
      if (myCartEntity != null) {
        for (var e1 in myCartEntity!.cart) {
          if (e.id == e1.product.id) {
            item += e1.qty;
            int index = productItem.indexWhere((element) => element.id == e.id);
            productItem[index] = productItem[index].copyWith(totalItem: item);
          }
        }
      }
    }
    loadingCubit.hide();
    return productItem;
  }

  Future<void> fetchProductData({
    required ProductDataParms argas,
    List<ProductFilterEnum>? selectedFilter,
    bool loaderShow = true,
    bool nextPageLoad = false,
  }) async {
    int pageNumber = 1;

    if (state is ProductListLoadedState && nextPageLoad) {
      pageNumber = ((state as ProductListLoadedState).productDataEntity.currentPage) + 1;
    } else {
      loadingCubit.show();
    }
    final Either<AppError, ProductDataEntity> response = await getProductData(
      ProductDataParms(
        categoryId: argas.categoryId,
        filterOrderBy: argas.filterOrderBy,
        page: pageNumber,
      ),
    );
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(ProductListErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (ProductDataEntity data) {
        loadingCubit.hide();
        List<ProductItem> productItem = commonUpdateData(data: data.productList);
        if (state is ProductListLoadedState) {
          var productListLoadedState = state as ProductListLoadedState;
          if (data.productList.isNotEmpty) {
            emit(
              productListLoadedState.copyWith(
                productDataList: productItem,
                selectedFilter: selectedFilter ?? [],
                totalProductMessaeCharacters: 500,
                random: Random().nextDouble(),
                productDataEntity: data,
                totalProduct: 1,
              ),
            );
          }
        } else {
          emit(
            ProductListLoadedState(
              listOfProductCategoryType1: const [],
              listOfProductCategoryType2: const [],
              productQuantityList: const [],
              productDataList: productItem,
              selectedFilter: selectedFilter ?? [],
              isProductAdded: false,
              quantityRadioGroup: 0,
              customizableItem: 0,
              totalCustomPrice: 0,
              totalProduct: 1,
              totalProductMessaeCharacters: 500,
              random: Random().nextDouble(),
              productDataEntity: data,
            ),
          );
        }
      },
    );
  }

  void removeFilter({
    required ProductFilterEnum item,
    required int categoryId,
    required int index,
    required ProductListLoadedState state,
  }) {
    List<ProductFilterEnum> selectedFilter = state.selectedFilter;
    if (item == ProductFilterEnum.newarrival) {
      l1.remove('new_arrival');
    } else if (item == ProductFilterEnum.bestseller) {
      l1.remove('best_seller');
    } else if (item == ProductFilterEnum.pricing) {
      for (var e in l1) {
        l1.remove(e);
      }
    }
    selectedFilter.remove(item);
    commonFilter(state: state, categoryId: categoryId, filterList: selectedFilter);
  }

  void filterApply({required ProductListLoadedState state, required String filter, required int categoryId}) {
    if (filter == "newarrival") {
      l1.remove('new_arrival');
      l2.add(ProductFilterEnum.newarrival);
      l1.add('new_arrival');
    } else if (filter == "bestseller") {
      l1.remove('best_seller');
      l2.add(ProductFilterEnum.bestseller);
      l1.add('best_seller');
    } else if (filter == "Price : Low to High") {
      l1.remove('price_asc');
      l2.add(ProductFilterEnum.pricing);
      l1.add('price_asc');
    } else if (filter == "Price : High to Low") {
      l1.remove('price_desc');
      l2.add(ProductFilterEnum.pricing);
      l1.add('price_desc');
    }
    commonFilter(
      state: state,
      categoryId: categoryId,
      filterList: l2,
    );
  }

  void commonFilter({
    required ProductListLoadedState state,
    required int categoryId,
    required List<ProductFilterEnum> filterList,
  }) {
    fetchProductData(
      loaderShow: true,
      nextPageLoad: false,
      argas: ProductDataParms(categoryId: categoryId, filterOrderBy: l1, page: 1),
      selectedFilter: filterList,
    );
  }

  void updateTotalProduct({required ProductListLoadedState state}) {
    state.copyWith(totalProduct: 1, random: Random().nextDouble());
  }

  void addThisItem({required ProductListLoadedState state, required ProductItem productModel}) {
    bool checkProductInCart = false;
    for (var e in localCartDataStore) {
      if (listEquals(e.slugs, state.listOfProductCategoryType2)) {
        checkProductInCart = true;
        break;
      } else {
        checkProductInCart = false;
      }
    }

    int slugsIndex = productModel.productQuantityAttributesPrice.indexWhere(
      (element) => listEquals(element.slugs, state.listOfProductCategoryType2),
    );
    if (checkProductInCart) {
      int index = localCartDataStore.indexWhere(
        (element) => listEquals(element.slugs, state.listOfProductCategoryType2),
      );
      if (productModel.productQuantityAttributesPrice.isNotEmpty) {
        ProductDataForCartModel model = ProductDataForCartModel(
          productId: productModel.id,
          productName: productModel.name,
          productPrice: double.parse(productModel.price),
          productAttributsId: productModel.productQuantityAttributesPrice[slugsIndex].id,
          slugs: List.generate(
            productModel.productQuantityAttributesPrice[slugsIndex].slugs.length,
            (index) => productModel.productQuantityAttributesPrice[slugsIndex].slugs[index],
          ),
          productSlugPrice: double.parse(productModel.productQuantityAttributesPrice[slugsIndex].price),
          totalProduct: localCartDataStore[index].totalProduct + state.totalProduct,
        );
        // cartCubit.addQuantityData(
        //   parms: AddProductMyCartParms(
        //     qty: model.totalProduct,
        //     productId: model.productId,
        //     productPriceId: model.productAttributsId == 0 ? null : model.productAttributsId,
        //   ),
        // );
        localCartDataStore[index] = model;
      } else {
        ProductDataForCartModel model = ProductDataForCartModel(
          productId: productModel.id,
          productName: productModel.name,
          productPrice: double.parse(productModel.price),
          productAttributsId: 0,
          slugs: [],
          productSlugPrice: 0,
          totalProduct: localCartDataStore[index].totalProduct + state.totalProduct,
        );
        // cartCubit.addQuantityData(
        //   parms: AddProductMyCartParms(
        //     qty: model.totalProduct,
        //     productId: model.productId,
        //     productPriceId: model.productAttributsId == 0 ? null : model.productAttributsId,
        //   ),
        // );
        localCartDataStore[index] = model;
      }
      bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
      bakeryBox.get(HiveConstants.CART_DATA_STORE);
    } else {
      if (productModel.productQuantityAttributesPrice.isNotEmpty) {
        ProductDataForCartModel model = ProductDataForCartModel(
          productId: productModel.id,
          productName: productModel.name,
          productPrice: double.parse(productModel.price),
          productAttributsId: productModel.productQuantityAttributesPrice[slugsIndex].id,
          slugs: List.generate(
            productModel.productQuantityAttributesPrice[slugsIndex].slugs.length,
            (index) => productModel.productQuantityAttributesPrice[slugsIndex].slugs[index],
          ),
          productSlugPrice: double.parse(productModel.productQuantityAttributesPrice[slugsIndex].price),
          totalProduct: state.totalProduct,
        );
        // cartCubit.addQuantityData(
        //   parms: AddProductMyCartParms(
        //     qty: model.totalProduct,
        //     productId: model.productId,
        //     productPriceId: model.productAttributsId == 0 ? null : model.productAttributsId,
        //   ),
        // );
        localCartDataStore.add(model);
      } else {
        ProductDataForCartModel model = ProductDataForCartModel(
          productId: productModel.id,
          productName: productModel.name,
          productPrice: double.parse(productModel.price),
          productAttributsId: 0,
          slugs: [],
          productSlugPrice: 0,
          totalProduct: state.totalProduct,
        );
        // cartCubit.addQuantityData(
        //   parms: AddProductMyCartParms(
        //     qty: model.totalProduct,
        //     productId: model.productId,
        //     productPriceId: model.productAttributsId == 0 ? null : model.productAttributsId,
        //   ),
        // );
        localCartDataStore.add(model);
      }
      bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
      bakeryBox.get(HiveConstants.CART_DATA_STORE);
    }

    // for (var e in localCartDataStore) {
    // cartCubit.addQuantityData(
    //   parms: AddProductMyCartParms(
    //     qty: e.totalProduct,
    //     productId: e.productId,
    //     productPriceId: e.productAttributsId == 0 ? null : e.productAttributsId,
    //   ),
    // );
    // }
    CommonRouter.pop();
  }

  void confirmAddData({
    required List<String> productIdList,
    required List<ProductDataForCartModel> localCartProduct1,
    required CartCubit cartCubit,
  }) {
    for (var e in productIdList) {
      List l1 = e.split('_');
      int index = localCartDataStore.indexWhere(
        (element) => element.productAttributsId == int.parse(l1[1]),
      );
      localCartDataStore.removeAt(index);
      bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
      bakeryBox.get(HiveConstants.CART_DATA_STORE);
    }
    for (var e in localCartProduct1) {
      ProductDataForCartModel model = ProductDataForCartModel(
        productId: e.productId,
        productName: e.productName,
        productPrice: e.productPrice,
        productAttributsId: e.productAttributsId,
        slugs: e.slugs,
        productSlugPrice: e.productSlugPrice,
        totalProduct: e.totalProduct,
      );
      int index = localCartDataStore.indexWhere((element) => listEquals(element.slugs, e.slugs));
      localCartDataStore[index] = model;
      // cartCubit.addQuantityData(
      //   parms: AddProductMyCartParms(
      //     qty: model.totalProduct,
      //     productId: model.productId,
      //     productPriceId: model.productAttributsId,
      //   ),
      // );
      bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
      bakeryBox.get(HiveConstants.CART_DATA_STORE);
    }
    CommonRouter.pop();
  }
}
