import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:equatable/equatable.dart';

part 'time_slot_state.dart';

enum OrderDeliveryDate { today, tommorow, other }

enum OrderDelivaryType { standard, midnight, fixTime }

class TimeSLotCubit extends Cubit<TimeSLotState> {
  TimeSLotCubit() : super(TimeSLotCubitLoadingState());
  DateTime? otherDate;
  List<String> standardDelivaryTime = [
    "09 AM - 11 AM",
    "11 AM - 01 PM",
    "01 PM - 03 PM",
    "03 PM - 05 PM",
    "05 PM - 07 PM",
    "07 PM - 09 PM",
    "09 PM - 11 PM",
  ];
  List midnightTime = [
    "11 PM - 01 AM",
    "01 AM - 03 AM",
    "03 AM - 05 AM",
    "05 AM - 07 AM",
    "07 AM - 09 AM",
  ];

  List fixDelivaryTimes = [
    "10 AM - 11 AM",
    "11 AM - 12 PM",
    "12 PM - 01 PM",
    "01 PM - 02 PM",
    "02 PM - 03 PM",
    "03 PM - 04 PM",
    "04 PM - 05 PM",
    "05 PM - 06 PM",
    "06 PM - 07 PM",
    "07 PM - 08 PM",
    "08 PM - 09 PM",
    "09 PM - 10 PM",
    "10 PM - 11 PM"
  ];
  void initialFetchData() {
    emit(
      TimeSLotCubitLoadedState(
        deliveryDate: OrderDeliveryDate.today,
        random: Random().nextDouble(),
        selectedDate: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        deliverytype: OrderDelivaryType.standard,
        selectedTime: standardDelivaryTime[0],
      ),
    );
  }

  void selectDate(
      {required OrderDeliveryDate orderDelivaryTime,
      required TimeSLotCubitLoadedState state,
      required String selectedDate}) {
    emit(state.copyWith(deliveryDate: orderDelivaryTime, selectedDate: selectedDate));
  }

  void selectDelivaryType(
      {required OrderDelivaryType orderDelivaryType, required TimeSLotCubitLoadedState state, required String time}) {
    emit(state.copyWith(
      deliverytype: orderDelivaryType,
      selectedTime: time,
    ));
  }

  void selectTime({required String time, required TimeSLotCubitLoadedState state}) {
    emit(state.copyWith(selectedTime: time));
  }
}
