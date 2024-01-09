import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/create_customer_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/create_customer/create_customer_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCustomerScreen extends StatefulWidget {
  final CreateCustomerArgs navigation;
  const CreateCustomerScreen({super.key, required this.navigation});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends CreateCustomerWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCustomerCubit, CreateCustomerState>(
      bloc: createNewCustomerCubit,
      builder: (contex, state) {
        if (state is CreateCustomerLoadedState) {
          return Form(
            key: formKey,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar:
                  state.selectTabValue == 0 ? basicInfoAppBar(context, state) : orderAndShippingAppBar(context, state),
              body: widget.navigation.isForEdit == true
                  ? editScreenView(state: state)
                  : DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          CommonWidget.container(height: 1, color: appConstants.black12),
                          state.selectIndexType == 0 ? screenView(state: state) : supplierScreenView(state: state),
                        ],
                      ),
                    ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
