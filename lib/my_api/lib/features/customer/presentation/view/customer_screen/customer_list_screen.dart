// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

// import '../widgets/sort_filter_dialog.dart';

import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_cubit/customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_cubit/customer_state.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_screen/customer_list_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends CustomerListWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CustomerCubit, CustomerState>(
        bloc: customerCubit,
        builder: (contex, state) {
          if (state is CustomerLoadedState) {
            return Scaffold(
              backgroundColor: appConstants.backGroundColor,
              appBar: appBar(context, state),
              body: Padding(
                padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchAndFilterField(state, context),
                    Expanded(child: buildCustomerView(state)),
                  ],
                ),
              ),
              bottomNavigationBar: CommonWidget.container(
                height: 80,
                width: ScreenUtil().screenWidth,
                color: appConstants.white,
                child: Center(child: addNewButton(context)),
              ),
            );
          } else if (state is CustomerLoadingState) {
            return Center(child: CommonWidget.loadingIos());
          } else if (state is CustomerErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
