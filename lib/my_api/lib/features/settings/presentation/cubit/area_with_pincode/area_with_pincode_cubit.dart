// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/settings/data/models/area_with_pincode_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'area_with_pincode_state.dart';

class AreaWithPincodeCubit extends Cubit<AreaWithPincodeState> {
  final LoadingCubit loadingCubit;
  AreaWithPincodeCubit({required this.loadingCubit}) : super(AreaWithPincodeLoadedState(areaWithPincodeList: []));

  TextEditingController areaNameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  void addNew({required AreaWithPincodeLoadedState state}) {
    bool? isEdited = state.isEdited;

    isEdited = false;

    if (areaNameController.text.isNotEmpty && pinCodeController.text.isNotEmpty) {
      List<AreaWithPincodeModel> areaWithPincodeList = state.areaWithPincodeList;

      state.areaWithPincodeList.add(
        AreaWithPincodeModel(
          areaName: areaNameController.text,
          pinCode: pinCodeController.text,
        ),
      );

      emit(state.copyWith(areaWithPincodeList: areaWithPincodeList, isEdited: isEdited, random: Random().nextDouble()));

      areaNameController.clear();
      pinCodeController.clear();
    }
  }

  editListItem(
      {required AreaWithPincodeLoadedState state,
      required int itemIndex,
      required List<AreaWithPincodeModel> areaWithPincodeList}) {
    bool? isEdited = state.isEdited;

    isEdited = false;

    areaWithPincodeList[itemIndex] = AreaWithPincodeModel(
      areaName: areaNameController.text,
      pinCode: pinCodeController.text,
    );

    emit(state.copyWith(isEdited: isEdited, areaWithPincodeList: areaWithPincodeList, random: Random().nextDouble()));
    areaNameController.clear();
    pinCodeController.clear();
  }

  void deleteItem({
    required AreaWithPincodeLoadedState state,
    required List<AreaWithPincodeModel> areaWithPincodeList,
    required int itemIndex,
  }) {
    areaWithPincodeList.removeAt(itemIndex);

    emit(state.copyWith(areaWithPincodeList: areaWithPincodeList, random: Random().nextDouble()));
  }

  void editButtonClick({required AreaWithPincodeLoadedState state, required int index}) {
    state.isEdited = true;

    areaNameController.text = state.areaWithPincodeList[index].areaName;
    pinCodeController.text = state.areaWithPincodeList[index].pinCode;

    emit(state.copyWith(isEdited: state.isEdited, random: Random().nextDouble()));
  }
}
