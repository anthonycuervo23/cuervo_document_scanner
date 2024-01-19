// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'interstitial_ads_state.dart';

class InterstitialAdsCubit extends Cubit<InterstitialAdsState> {
  bool isMounted = true;
  InterstitialAdsCubit() : super(InterstitialAdsInitial());
}
