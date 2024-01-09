import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/settings/data/models/point_wise_color_btn_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'point_wise_color_btn_state.dart';

class PointWiseColorBtnCubit extends Cubit<PointWiseColorBtnState> {
  final LoadingCubit loadingCubit;
  final CounterCubit counterCubit;
  PointWiseColorBtnCubit({
    required this.loadingCubit,
    required this.counterCubit,
  }) : super(const PointWiseColorBtnLoadedState(pointWiseColorBtnList: []));

  TextEditingController minimumPointController = TextEditingController();
  TextEditingController maximumPointController = TextEditingController();

  String convertColorString({required Color color}) {
    return '#${color.red.toRadixString(16).toUpperCase().padLeft(2, '0')}${color.green.toRadixString(16).toUpperCase().padLeft(2, '0')}${color.blue.toRadixString(16).toUpperCase().padLeft(2, '0')}${color.alpha.toRadixString(16).toUpperCase().padLeft(2, '0')}';
  }

  void onApplyClicked({required PointWiseColorBtnLoadedState state, Color? colors}) {
    Color? selectedColor = state.selectedColor;
    String? colorCode = state.colorCode;
    selectedColor = colors;
    if (selectedColor != null) {
      colorCode = convertColorString(color: selectedColor);
    }
    emit(
      state.copyWith(
        selectedColor: selectedColor,
        colorCode: colorCode,
        random: Random().nextDouble(),
      ),
    );
  }

  void addNew({required PointWiseColorBtnLoadedState state}) {
    bool? isEdited = state.isEdited;
    isEdited = false;
    if (minimumPointController.text.isNotEmpty && maximumPointController.text.isNotEmpty) {
      List<PointWiseColorBtnModel> pointWiseColorBtnList = state.pointWiseColorBtnList;
      pointWiseColorBtnList.add(
        PointWiseColorBtnModel(
          miniPoint: minimumPointController.text,
          maxPoint: maximumPointController.text,
          colorCode: state.colorCode!,
          seletcedColor: state.selectedColor!,
        ),
      );
      emit(
        state.copyWith(
          pointWiseColorBtnList: pointWiseColorBtnList,
          isEdited: isEdited,
          random: Random().nextDouble(),
        ),
      );
      maximumPointController.clear();
      minimumPointController.clear();
    }
  }

  void deleteItem({
    required PointWiseColorBtnLoadedState state,
    required List<PointWiseColorBtnModel> pointWiseColorBtnList,
    required int itemIndex,
  }) {
    pointWiseColorBtnList.removeAt(itemIndex);
    emit(
      state.copyWith(
        pointWiseColorBtnList: pointWiseColorBtnList,
        random: Random().nextDouble(),
      ),
    );
  }

  void editListItem({
    required PointWiseColorBtnLoadedState state,
    required int index,
    required List<PointWiseColorBtnModel> pointWiseColorBtnList,
  }) {
    bool? isEdited = state.isEdited;
    isEdited = false;
    pointWiseColorBtnList[index] = PointWiseColorBtnModel(
      miniPoint: minimumPointController.text,
      maxPoint: maximumPointController.text,
      colorCode: state.colorCode!,
      seletcedColor: state.selectedColor!,
    );

    emit(
      state.copyWith(
        isEdited: isEdited,
        pointWiseColorBtnList: pointWiseColorBtnList,
        random: Random().nextDouble(),
      ),
    );
    maximumPointController.clear();
    minimumPointController.clear();
  }

  void editButtonClick({required PointWiseColorBtnLoadedState state, required int index}) {
    maximumPointController.text = state.pointWiseColorBtnList[index].maxPoint;
    minimumPointController.text = state.pointWiseColorBtnList[index].miniPoint;
    emit(
      state.copyWith(
        colorCode: state.pointWiseColorBtnList[index].colorCode,
        selectedColor: state.pointWiseColorBtnList[index].seletcedColor,
        isEdited: true,
        index: index,
        random: Random().nextDouble(),
      ),
    );
  }
}
