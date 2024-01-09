import 'dart:math';

import 'package:bakery_shop_flutter/features/products/data/models/temp_product_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'my_favorite_state.dart';

class MyFavoriteCubit extends Cubit<MyFavoriteState> {
  MyFavoriteCubit() : super(const MyFavoriteInitialState());

  TextEditingController searchController = TextEditingController();

  void myFavoriteLoadData() {
    emit(const MyFavoriteLoadingState());
    List<TempProductData> tempList = favoriteProductList;
    emit(MyFavoriteLoadedState(productList: tempList));
  }

  void deleteFavoriteItem({
    required MyFavoriteLoadedState state,
    required TempProductData productData,
  }) {
    List<TempProductData> tempList = favoriteProductList;
    productData.isFavorite = false;

    tempList.remove(productData);

    emit(state.copyWith(productList: tempList, random: Random().nextDouble()));
  }

  void searchProduct({
    required List<TempProductData> productList,
    required String textFieldValue,
    required MyFavoriteLoadedState state,
  }) {
    List<TempProductData> searchProductList = [];
    List<TempProductData> tempList = favoriteProductList;

    if (searchController.text.isNotEmpty) {
      searchProductList = tempList
          .where((element) => element.productName.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();

      emit(state.copyWith(productList: searchProductList, random: Random().nextDouble()));
    } else {
      emit(state.copyWith(productList: favoriteProductList, random: Random().nextDouble()));
    }
  }

  void clearFilter({required MyFavoriteLoadedState state}) {
    searchController.clear();
    emit(state.copyWith(productList: favoriteProductList));
  }
}
