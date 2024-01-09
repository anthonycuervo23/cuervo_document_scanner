part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentLoadingState extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentLoadedState extends PaymentState {
  final OrderPaymentMethod paymentMethod;
  final String reciverName;
  final double collectedAmount;
  final double random;

  const PaymentLoadedState(
      {required this.paymentMethod, required this.random, required this.reciverName, required this.collectedAmount});

  PaymentLoadedState copyWith({
    OrderPaymentMethod? paymentMethod,
    double? random,
    double? collectedAmount,
    String? reciverName,
  }) {
    return PaymentLoadedState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      random: random ?? this.random,
      reciverName: reciverName ?? this.reciverName,
      collectedAmount: collectedAmount ?? this.collectedAmount,
    );
  }

  @override
  List<Object> get props => [paymentMethod, random, reciverName, collectedAmount];
}

class PaymentErrorState extends PaymentState {
  final ErrorType errorType;
  final String errorMessage;

  const PaymentErrorState({required this.errorType, required this.errorMessage});

  @override
  List<Object> get props => [errorMessage, errorType];
}
