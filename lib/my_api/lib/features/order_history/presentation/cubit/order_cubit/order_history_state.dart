// ignore_for_file: must_be_immutable

part of 'order_history_cubit.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object?> get props => [];
}

class OrderHistoryLoadingState extends OrderHistoryState {}

class OrderHistoryLoadedState extends OrderHistoryState {
  final List<OrderHistoryModel> orderList;
  final List<OrderHistoryModel>? filterList;
  double? random;
  final String filterValue;

  OrderHistoryLoadedState({
    required this.orderList,
    this.random,
    required this.filterValue,
    this.filterList,
  });

  OrderHistoryLoadedState copyWith({
    List<OrderHistoryModel>? orderList,
    List<OrderHistoryModel>? filterList,
    String? filterValue,
    double? random,
  }) {
    return OrderHistoryLoadedState(
      filterList: filterList ?? this.filterList,
      orderList: orderList ?? this.orderList,
      filterValue: filterValue ?? this.filterValue,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [orderList, random, filterValue];
}

class OrderHistoryErrorState extends OrderHistoryState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const OrderHistoryErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
