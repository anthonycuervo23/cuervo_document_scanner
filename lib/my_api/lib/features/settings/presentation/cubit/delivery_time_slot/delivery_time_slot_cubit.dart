import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/settings/data/models/delivery_time_slot.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'delivery_time_slot_state.dart';

enum SelectedTab { standard, midnight, fixTime }

class DeliveryTimeSlotCubit extends Cubit<DeliveryTimeSlotState> {
  final LoadingCubit loadingCubit;

  DeliveryTimeSlotCubit({required this.loadingCubit})
      : super(
          const DeliveryTimeSlotLoadedState(selectedTab: SelectedTab.standard),
        );

  TextEditingController fromTimePickController = TextEditingController();
  TextEditingController toTimePickController = TextEditingController();

  void changeTabMode({required DeliveryTimeSlotLoadedState state, required int value}) {
    if (value == 0) {
      emit(state.copyWith(selectedTab: SelectedTab.standard));
    } else if (value == 1) {
      emit(state.copyWith(selectedTab: SelectedTab.midnight));
    } else if (value == 2) {
      emit(state.copyWith(selectedTab: SelectedTab.fixTime));
    }
  }

  void updateOrAddTimeSlot({
    required DeliveryTimeSlotLoadedState state,
    required int index,
    int? itemIndex,
  }) {
    if (fromTimePickController.text.isEmpty || toTimePickController.text.isEmpty) {
      return;
    }

    List<DeliveryTimeSlotModel>? targetList;

    switch (index) {
      case 0:
        targetList = state.standardTimeList;
        break;
      case 1:
        targetList = state.midNightTimeList;
        break;
      case 2:
        targetList = state.fixTimeList;
        break;
      default:
        return;
    }

    if (itemIndex != null && itemIndex < targetList!.length) {
      targetList[itemIndex] = DeliveryTimeSlotModel(
        toDate: toTimePickController.text,
        fromDate: fromTimePickController.text,
      );
    } else {
      targetList?.add(
        DeliveryTimeSlotModel(
          toDate: toTimePickController.text,
          fromDate: fromTimePickController.text,
        ),
      );
    }

    emit(
      state.copyWith(
        standardTimeList: index == 0 ? targetList : state.standardTimeList,
        fixTimeList: index == 2 ? targetList : state.fixTimeList,
        midNightTimeList: index == 1 ? targetList : state.midNightTimeList,
        random: Random().nextDouble(),
      ),
    );
  }

  void oldDataSet({
    required DeliveryTimeSlotLoadedState state,
    required int index,
    required int tabIndex,
  }) {
    emit(state.copyWith(isEdited: true, itemIndex: index));

    List<DeliveryTimeSlotModel>? targetList;

    switch (tabIndex) {
      case 0:
        targetList = state.standardTimeList;
        break;
      case 1:
        targetList = state.midNightTimeList;
        break;
      case 2:
        targetList = state.fixTimeList;
        break;
      default:
        return;
    }

    if (targetList != null && index < targetList.length) {
      fromTimePickController.text = targetList[index].fromDate;
      toTimePickController.text = targetList[index].toDate;
    }

    emit(
      state.copyWith(
        isEdited: state.isEdited,
        itemIndex: state.itemIndex,
        random: Random().nextDouble(),
      ),
    );
  }

  void deleteItem({
    required DeliveryTimeSlotLoadedState state,
    required int itemIndex,
    required int tabIndex,
  }) {
    if (tabIndex == 0) {
      state.standardTimeList?.removeAt(itemIndex);
    } else if (tabIndex == 1) {
      state.midNightTimeList?.removeAt(itemIndex);
    } else {
      state.fixTimeList?.removeAt(itemIndex);
    }

    emit(
      state.copyWith(
        fixTimeList: state.fixTimeList,
        midNightTimeList: state.midNightTimeList,
        standardTimeList: state.standardTimeList,
        random: Random().nextDouble(),
      ),
    );
  }

  void addNewButtonClick({required DeliveryTimeSlotLoadedState state}) {
    emit(state.copyWith(isEdited: false, random: Random().nextDouble()));

    fromTimePickController.clear();
    toTimePickController.clear();
    emit(state.copyWith(isEdited: state.isEdited, random: Random().nextDouble()));
  }
}
