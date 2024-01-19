// ignore_for_file: must_be_immutable

part of 'banner_ads_cubit.dart';

abstract class BannerAdsState extends Equatable {
  const BannerAdsState();

  @override
  List<Object?> get props => [];
}

class BannerAdsInitialState extends BannerAdsState {
  const BannerAdsInitialState();

  @override
  List<Object?> get props => [];
}

class BannerAdsLoadedState extends BannerAdsState {
  bool? isAdLoaded;
  AdWidget? bannerAdWidget;
  double? random;
  AnchoredAdaptiveBannerAdSize? adSize;
  BannerAd? adsData;

  BannerAdsLoadedState({required this.isAdLoaded, this.bannerAdWidget, this.random, this.adSize, this.adsData});

  BannerAdsLoadedState copyWith({
    bool? isAdLoaded,
    AdWidget? bannerAdWidget,
    bool? isCustomAds,
    double? random,
    AnchoredAdaptiveBannerAdSize? adSize,
    BannerAd? adsData,
  }) {
    return BannerAdsLoadedState(
      isAdLoaded: isAdLoaded ?? this.isAdLoaded,
      bannerAdWidget: bannerAdWidget ?? this.bannerAdWidget,
      random: random ?? this.random,
      adSize: adSize ?? this.adSize,
      adsData: adsData ?? this.adsData,
    );
  }

  @override
  List<Object?> get props => [isAdLoaded, bannerAdWidget, random, adSize, adsData];
}

class BannerAdsErrorState extends BannerAdsState {
  const BannerAdsErrorState();

  @override
  List<Object?> get props => [];
}
