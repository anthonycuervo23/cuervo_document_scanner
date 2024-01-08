import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:equatable/equatable.dart';

class AddExpenseScreenArgs extends Equatable {
  final AddExpenseNavigation navigateFrom;
  final SelectCategoryModel? selectCategoryModel;
  final int? itemsDetailsIndex;

  const AddExpenseScreenArgs({required this.navigateFrom, this.selectCategoryModel,this.itemsDetailsIndex});

  AddExpenseScreenArgs copyWith({
    AddExpenseNavigation? navigateFrom,
    SelectCategoryModel? selectCategoryModel,
    int? itemsDetailsIndex,
  }) {
    return AddExpenseScreenArgs(
      navigateFrom: navigateFrom ?? this.navigateFrom,
      selectCategoryModel: selectCategoryModel ?? this.selectCategoryModel,
      itemsDetailsIndex: itemsDetailsIndex ?? this.itemsDetailsIndex,
    );
  }

  @override
  List<Object?> get props => [navigateFrom, selectCategoryModel,itemsDetailsIndex];
}
