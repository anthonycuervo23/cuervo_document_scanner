import 'dart:math';

import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'expenses_state.dart';

//TODO: Screen pamane alag alag Cubit Leva

class ExpensesCubit extends Cubit<ExpensesState> {
  final PickImageCubit pickImageCubitCubit;
  final CounterCubit counterCubit;
  final LoadingCubit loadingCubit;

  bool switchButton = false;
  List<ItemListModel> listOfItem = [];

  ExpensesCubit({required this.pickImageCubitCubit, required this.counterCubit, required this.loadingCubit})
      : super(const ExpenseInitialState());

  void loaded() {
    emit(ExpensesLoadedState(
      categoryTypeController: TextEditingController(),
      dispalyBankName: false,
      dispalyCategory: false,
      selctedCategoryIndex: 0,
      selectedBankIndex: 0,
      searchedCategory: availableExpenseCategory,
      listOfExpansesCategory: listOfExpanses,
      payMentType: PayMentType.Cash,
      listOfItem: [
        ItemListModel(
          itemController: TextEditingController(),
          qtyController: TextEditingController(),
          amountController: TextEditingController(),
        ),
      ],
    ));
  }

  void changeSwitchButton({required ExpensesLoadedState state}) {
    switchButton = !switchButton;
    emit(state.copyWith(random: Random().nextDouble()));
  }

  void changePaymentType({required ExpensesLoadedState state, required int index}) {
    emit(state.copyWith(payMentType: PayMentType.values[index], random: Random().nextDouble()));
  }

  void changeBankChekBox({
    required bool value,
    required ExpensesLoadedState state,
    required int index,
    required bool bankStatus,
  }) {
    emit(state.copyWith(selectedBankIndex: index, random: Random().nextDouble(), dispalyBankName: bankStatus));
  }

  void changeCategory({int? index, required ExpensesLoadedState state, required String categoryType}) {
    emit(
      state.copyWith(
        selctedCategoryIndex: index,
        dispalyCategory: true,
        categoryTypeController: TextEditingController(text: categoryType),
      ),
    );
  }

  void expensesEdit({required ExpensesLoadedState state, required SelectCategoryModel selectCategoryModel}) {
    emit(state.copyWith(random: Random().nextDouble()));
  }

  void addItem({required ExpensesLoadedState state, required int index, required BuildContext context}) {
    List<ItemListModel> listOfItem = state.listOfItem;
    bool addData = true;
    bool itemData = true;
    bool qtyData = true;
    bool amountData = true;
    if (listOfItem.isNotEmpty) {
      for (var value in listOfItem) {
        if (value.itemController.text.isEmpty) {
          itemData = false;
          addData = false;
        } else if (value.qtyController.text.isEmpty) {
          qtyData = false;
          addData = false;
        } else if (value.amountController.text.isEmpty) {
          amountData = false;
          addData = false;
        }
      }
    } else {
      addData = false;
      itemData = false;
      qtyData = false;
      amountData = false;
    }
    if (addData) {
      listOfItem.add(
        ItemListModel(
          itemController: TextEditingController(),
          qtyController: TextEditingController(),
          amountController: TextEditingController(),
        ),
      );
    } else {
      if (itemData == false) {
        reusedSnakeBar(message: TranslationConstants.require_item_message.translate(context));
      } else if (qtyData == false) {
        reusedSnakeBar(message: TranslationConstants.require_qty_message.translate(context));
      } else if (amountData == false) {
        reusedSnakeBar(message: TranslationConstants.require_amt_message.translate(context));
      } else {
        reusedSnakeBar(message: TranslationConstants.require_data_message.translate(context));
      }
    }
    emit(state.copyWith(listOfItem: listOfItem, random: Random().nextDouble()));
  }

  void removeItem({required ExpensesLoadedState state, required int index}) {
    List<ItemListModel> listOfItem = state.listOfItem;
    if (listOfItem.length > 1) {
      listOfItem.removeAt(index);
    } else if (index == 0 && listOfItem.length == 1) {
      listOfItem[index].amountController.clear();
      listOfItem[index].itemController.clear();
      listOfItem[index].qtyController.clear();
    }
    emit(state.copyWith(listOfItem: listOfItem, random: Random().nextDouble()));
  }

  void reusedSnakeBar({required message}) {
    CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: message);
  }

  void loadAddExpenseScreenData({
    required AddExpenseNavigation navigationFrom,
    required List<ItemDetailModel?>? itemsData,
    required int index,
    required PayMentType? payMentType,
  }) {
    ExpensesLoadedState? state = getState();
    if (navigationFrom == AddExpenseNavigation.edit) {
      List<ItemListModel> dataToLoad = [];
      if (itemsData != null) {
        for (var value in itemsData) {
          ItemListModel data = ItemListModel(
            itemController: TextEditingController(text: value!.itemList[index].itemName),
            qtyController: TextEditingController(text: value.itemList[index].itemQty),
            amountController: TextEditingController(text: value.itemList[index].itemRate),
          );
          dataToLoad.add(data);
        }
      }
      if (state is ExpensesLoadedState) {
        emit(state.copyWith(listOfItem: dataToLoad, payMentType: payMentType));
      }
    }
  }

  void changeCategoryNameAanType({
    required ExpensesLoadedState state,
    required SelectCategoryModel selectCategoryModel,
    required String categoryName,
    required String categoryType,
  }) {
    selectCategoryModel.category = ExpenseCategory(categoryName: categoryName, categoryType: categoryType);
    emit(state.copyWith(random: Random().nextDouble()));
  }

  void searchFromcategory({
    required ExpensesLoadedState state,
    required String searchedData,
    required bool categoryStatus,
  }) {
    List<ExpenseCategory> searchedResult = [];
    if (searchedData.isNotEmpty) {
      for (var value in availableExpenseCategory) {
        if (value.categoryName.toString().toLowerCase().contains(searchedData.toLowerCase().trim()) ||
            value.categoryType.toString().toLowerCase().contains(searchedData.toLowerCase().trim())) {
          searchedResult.add(value);
        }
      }
    }
    if (searchedResult.isEmpty && searchedData.isEmpty) {
      searchedResult.addAll(availableExpenseCategory);
    }
    emit(state.copyWith(
      searchedCategory: searchedResult,
      selctedCategoryIndex: categoryStatus ? null : availablCategoryType.length + 1,
      dispalyCategory: categoryStatus,
    ));
  }

  ExpensesLoadedState? getState() {
    if (state is ExpensesLoadedState) {
      return state as ExpensesLoadedState;
    }
    return null;
  }

  void reloadScreen({required ExpensesLoadedState state}) {
    emit(state.copyWith(random: Random().nextDouble()));
  }

  void clearAddScreenData() {
    ExpensesLoadedState? state = getState();
    List<ItemListModel> dataToLoad = [
      ItemListModel(
        itemController: TextEditingController(),
        qtyController: TextEditingController(),
        amountController: TextEditingController(),
      )
    ];
    if (state is ExpensesLoadedState) {
      emit(state.copyWith(
        listOfItem: dataToLoad,
        payMentType: PayMentType.Cash,
        dispalyBankName: false,
        dispalyCategory: false,
        categoryTypeController: TextEditingController(text: ""),
      ));
    }
  }
}
