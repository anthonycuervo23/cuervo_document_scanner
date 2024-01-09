part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitialState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoadingState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoadedState extends NotificationState {
  final List<NotificationModel> notificationList;
  final double? random;

  const NotificationLoadedState({
    required this.notificationList,
    this.random,
  });

  NotificationLoadedState copyWith({List<NotificationModel>? notificationList, double? random}) {
    return NotificationLoadedState(
      notificationList: notificationList ?? this.notificationList,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [notificationList, random];
}

class NotificationErrorState extends NotificationState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const NotificationErrorState({required this.errorMessage, required this.appErrorType});

  @override
  List<Object> get props => [errorMessage, appErrorType];
}
