// ignore_for_file: avoid_print

import 'dart:io';

import 'package:captain_score/shared/utils/app_functions.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

bool isTestMode = false;

class AdsConfiguration {
  static String? get getAppId {
    if (Platform.isIOS) {
      // return firebaseAdsSettings[FirestoreAdsConstants.IOS_APP_ID] ?? null;
    } else if (Platform.isAndroid) {
      // return firebaseAdsSettings[FirestoreAdsConstants.ANDROID_APP_ID] ?? null;
    }
    return null;
  }

  static String? get getBannerAdUnitId {
    if (Platform.isIOS) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.banner
          : generalSettingEntity?.ads?.adx?.banner;
    } else if (Platform.isAndroid) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/6300978111';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.banner
          : generalSettingEntity?.ads?.adx?.banner;
    }
    return null;
  }

  static String? get getInterstitialAdUnitId {
    if (Platform.isIOS) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/4411468910';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.interstitial
          : generalSettingEntity?.ads?.adx?.interstitial;
    } else if (Platform.isAndroid) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/1033173712';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.interstitial
          : generalSettingEntity?.ads?.adx?.interstitial;
    }
    return null;
  }

  static String? get getAppOpenId {
    if (Platform.isIOS) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/5662855259';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.appOpen
          : generalSettingEntity?.ads?.adx?.appOpen;
    } else if (Platform.isAndroid) {
      if (isTestMode) {
        // return 'ca-app-pub-3940256099942544/3419835294';
        return 'ca-app-pub-3940256099942544/9257395921';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.appOpen
          : generalSettingEntity?.ads?.adx?.appOpen;
    }
    return null;
  }

  static String? get getNativeAdUnitId {
    if (Platform.isIOS) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/3986624511';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.native
          : generalSettingEntity?.ads?.adx?.native;
    } else if (Platform.isAndroid) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/2247696110';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.native
          : generalSettingEntity?.ads?.adx?.native;
    }
    return null;
  }

  static String? get getNativeVideoAdUnitId {
    if (Platform.isIOS) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/2521693316';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.nativeVideo
          : generalSettingEntity?.ads?.adx?.nativeVideo;
    } else if (Platform.isAndroid) {
      if (isTestMode) {
        return "ca-app-pub-3940256099942544/1044960115";
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.nativeVideo
          : generalSettingEntity?.ads?.adx?.nativeVideo;
    }
    return null;
  }

  static String? get getRewardedInterestialAdUnitID {
    if (Platform.isIOS) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/6978759866';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.rewardedVideo
          : generalSettingEntity?.ads?.adx?.rewardedVideo;
    } else if (Platform.isAndroid) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/5354046379';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.rewardedVideo
          : generalSettingEntity?.ads?.adx?.rewardedVideo;
    }
    return null;
  }

  static String? get getRewardedAdUnitID {
    if (Platform.isIOS) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/1712485313';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.rewardedVideo
          : generalSettingEntity?.ads?.adx?.rewardedVideo;
    } else if (Platform.isAndroid) {
      if (isTestMode) {
        return 'ca-app-pub-3940256099942544/5224354917';
      }
      return generalSettingEntity?.ads?.setting?.defaultAppAd == 'Admob'
          ? generalSettingEntity?.ads?.admob?.rewardedVideo
          : generalSettingEntity?.ads?.adx?.rewardedVideo;
    }
    return null;
  }
}

BannerAd? createBannerAd({BannerAdListener? adListener, AnchoredAdaptiveBannerAdSize? adSize}) {
  if (AdsConfiguration.getBannerAdUnitId == null) {
    return null;
  }

  commonPrint("Current Screen Name : $currentRouteName");

  return BannerAd(
    size: adSize != null ? AdSize(width: adSize.width, height: adSize.height) : AdSize.banner,
    adUnitId: AdsConfiguration.getBannerAdUnitId!,
    listener: adListener ??
        BannerAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('Ad opened.'),
          onAdClosed: (Ad ad) => print('Ad closed.'),
          onAdImpression: (Ad ad) => print('Ad impression.'),
        ),
    request: const AdRequest(),
  );
}

NativeAd? createNativeAd({NativeAdListener? adListener, TemplateType? templateType, bool showDefaultStyle = false}) {
  if (AdsConfiguration.getNativeAdUnitId == null) {
    return null;
  }
  commonPrint("Current Screen Name : $currentRouteName");

  return NativeAd(
    adUnitId: AdsConfiguration.getNativeAdUnitId!,
    listener: adListener ??
        NativeAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('Ad opened.'),
          onAdClosed: (Ad ad) => print('Ad closed.'),
          onAdImpression: (Ad ad) => print('Ad impression.'),
        ),
    request: const AdRequest(),
    nativeAdOptions: NativeAdOptions(),
    factoryId: showDefaultStyle ? null : 'nativeFactory',
    nativeTemplateStyle: showDefaultStyle
        ? NativeTemplateStyle(
            // Required: Choose a template.
            templateType: templateType ?? TemplateType.small,
          )
        : null,
  );
}

NativeAd? createNativeVideoAd({
  NativeAdListener? adListener,
  TemplateType? templateType,
  bool showDefaultStyle = false,
}) {
  if (AdsConfiguration.getNativeVideoAdUnitId == null) {
    return null;
  }
  commonPrint("Current Screen Name : $currentRouteName");
  return NativeAd(
    adUnitId: AdsConfiguration.getNativeVideoAdUnitId!,
    listener: adListener ??
        NativeAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('Ad opened.'),
          onAdClosed: (Ad ad) => print('Ad closed.'),
          onAdImpression: (Ad ad) => print('Ad impression.'),
        ),
    request: const AdRequest(),
    nativeAdOptions: NativeAdOptions(videoOptions: VideoOptions(startMuted: false)),
    factoryId: 'nativeFactory',
    nativeTemplateStyle: showDefaultStyle
        ? NativeTemplateStyle(
            // Required: Choose a template.
            templateType: templateType ?? TemplateType.small,
          )
        : null,
  );
}

NativeAd? getNativeAd({NativeAdListener? adListener}) {
  if (AdsConfiguration.getNativeAdUnitId == null) {
    return null;
  }
  return NativeAd(
    adUnitId: AdsConfiguration.getNativeAdUnitId!,
    listener: adListener ??
        NativeAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('Ad opened.'),
          onAdClosed: (Ad ad) => print('Ad closed.'),
          onAdImpression: (Ad ad) => print('Ad impression.'),
        ),
    request: const AdRequest(),
    factoryId: 'nativeFactory',
  );
}

InterstitialAd? createInterstitialAd({InterstitialAdLoadCallback? adListener}) {
  // print("nufdll");
  if (AdsConfiguration.getInterstitialAdUnitId == null) {
    return null;
  }
  commonPrint("Current Screen Name : $currentRouteName");

  InterstitialAd? interstitialAd;
  InterstitialAd.load(
    adUnitId: AdsConfiguration.getInterstitialAdUnitId!,
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        interstitialAd = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
        // print("nufll");
        // print('InterstitialAd failed to load: $error');
      },
    ),
  );

  return interstitialAd;
}
