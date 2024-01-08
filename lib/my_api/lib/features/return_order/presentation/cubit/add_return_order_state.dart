// ignore_for_file: must_be_immutable

part of 'add_return_order_cubit.dart';

abstract class AddReturnOrderState extends Equatable {
  const AddReturnOrderState();

  @override
  List<Object?> get props => [];
}

class ReturnOrderInitial extends AddReturnOrderState {}

class AddReturnOrderLoadingState extends AddReturnOrderState {
  @override
  List<Object> get props => [];
}

class AddReturnOrderLoadedState extends AddReturnOrderState {
  double? random;
  List? removeItemList;

  AddReturnOrderLoadedState({this.random, this.removeItemList});

  AddReturnOrderLoadedState copyWith({double? random, List? removeItemList}) {
    return AddReturnOrderLoadedState(
      random: random ?? this.random,
      removeItemList: removeItemList ?? this.removeItemList,
    );
  }

  @override
  List<Object?> get props => [removeItemList, random];
}

class AddReturnOrderErrorState extends AddReturnOrderState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AddReturnOrderErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
