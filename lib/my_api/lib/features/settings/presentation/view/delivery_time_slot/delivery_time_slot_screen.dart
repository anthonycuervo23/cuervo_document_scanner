import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/delivery_time_slot/delivery_time_slot_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/delivery_time_slot/delivery_time_slot_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryTimeSlotScreen extends StatefulWidget {
  const DeliveryTimeSlotScreen({super.key});

  @override
  State<DeliveryTimeSlotScreen> createState() => _DeliveryTimeSlotScreenState();
}

class _DeliveryTimeSlotScreenState extends DeliveryTimeSlotWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: SelectedTab.values.length,
      child: BlocBuilder<DeliveryTimeSlotCubit, DeliveryTimeSlotState>(
        bloc: deliveryTimeSlotCubit,
        builder: (context, state) {
          if (state is DeliveryTimeSlotLoadedState) {
            return Scaffold(
              appBar: appBar(),
              body: Column(
                children: [
                  tabBarView(state: state),
                  listTitle(),
                  listView(state: state),
                ],
              ),
              bottomNavigationBar: addNewButton(state: state),
            );
          } else if (state is DeliveryTimeSlotLoadingState) {
            return CommonWidget.loadingIos();
          } else if (state is DeliveryTimeSlotErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
