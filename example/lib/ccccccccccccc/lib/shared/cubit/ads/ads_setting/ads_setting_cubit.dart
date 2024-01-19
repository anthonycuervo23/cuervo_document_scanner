// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:captain_score/shared/cubit/ads/banner_ads/banner_ads_cubit.dart';
import 'package:captain_score/shared/cubit/ads/interstitial_ads/interstitial_ads_cubit.dart';
import 'package:captain_score/shared/cubit/ads/native_ads/native_ads_cubit.dart';
import 'package:captain_score/shared/cubit/ads/reward_ads/reward_ads_cubit.dart';
import 'package:captain_score/shared/cubit/loading/loading_cubit.dart';
import 'package:captain_score/shared/utils/ads_configuration.dart';
import 'package:captain_score/shared/utils/app_functions.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/di/get_it.dart';

part 'ads_setting_state.dart';

class AdsSettingCubit extends Cubit<AdsSettingState> {
  final LoadingCubit loadingCubit;
  BannerAdsCubit bACubit;
  InterstitialAdsCubit iACubit;
  RewardAdsCubit rACubit;
  NativeAdsCubit nACubit;

  // late AdWidget? nativeAdWidget;
  int interstitialLoadAttempts = 0;
  int rewardedInterstitialLoadAttempts = 0;
  int rewardedLoadAttempts = 0;
  bool isAdLoad = false;
  int adsGridTapCount = 1;
  int adsMaxGridTapCount = 40;
  bool isMounted = true;

  InterstitialAd? interstitialAd;
  RewardedInterstitialAd? rewardedInterstitialAd;
  RewardedAd? rewardedAd;
  NativeAd? nativeAd;

  AdsSettingCubit({
    required this.loadingCubit,
    required this.bACubit,
    required this.iACubit,
    required this.rACubit,
    required this.nACubit,
  }) : super(AdsSettingInitial());

  loadAdsSetting() async {
    await dmtBox.put(HiveConstants.IS_ADS_ONLINE, isAdsOnline);

    if (kDebugMode) {
      isTestMode = false;
      isAdsOnline = false;
    }
  }

  disposeAdSetting() {
    interstitialAd?.dispose();
    rewardedInterstitialAd?.dispose();
    rewardedAd?.dispose();
    nativeAd?.dispose();
  }

  loadBannerAd({bool? smallBanner}) async {
    bool isBannerLoad = false;
    AdWidget? bannerAdWidget;
    BannerAd? bAd;
    final AnchoredAdaptiveBannerAdSize? size = await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      ScreenUtil().screenWidth.toInt(),
    );

