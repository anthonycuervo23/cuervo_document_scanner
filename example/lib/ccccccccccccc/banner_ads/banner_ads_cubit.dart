// ignore_for_file: depend_on_referenced_packages, implementation_imports, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/src/ad_containers.dart';

part 'banner_ads_state.dart';

class BannerAdsCubit extends Cubit<BannerAdsState> {
  bool isMounted = true;
  Timer? timer;
  BannerAdsCubit() : super(const BannerAdsInitialState());

  void loadBannerAds({
    required bool isBannerLoad,
    required AdWidget bannerAdWidget,
    AnchoredAdaptiveBannerAdSize? adSize,
    required BannerAd adsData,
  }) {
    if (!isMounted) return;
    timer?.cancel();
    emit(
      BannerAdsLoadedState(
        isAdLoaded: isBannerLoad,
        bannerAdWidget: bannerAdWidget,
        adSize: adSize,
        adsData: adsData,
        random: Random().nextDouble(),
      ),
    );
  }

  void noBannerAds() {
    if (!isMounted) return;
    emit(const BannerAdsErrorState());
  }
}
