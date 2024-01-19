// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'native_ads_state.dart';

class NativeAdsCubit extends Cubit<NativeAdsState> {
  bool isMounted = true;
  NativeAdsCubit() : super(NativeAdsInitial());

  void loadNativeAds({required bool isNativeLoad, required NativeAd nativeAdWidget}) {
    if (!isMounted) return;
    emit(NativeAdsLoadedState(isAdLoaded: isNativeLoad, nativeAdWidget: nativeAdWidget));
  }

  void noAdsError() {
    if (!isMounted) return;
    emit(const NativeAdsErrorState());
  }
}
