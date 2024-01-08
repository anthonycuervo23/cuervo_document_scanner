part of 'time_slot_cubit.dart';

sealed class TimeSLotState extends Equatable {
  const TimeSLotState();

  @override
  List<Object> get props => [];
}

class TimeSLotCubitLoadingState extends TimeSLotState {
  @override
  List<Object> get props => [];
}

class TimeSLotCubitLoadedState extends TimeSLotState {
  final OrderDeliveryDate deliveryDate;
  final OrderDelivaryType deliverytype;
  final String selectedDate;
  final String selectedTime;
  final double random;

  const TimeSLotCubitLoadedState(
      {required this.deliveryDate,
      required this.random,
      required this.selectedDate,
      required this.deliverytype,
      required this.selectedTime});

  TimeSLotCubitLoadedState copyWith({
    OrderDeliveryDate? deliveryDate,
    double? random,
    String? selectedDate,
    String? selectedTime,
    OrderDelivaryType? deliverytype,
  }) {
    return TimeSLotCubitLoadedState(
      deliveryDate: deliveryDate ?? this.deliveryDate,
      random: random ?? this.random,
      selectedDate: selectedDate ?? this.selectedDate,
      deliverytype: deliverytype ?? this.deliverytype,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  @override
  List<Object> get props => [deliveryDate, random, deliveryDate, deliverytype, selectedTime];
}

class TimeSLotCubitErrorState extends TimeSLotState {
  final ErrorType errorType;
  final String errorMessage;

  const TimeSLotCubitErrorState({required this.errorMessage, required this.errorType});
  @override
  List<Object> get props => [errorMessage, errorType];
}
