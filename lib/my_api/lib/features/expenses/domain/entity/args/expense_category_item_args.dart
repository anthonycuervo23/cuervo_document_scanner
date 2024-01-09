import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:equatable/equatable.dart';

class ExpenseCategoryItemArgs extends Equatable {
  final int index;
  final SelectCategoryModel selectCategoryModel;

  const ExpenseCategoryItemArgs({required this.index, required this.selectCategoryModel});

  @override
  List<Object?> get props => [index, selectCategoryModel];

  ExpenseCategoryItemArgs copyWith({
    int? index,
    SelectCategoryModel? selectCategoryModel,
  }) {
    return ExpenseCategoryItemArgs(
      index: index ?? this.index,
      selectCategoryModel: selectCategoryModel ?? this.selectCategoryModel,
    );
  }
}
