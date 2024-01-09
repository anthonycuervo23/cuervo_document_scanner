import 'dart:math';

import 'package:bakery_shop_flutter/features/notification/data/models/notification_model.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final LoadingCubit loadingCubit;
  NotificationCubit({required this.loadingCubit}) : super(NotificationInitialState());

  void loadData() {
    emit(NotificationLoadingState());
    emit(NotificationLoadedState(notificationList: listOfNotificationDetails));
  }

  void changeStateOfBox({required int index, required NotificationLoadedState state}) {
    state.notificationList[index].isOpenBox = !state.notificationList[index].isOpenBox;

    emit(state.copyWith(random: Random().nextDouble()));
  }
}
