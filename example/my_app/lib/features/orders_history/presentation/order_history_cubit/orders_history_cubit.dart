import 'package:bakery_shop_flutter/features/orders_history/presentation/order_history_cubit/orders_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitialState(0, false));
  int get isSelected => state.selectedIndex;

  void selectedTapOrderHistory(int index) {
    final newState = OrderHistoryInitialState(index, true);
    emit(newState);
  }
}
