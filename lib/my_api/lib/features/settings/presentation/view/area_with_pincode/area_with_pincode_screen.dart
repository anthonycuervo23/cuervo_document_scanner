import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/area_with_pincode/area_with_pincode_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/area_with_pincode/area_with_pincode_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AreaWithPinCodeScreen extends StatefulWidget {
  const AreaWithPinCodeScreen({super.key});

  @override
  State<AreaWithPinCodeScreen> createState() => _AreaWithPinCodeScreenState();
}

class _AreaWithPinCodeScreenState extends AreaWithPinCodeWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreaWithPincodeCubit, AreaWithPincodeState>(
      bloc: areaWithPincodeCubit,
      builder: (context, state) {
        if (state is AreaWithPincodeLoadedState) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appBar(),
            body: Column(
              children: [
                listTitle(),
                CommonWidget.sizedBox(height: 5.0),
                Expanded(child: listOfAreaWithPincode(state: state)),
              ],
            ),
            bottomNavigationBar: addNewButton(state: state),
          );
        } else if (state is AreaWithPincodeLoadingState) {
          const Center(child: CircularProgressIndicator());
        } else if (state is AreaWithPincodeErrorState) {
          return Center(child: Text(state.errorMessage));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
