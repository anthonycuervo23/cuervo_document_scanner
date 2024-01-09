import 'dart:math';

import 'package:bakery_shop_flutter/features/products/data/models/temp_product_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchLoadedState(searcheditems: []));
  TextEditingController searchNameController = TextEditingController();
  List<TempProductData> templist = [];

  void searchitem({required String searchText, required SearchLoadedState state}) {
    templist = [];
    if (searchText.isNotEmpty) {
      for (var tempProduct in categoriesAndProductList[1].productList) {
        if (((tempProduct.productName).toLowerCase()).contains(searchText.toLowerCase().trim())) {
          templist.add(tempProduct);
        }
      }
      emit(state.copyWith(searcheditems: templist, issuffixShow: true, random: Random().nextDouble()));
    } else {
      emit(state.copyWith(searcheditems: const [], issuffixShow: false, random: Random().nextDouble()));
    }
  }

  void changeLikes({required int index}) {
    templist[index].isFavorite = !templist[index].isFavorite;
    emit(SearchLoadedState(searcheditems: templist, random: Random().nextDouble()));
  }
}