    bAd = createBannerAd(
      adListener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isBannerLoad = true;
          if (kDebugMode) {
            print("load");
          }
          if (isAdsOnline && isBannerLoad) {
            bACubit.loadBannerAds(
              isBannerLoad: isBannerLoad,
              bannerAdWidget: bannerAdWidget!,
              adSize: size,
              adsData: bAd!,
            );
          } else {
            bACubit.noBannerAds();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          if (kDebugMode) {
            print(error);
          }
          isBannerLoad = false;
          bACubit.noBannerAds();
          ad.dispose();
          bAd = null;
          if (kDebugMode) {
            print(error.message);
          }
        },
        onAdOpened: (Ad ad) => {},
        onAdClosed: (Ad ad) => {},
        onAdImpression: (Ad ad) => {},
      ),
      adSize: (smallBanner ?? false) ? null : size,
    );

    if (isAdsOnline && bAd != null) {
      bannerAdWidget = AdWidget(ad: bAd!);
      await bannerAdWidget.ad.dispose();
      await bannerAdWidget.ad.load();
    } else {
      bannerAdWidget = null;
      bACubit.noBannerAds();
    }
  }

  loadNativeAd({TemplateType? templateType, bool showDefaultStyle = false}) async {
    if (!shouldShowNativeAds()) {
      return;
    }
    commonPrint("Current Screen Name Load : $currentRouteName");

    try {
      bool isNativeLoad = false;
      NativeAd? nAd;
      nAd = createNativeAd(
        adListener: NativeAdListener(
          onAdLoaded: (Ad ad) {
            isNativeLoad = true;

            if (isAdsOnline && createNativeAd() != null && isNativeLoad && nAd != null) {
              nACubit.loadNativeAds(isNativeLoad: isNativeLoad, nativeAdWidget: nAd!);
            }
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            isNativeLoad = false;
            nAd = null;
            ad.dispose();
            // print(isAdsOnline && createNativeAd() != null && isNativeLoad && nAd != null);
            nACubit.noAdsError();
          },
          onAdOpened: (Ad ad) => {},
          onAdClosed: (Ad ad) => {},
          onAdImpression: (Ad ad) => {},
        ),
        showDefaultStyle: showDefaultStyle,
        templateType: templateType,
      );
      if (isAdsOnline && nAd != null && createNativeAd() != null) {
        await nAd?.load();
      } else {
        nACubit.noAdsError();
      }
    } on Exception catch (e, stackTrace) {
      Catcher2.reportCheckedError(e, stackTrace);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  loadNativeVideoAd({TemplateType? templateType, bool showDefaultStyle = false}) async {
    if (!shouldShowNativeAds()) {
      return;
    }
    commonPrint("Current Screen Name Load : $currentRouteName");

    try {
      bool isNativeLoad = false;
      NativeAd? nAd;
      nAd = createNativeVideoAd(
        adListener: NativeAdListener(
          onAdLoaded: (Ad ad) {
            isNativeLoad = true;

            if (isAdsOnline && createNativeVideoAd() != null && isNativeLoad && nAd != null) {
              nACubit.loadNativeAds(isNativeLoad: isNativeLoad, nativeAdWidget: nAd!);
            }
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            isNativeLoad = false;
            nAd = null;
            ad.dispose();
            // print(isAdsOnline && createNativeAd() != null && isNativeLoad && nAd != null);
            nACubit.noAdsError();
          },
          onAdOpened: (Ad ad) => {},
          onAdClosed: (Ad ad) => {},
          onAdImpression: (Ad ad) => {},
        ),
        showDefaultStyle: showDefaultStyle,
        templateType: templateType,
      );
      if (isAdsOnline && nAd != null && createNativeVideoAd() != null) {
        await nAd?.load();
      } else {
        nACubit.noAdsError();
      }
    } on Exception catch (e, stackTrace) {
      Catcher2.reportCheckedError(e, stackTrace);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  bool shouldShowBannerAds() {
    if (isAdsOnline && AdsConfiguration.getBannerAdUnitId != null && AdsConfiguration.getBannerAdUnitId!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowNativeAds() {
    if (isAdsOnline && AdsConfiguration.getNativeAdUnitId != null && AdsConfiguration.getNativeAdUnitId!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowNativeVideoAds() {
    if (isAdsOnline &&
        AdsConfiguration.getNativeVideoAdUnitId != null &&
        AdsConfiguration.getNativeVideoAdUnitId!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowInterestialAds() {
    if (isAdsOnline &&
        ((AdsConfiguration.getInterstitialAdUnitId != null && AdsConfiguration.getInterstitialAdUnitId!.isNotEmpty))) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowInterestialRewardAds() {
    if (isAdsOnline &&
        ((AdsConfiguration.getRewardedInterestialAdUnitID != null &&
            AdsConfiguration.getRewardedInterestialAdUnitID!.isNotEmpty))) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowAppOpenAds() {
    if (isAdsOnline && AdsConfiguration.getAppOpenId != null && shouldShowAppOpenAdd) {
      return true;
    } else {
      return false;
    }
  }

  bool shouldShowRewardAds() {
    if (isAdsOnline &&
        AdsConfiguration.getRewardedAdUnitID != null &&
        AdsConfiguration.getRewardedAdUnitID!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createInterstitialAd() async {
    if (isAdsOnline && AdsConfiguration.getInterstitialAdUnitId != null) {
      if (interstitialAd == null) {
        _createInterstitialAd();
      }
    }
  }

  Future<void> showInterestialAd({VoidCallback? callback}) async {
    if (navigationCount % adsAfterNoOfNavigation == 0) {
      if (isAdsOnline && AdsConfiguration.getInterstitialAdUnitId != null) {
        await _showInterstitialAd(callback: callback);
      }
    } else {
      callback?.call();
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdsConfiguration.getInterstitialAdUnitId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          interstitialLoadAttempts = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          interstitialLoadAttempts += 1;
          interstitialAd = null;
          if (interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        }));
  }

  Future<void> _showInterstitialAd({VoidCallback? callback}) async {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        interstitialAd = null;
        if (callback != null) {
          callback();
        }

        _createInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        interstitialAd = null;
        if (callback != null) {
          callback();
        }
        _createInterstitialAd();
      });
      interstitialAd?.show();
    } else {
      if (callback != null) {
        callback();
      }
    }
  }

  Future<void> createRewardInterestialAd({VoidCallback? callback}) async {
    if (isAdsOnline && AdsConfiguration.getRewardedInterestialAdUnitID != null) {
      if (rewardedInterstitialAd == null) {
        _createRewardedInterestialAd();
      } else {
        if (callback != null) {
          callback();
        }
      }
    }
  }

  Future<void> showRewardInterestialAd({VoidCallback? callback}) async {
    if (isAdsOnline && AdsConfiguration.getRewardedInterestialAdUnitID != null) {
      _showRewardedInterestialAd(callback: callback);
    } else {
      if (callback != null) {
        callback();
      }
    }
  }

  void _createRewardedInterestialAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdsConfiguration.getRewardedInterestialAdUnitID!,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          rewardedInterstitialAd = ad;
          rewardedInterstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          rewardedInterstitialLoadAttempts += 1;
          rewardedInterstitialAd = null;
          if (rewardedInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createRewardedInterestialAd();
          }
        },
      ),
    );
  }

  void _showRewardedInterestialAd({VoidCallback? callback}) {
    RewardItem? reward;

    if (rewardedInterstitialAd != null) {
      rewardedInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
          if (reward != null) {
            if (callback != null) {
              callback();
            }
          }

          ad.dispose();
          rewardedInterstitialAd = null;
          _createRewardedInterestialAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad, AdError error) {
          ad.dispose();
          rewardedInterstitialAd = null;
          if (callback != null) {
            callback();
          }
          _createRewardedInterestialAd();
        },
      );

      rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          reward = rewardItem;
        },
      );
    } else {
      if (callback != null) {
        callback();
      }
    }
  }

  Future<void> createRewardAd({VoidCallback? callback}) async {
    if (isAdsOnline && AdsConfiguration.getRewardedAdUnitID != null) {
      _createRewardedAd();
    }
  }

  Future<void> showRewardAd({VoidCallback? callback}) async {
    if (isAdsOnline && AdsConfiguration.getRewardedAdUnitID != null) {
      _showRewardedAd(callback: callback);
    } else {
      if (callback != null) {
        callback();
      }
    }
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdsConfiguration.getRewardedAdUnitID!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          rewardedLoadAttempts = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          rewardedLoadAttempts += 1;
          rewardedAd = null;
          if (rewardedLoadAttempts <= maxFailedLoadAttempts) {
            _createRewardedAd();
          }
        }));
  }

  void _showRewardedAd({VoidCallback? callback}) {
    RewardItem? reward;
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (RewardedAd ad) {
        if (reward != null) {
          if (callback != null) {
            callback();
          }
        }
        ad.dispose();
        rewardedAd = null;
        _createRewardedAd();
      }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        rewardedAd = null;
        ad.dispose();
        if (callback != null) {
          callback();
        }
        _createRewardedAd();
      });
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          reward = rewardItem;
        },
      );
    } else {
      if (callback != null) {
        callback();
      }
    }
  }

  void reloadAdsCubit() {
    bACubit = getItInstance<BannerAdsCubit>();
    nACubit = getItInstance<NativeAdsCubit>();
  }
}
