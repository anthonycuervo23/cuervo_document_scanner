// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:captain_score/shared/utils/new_notification_service.dart';
import 'package:equatable/equatable.dart';
part 'selected_notification_state.dart';

class SelectedNotificationCubit extends Cubit<SelectedNotificationState> {
  SelectedNotificationCubit() : super(SelectedNotificationInitial());
  bool isMounted = true;

  void updateSelectedMessage({required NotificationPayloadModel? payloadModel}) {
    if (!isMounted) return;
    emit(SelectedNotificationLoadedState(payloadModel: payloadModel));
  }
}
