part of 'routine_order_cubit.dart';

sealed class RoutineOrderState extends Equatable {
  const RoutineOrderState();

  @override
  List<Object?> get props => [];
}

final class RoutineOrderInitial extends RoutineOrderState {}

class RoutineOrderLoadingState extends RoutineOrderState {
  @override
  List<Object> get props => [];
}

class RoutineOrderLoadedState extends RoutineOrderState {
  final double? random;
  const RoutineOrderLoadedState({this.random});
  @override
  List<Object?> get props => [random];
}

class RoutineOrderErrorState extends RoutineOrderState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const RoutineOrderErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
