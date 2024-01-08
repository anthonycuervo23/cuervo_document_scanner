import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/expanses_category_list/expanses_category_list_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesCategoryListScreen extends StatefulWidget {
  const ExpensesCategoryListScreen({super.key});

  @override
  State<ExpensesCategoryListScreen> createState() => _ExpensesCategoryListScreenState();
}

class _ExpensesCategoryListScreenState extends ExpensesCategoryListWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.backGroundColor,
      appBar: appbar(),
      body: BlocBuilder<ExpensesCubit, ExpensesState>(
        bloc: expensesCubit,
        builder: (context, state) {
          if (state is ExpensesLoadedState) {
            return Column(
              children: [
                topBar(context: context),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.listOfExpansesCategory.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        child: GestureDetector(
                          onTap: () {
                            CommonRouter.pushNamed(
                              RouteList.expanses_category_item_screen,
                              arguments: state.listOfExpansesCategory[index],
                            );
                          },
                          child: categoryCommonBox(
                            index: index,
                            state: state,
                            model: state.listOfExpansesCategory[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ExpensesLoadingState) {
            return CommonWidget.loadingIos();
          } else if (state is ExpensesErrorState) {
            return CommonWidget.commonText(text: state.errorMessage);
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: bottomButton(context),
    );
  }
}
