// ignore_for_file: must_be_immutable

part of 'native_ads_cubit.dart';

abstract class NativeAdsState extends Equatable {
  const NativeAdsState();

  @override
  List<Object?> get props => [];
}

class NativeAdsInitial extends NativeAdsState {}

class NativeAdsLoadedState extends NativeAdsState {
  final bool isAdLoaded;
  NativeAd? nativeAdWidget;
  bool? isCustomAds = false;
  double? random;

  NativeAdsLoadedState({
    required this.isAdLoaded,
    this.nativeAdWidget,
    this.isCustomAds,
    this.random,
  });

  @override
  List<Object?> get props => [
        isAdLoaded,
        nativeAdWidget,
        isCustomAds,
        random,
      ];
}

class NativeAdsErrorState extends NativeAdsState {
  const NativeAdsErrorState();

  @override
  List<Object> get props => [];
}
