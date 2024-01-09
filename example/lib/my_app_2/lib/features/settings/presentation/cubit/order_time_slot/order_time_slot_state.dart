part of 'order_time_slot_cubit.dart';

abstract class OrderTimeSlotState extends Equatable {
  // const OrderTimeSlotState();

  @override
  List<Object> get props => [];
}

final class OrderTimeSlotInitialState extends OrderTimeSlotState {
  OrderTimeSlotInitialState();

  @override
  List<Object> get props => [];
}

class OrderTimeSlotLoadingState extends OrderTimeSlotState {
  @override
  List<Object> get props => [];
}

class OrderTimeSlotLoadedState extends OrderTimeSlotState {
  final int selectedIndex;
  final String selectedTimeSlot;

  OrderTimeSlotLoadedState({required this.selectedIndex, required this.selectedTimeSlot});

  @override
  List<Object> get props => [selectedIndex];
}

class OrderTimeSlotErrorState extends OrderTimeSlotState {
  final AppErrorType appErrorType;
  final String errorMessage;

  OrderTimeSlotErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
