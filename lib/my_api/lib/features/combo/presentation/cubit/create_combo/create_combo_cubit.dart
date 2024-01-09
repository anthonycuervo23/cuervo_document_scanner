import 'dart:io';
import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/combo/data/models/create_combo_model.dart/create_combo_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'create_combo_state.dart';

class CreateComboCubit extends Cubit<CreateComboState> {
  final LoadingCubit loadingCubit;
  final PickImageCubit pickImageCubitCubit;

  CreateComboCubit({required this.loadingCubit, required this.pickImageCubitCubit})
      : super(CreateComboLoadedState(
          searchedData: createComboList,
          random: 0.0,
          isSearchIsActive: false,
          selectedData: createComboList,
        ));
  File? imagePath;

  TextEditingController comboNameController = TextEditingController();
  TextEditingController comboAmountController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  DateTime? comboOfferStartDate;

  void initialState() {
    emit(CreateComboLoadedState(isSearchIsActive: false));
  }

  void searchProduct({required String searchText, required CreateComboLoadedState state}) {
    List<CreateComboModel> searchProductList = [];
    if (searchText.isNotEmpty) {
      for (var product in createComboList) {
        if (((product.productName).toLowerCase()).contains(searchText.toLowerCase().trim())) {
          searchProductList.add(product);
        }
      }
      emit(state.copyWith(random: Random().nextDouble(), searchedData: searchProductList));
    } else {
      emit(state.copyWith(random: Random().nextDouble(), searchedData: []));
    }
  }

  void selectProduct({required CreateComboModel createComboModel, required CreateComboLoadedState state}) {
    List<CreateComboModel> selectComboProductList = state.selectedData ?? [];
    selectComboProductList.add(createComboModel);
    emit(state.copyWith(random: Random().nextDouble(), selectedData: selectComboProductList));
  }

  void removeProduct({required CreateComboModel createComboModel, required CreateComboLoadedState state}) {
    List<CreateComboModel> selectComboProductList = state.selectedData ?? [];
    selectComboProductList.remove(createComboModel);
    emit(state.copyWith(random: Random().nextDouble(), selectedData: selectComboProductList));
  }
}
