// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'add_return_order_state.dart';

class AddReturnOrderCubit extends Cubit<AddReturnOrderState> {
  final CounterCubit counterCubit;
  final LoadingCubit loadingCubit;
  AddReturnOrderCubit({required this.counterCubit, required this.loadingCubit})
      : super(AddReturnOrderLoadedState(removeItemList: ['']));

  TextEditingController orderIdController = TextEditingController();
  TextEditingController dateOfPurchasesController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController reasonOfReturnController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String formattedDate = '';

  void selectDateofPurchase({DateTime? date}) {
    var loadedState = state as AddReturnOrderLoadedState;
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    formattedDate = formatter.format(date!);

    dateOfPurchasesController.text = formattedDate;

    emit(loadedState.copyWith(random: Random().nextDouble()));
  }

  void selectReturnDate({DateTime? date}) {
    var loadedState = state as AddReturnOrderLoadedState;
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    formattedDate = formatter.format(date!);

    returnDateController.text = formattedDate;

    emit(loadedState.copyWith(random: Random().nextDouble()));
  }

  void addReturnItem() {
    var loadedState = state as AddReturnOrderLoadedState;

    loadedState.removeItemList!.add('');

    emit(loadedState.copyWith(removeItemList: loadedState.removeItemList, random: Random().nextDouble()));
  }
}
