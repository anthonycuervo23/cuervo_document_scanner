import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/expense_category_item_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/single_expenses/single_expense_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleExpensesScreen extends StatefulWidget {
  final ExpenseCategoryItemArgs args;
  const SingleExpensesScreen({super.key, required this.args});

  @override
  State<SingleExpensesScreen> createState() => _SingleExpensesScreenState();
}

class _SingleExpensesScreenState extends ExpensesWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      bloc: expensesCubit,
      builder: (context, state) {
        if (state is ExpensesLoadedState) {
          return Scaffold(
            appBar: appBar(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  expenseCategoryAndDate(state: state),
                  itemDetails(state: state),
                  CommonWidget.sizedBox(height: 20),
                  paymentMode(state: state),
                  CommonWidget.sizedBox(height: 15),
                  noteComments(state: state),
                  CommonWidget.sizedBox(height: 20),
                  attachedFile(state: state),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: bottomBarButton(state: state),
            ),
          );
        } else if (state is ExpensesLoadingState) {
          return CommonWidget.loadingIos();
        } else if (state is ExpensesErrorState) {
          return CommonWidget.commonText(text: state.errorMessage);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
