part of 'selected_notification_cubit.dart';

abstract class SelectedNotificationState extends Equatable {
  const SelectedNotificationState();

  @override
  List<Object?> get props => [];
}

class SelectedNotificationInitial extends SelectedNotificationState {}

class SelectedNotificationLoadedState extends SelectedNotificationState {
  final NotificationPayloadModel? payloadModel;
  const SelectedNotificationLoadedState({required this.payloadModel});

  @override
  List<Object?> get props => [payloadModel];
}
