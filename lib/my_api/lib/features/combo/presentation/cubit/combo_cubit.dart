import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/combo/data/models/combo_model.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/combo_state.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ComboCubit extends Cubit<ComboState> {
  final ToggleCubit appLiveStatus;
  final CounterCubit counterCubit;
  final SortFilterCubit sortFilterCubit;
  ComboCubit({
    required this.appLiveStatus,
    required this.counterCubit,
    required this.sortFilterCubit,
  }) : super(ComboLoadedState(listOfCombo: comboOfferList));

  List<String> allValueList = ['', ''];

  TextEditingController searchController = TextEditingController();
  List<ComboModel> searchList = [];

  void searchFromComboList({required ComboLoadedState state, required String value}) {
    searchList = comboOfferList
        .where((element) => element.comboName.toLowerCase().contains(value.toLowerCase().trim()))
        .toList();
    emit(state.copyWith(listOfCombo: searchList, random: Random().nextDouble()));
  }

  void applyFilterButtonFilter({required String value}) {
    allValueList[0] = value;
  }
}
