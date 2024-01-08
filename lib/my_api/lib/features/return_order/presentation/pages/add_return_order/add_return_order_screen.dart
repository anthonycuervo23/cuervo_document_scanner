import 'package:bakery_shop_admin_flutter/features/return_order/presentation/cubit/add_return_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/return_order/presentation/pages/add_return_order/add_return_order_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReturnOrderScreen extends StatefulWidget {
  const AddReturnOrderScreen({super.key});

  @override
  State<AddReturnOrderScreen> createState() => _AddReturnOrderScreenState();
}

class _AddReturnOrderScreenState extends AddReturnOrderWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<AddReturnOrderCubit, AddReturnOrderState>(
            bloc: addReturnOrderCubit,
            builder: (context, state) {
              if (state is AddReturnOrderLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonSizeBox(),
                    orderIdAndDateOfPurchase(),
                    commonSizeBox(),
                    customerNameField(),
                    commonSizeBox(),
                    productList(state: state),
                    commonSizeBox(),
                    returnDateField(),
                    commonSizeBox(),
                    reasonOfReturnField(),
                    commonSizeBox(),
                    collectByDropDown(),
                    commonSizeBox(),
                    status(),
                    CommonWidget.sizedBox(height: 20),
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
