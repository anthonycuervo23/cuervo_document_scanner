import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_textfeild_filter_button.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/search_filter_dialog.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/cubit/supplier_cubit/supplier_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/pages/supplier_view/supplier_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends SupplierWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appConstants.backGroundColor,
        appBar: appbar(context),
        body: BlocBuilder<SupplierCubit, SupplierState>(
          bloc: supplierCubit,
          builder: (context, state) {
            if (state is SupplierLoadedState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    commonSearchAndFilterField(
                      controller: supplierCubit.searchController,
                      onChanged: (v) => supplierCubit.filterForSearch(value: v, state: state),
                      context: context,
                      onTapForFilter: () => Future.delayed(
                        const Duration(milliseconds: 0),
                        () async {
                          // FocusNode focusNode = FocusNode().of;
                          var value = await sortFilterDialogs(
                                context: context,
                                counterCubit: supplierCubit.counterCubit,
                                sortFilterCubit: supplierCubit.sortFilterCubit,
                              ) ??
                              "";

                          if (value == "clear") {
                            value = -1;
                          }
                          if (value == "error") {
                            value = -2;
                          }
                          supplierCubit.filterDataForFilterButton(value: value, state: state);
                        },
                      ),
                      onTapSearchCalenderButton: () async {
                        String value = await searchFilterDialog(
                              context: context,
                              searchFilterCubit: supplierCubit.searchFilterCubit,
                            ) ??
                            "error";

                        supplierCubit.filterForDate(value: value, state: state);
                      },
                    ),
                    (state.filterList != null && state.filterList!.isEmpty)
                        ? Expanded(
                            child: CommonWidget.dataNotFound(
                            context: context,
                            bgColor: appConstants.backGroundColor,
                            actionButton: Container(),
                          ))
                        : Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              itemCount:
                                  state.filterList == null ? state.supplierDetailList.length : state.filterList?.length,
                              itemBuilder: (context, index) {
                                SupplierDetailModel supplierData =
                                    state.filterList?[index] ?? state.supplierDetailList[index];

                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3.h),
                                  child: supplierDetails(
                                    supplierDetailModel: supplierData,
                                    index: index,
                                    context: context,
                                    state: state,
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: bottomButton(context),
      ),
    );
  }
}
