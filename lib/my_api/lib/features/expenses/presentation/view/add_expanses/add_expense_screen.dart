import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/add_expense_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/add_expanses/add_expense_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpansesScreen extends StatefulWidget {
  final AddExpenseScreenArgs args;
  const AddExpansesScreen({super.key, required this.args});

  @override
  State<AddExpansesScreen> createState() => _AddExpansesScreenState();
}

class _AddExpansesScreenState extends AddExpensesWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context),
      body: BlocBuilder<ExpensesCubit, ExpensesState>(
        bloc: expensesCubit,
        builder: (context, state) {
          if (state is ExpensesLoadedState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: screenView(state, context),
              ),
            );
          } else if (state is ExpensesLoadingState) {
            return CommonWidget.loadingIos();
          } else if (state is ExpensesErrorState) {
            return Center(child: CommonWidget.commonText(text: state.errorMessage));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
