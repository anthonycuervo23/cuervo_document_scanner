// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:captain_score/shared/utils/deep_link_data.dart';
import 'package:equatable/equatable.dart';

part 'deep_link_state.dart';

class DeepLinkCubit extends Cubit<DeepLinkState> {
  DeepLinkCubit() : super(const DeepLinkLoadingState());

  void updateDeepLinkData({required DeepLinkData? deepLinkData, double? random}) {
    emit(DeepLinkLoadedState(deepLinkData: deepLinkData, random: random));
  }
}
