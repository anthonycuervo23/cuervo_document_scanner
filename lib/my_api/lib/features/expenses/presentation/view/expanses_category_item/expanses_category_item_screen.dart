import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/expanses_category_item/expanses_category_item_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpansesCategoryItemScreen extends StatefulWidget {
  final SelectCategoryModel selectCategoryModel;
  const ExpansesCategoryItemScreen({super.key, required this.selectCategoryModel});

  @override
  State<ExpansesCategoryItemScreen> createState() => _ExpansesCategoryItemScreenState();
}

class _ExpansesCategoryItemScreenState extends ExpansesCategoryItemWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      bloc: expensesCubit,
      builder: (context, state) {
        if (state is ExpensesLoadedState) {
          return Scaffold(
            appBar: appBar(model: selectCategoryModel, state: state),
            backgroundColor: appConstants.backGroundColor,
            body: Column(
              children: [
                totalExpensesAndTextField(context: context),
                CommonWidget.sizedBox(height: 10),
                listOfCategoryItem(selectCategoryModel: selectCategoryModel),
              ],
            ),
            bottomNavigationBar: bottomButton(context: context),
          );
        } else if (state is ExpensesLoadingState) {
          return CommonWidget.loadingIos();
        } else if (state is ExpensesErrorState) {
          return Center(child: CommonWidget.commonText(text: state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
