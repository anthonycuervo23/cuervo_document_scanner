// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reward_ads_state.dart';

class RewardAdsCubit extends Cubit<RewardAdsState> {
  bool isMounted = true;
  RewardAdsCubit() : super(RewardAdsInitial());
}
