part of 'reminder_date_cubit.dart';

sealed class ReminderDateState extends Equatable {
  const ReminderDateState();

  @override
  List<Object> get props => [];
}

final class ReminderDateInitialState extends ReminderDateState {
  @override
  List<Object> get props => [];
}

final class ReminderDateLoadingState extends ReminderDateState {
  @override
  List<Object> get props => [];
}

final class ReminderDateLoadedState extends ReminderDateState {
  final DateTime date;

  const ReminderDateLoadedState({required this.date});

  @override
  List<Object> get props => [date];
}

final class ReminderDateErrorState extends ReminderDateState {
  final AppErrorType appErrorType;

  const ReminderDateErrorState({required this.appErrorType});
  @override
  List<Object> get props => [appErrorType];
}
