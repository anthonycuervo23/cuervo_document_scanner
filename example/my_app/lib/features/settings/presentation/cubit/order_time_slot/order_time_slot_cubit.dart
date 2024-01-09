import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_time_slot_state.dart';

class OrderTimeSlotCubit extends Cubit<OrderTimeSlotState> {
  OrderTimeSlotCubit()
      : super(OrderTimeSlotLoadedState(
          selectedIndex: 0,
          selectedTimeSlot: '08:00 AM - 09:00 AM',
        ));

  void changeTimeSlot({required int index, required String orderTimeSlot}) {
    emit(OrderTimeSlotLoadedState(selectedIndex: index, selectedTimeSlot: orderTimeSlot));
  }
}
