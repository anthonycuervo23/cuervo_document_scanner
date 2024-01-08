import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:equatable/equatable.dart';

part 'payment_state.dart';

enum OrderPaymentMethod { cash, upi, creditCard }

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentLoadingState());

  void initialFetchData() {
    emit(
      PaymentLoadedState(
        paymentMethod: OrderPaymentMethod.cash,
        random: Random().nextDouble(),
        reciverName: "Select Reciver Name",
        collectedAmount: 0,
      ),
    );
  }

  void changePaymentMethod({required OrderPaymentMethod method, required PaymentLoadedState state}) {
    emit(state.copyWith(paymentMethod: method));
  }

  void changeReciverName({required String reciverName, required PaymentLoadedState state}) {
    emit(state.copyWith(reciverName: reciverName, random: Random().nextDouble()));
  }
}
