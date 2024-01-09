// ignore_for_file: annotate_overrides, overridden_fields, must_be_immutable

import 'package:bakery_shop_flutter/features/settings/domain/entities/general_setting_entity.dart';
import 'package:hive/hive.dart';

part 'general_setting_model.g.dart';

class GeneralSettingModel {
  int? status;
  bool? success;
  String? message;
  GeneralSettingData? generalSettingData;

  GeneralSettingModel({this.status, this.success, this.message, this.generalSettingData});

  GeneralSettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    generalSettingData = json['data'] != null ? GeneralSettingData.fromJson(json['data']) : null;
  }
}

class GeneralSettingData extends GeneralSettingEntity {
  final String companyName;
  final String companyAddress1;
  final String supportEmail;
  final String supportMobileNo;
  final String supportWhatsappMobileNo;
  final String shareMessage;
  final String shareAppMessage;
  final String preOpenEventDay;
  final String makeFrameVideo;
  final String dbvcInfoVideoLink;
  final String fbUrl;
  final String instagramUrl;
  final String cdnUrl;
  final AdsData? ads;
  final FreePlanAds? freePlanAds;
  final CustomAdsSetting? customAdsSetting;
  final int? totalFrameSelection;
  final int? totalTemplateDownloadLimit;
  final String? welcomScreenVideoURL;
  final int? politicalCatId;
  final String? splashScreenVideoURL;
  final int? versionCode;
  final String? appVersionCode;
  final String? isForceUpdate;
  final String? referScreenVideoURL;
  final int? afterClosecountDisplayForAds;
  final String? catalogueBaseURL;
  final int? coinConversationRate;
  final bool? isWatermarkEnabled;

  GeneralSettingData({
    required this.companyName,
    required this.companyAddress1,
    required this.supportEmail,
    required this.supportMobileNo,
    required this.supportWhatsappMobileNo,
    required this.shareMessage,
    required this.shareAppMessage,
    required this.preOpenEventDay,
    required this.makeFrameVideo,
    required this.dbvcInfoVideoLink,
    required this.fbUrl,
    required this.instagramUrl,
    required this.cdnUrl,
    required this.ads,
    required this.freePlanAds,
    required this.customAdsSetting,
    required this.totalFrameSelection,
    required this.totalTemplateDownloadLimit,
    required this.welcomScreenVideoURL,
    required this.politicalCatId,
    required this.splashScreenVideoURL,
    required this.versionCode,
    required this.appVersionCode,
    required this.isForceUpdate,
    required this.referScreenVideoURL,
    required this.afterClosecountDisplayForAds,
    required this.catalogueBaseURL,
    required this.coinConversationRate,
    required this.isWatermarkEnabled,
  }) : super(
          companyName: companyName,
          companyAddress1: companyAddress1,
          supportEmail: supportEmail,
          supportMobileNo: supportMobileNo,
          supportWhatsappMobileNo: supportWhatsappMobileNo,
          shareMessage: shareMessage,
          shareAppMessage: shareAppMessage,
          preOpenEventDay: preOpenEventDay,
          makeFrameVideo: makeFrameVideo,
          dbvcInfoVideoLink: dbvcInfoVideoLink,
          fbUrl: fbUrl,
          instagramUrl: instagramUrl,
          cdnUrl: cdnUrl,
          ads: ads,
          freePlanAds: freePlanAds,
          customAdsSetting: customAdsSetting,
          totalFrameSelection: totalFrameSelection,
          totalTemplateDownloadLimit: totalTemplateDownloadLimit,
          welcomScreenVideoURL: welcomScreenVideoURL,
          politicalCatId: politicalCatId,
          splashScreenVideoURL: splashScreenVideoURL,
          versionCode: versionCode,
          appVersionCode: appVersionCode,
          isForceUpdate: isForceUpdate,
          referScreenVideoURL: referScreenVideoURL,
          afterClosecountDisplayForAds: afterClosecountDisplayForAds,
          catalogueBaseURL: catalogueBaseURL,
          coinConversationRate: coinConversationRate,
          isWatermarkEnabled: isWatermarkEnabled,
        );

  factory GeneralSettingData.fromJson(Map<String, dynamic> json) {
    return GeneralSettingData(
      companyName: json['company_name'],
      companyAddress1: json['company_address_1'],
      supportEmail: json['support_email'],
      supportMobileNo: json['support_mobile_no'],
      supportWhatsappMobileNo: json['support_whatsapp_mobile_no'],
      shareMessage: json['share_message'],
      shareAppMessage: json['share_app_message'],
      preOpenEventDay: json['pre_open_event_day'],
      makeFrameVideo: json['make_frame_video'],
      dbvcInfoVideoLink: json['dbvc_info_video_link'],
      fbUrl: json['fb_url'],
      instagramUrl: json['instagram_url'],
      cdnUrl: json['cdn_url'],
      ads: json['ads'] != null ? AdsData.fromJson(json['ads']) : null,
      freePlanAds: json['ads']['setting'] != null ? FreePlanAds.fromJson(json['ads']['setting']) : null,
      customAdsSetting:
          json['custom_ads_setting'] != null ? CustomAdsSetting.fromJson(json['custom_ads_setting']) : null,
      totalFrameSelection:
          json.containsKey('total_frame_selection') ? (int.tryParse(json['total_frame_selection']) ?? 2) : 2,
      totalTemplateDownloadLimit: json.containsKey('total_template_download_limit')
          ? (int.tryParse(json['total_template_download_limit']) ?? 5)
          : 5,
      welcomScreenVideoURL: json['static_video_url'],
      splashScreenVideoURL: json['splash_screen_file'],
      politicalCatId: json['political_category_id'] ?? 134,
      versionCode: json['version_code'] ?? 1,
      appVersionCode: json["app_version_code"] != null ? json["app_version_code"].toString() : "",
      isForceUpdate: json["is_force_update"] != null ? json["is_force_update"].toString() : "",
      referScreenVideoURL: json['referral_video_url']?.toString(),
      catalogueBaseURL: json.containsKey('catalog_base_url') ? json['catalog_base_url'] : '',
      afterClosecountDisplayForAds: int.tryParse(json['after_closecount_display_for_ads'].toString()) ?? 0,
      coinConversationRate: int.tryParse(json['coin_covert_ratio'].toString()) ?? 10,
      isWatermarkEnabled: int.tryParse(json['is_watermark_enbled'].toString()) == 1 ? true : false,
    );
  }
}

@HiveType(typeId: 11)
class CustomAdsSetting {
  @HiveField(0)
  bool showCustomBannerAds;
  @HiveField(1)
  bool showCustomFullScreenAds;
  @HiveField(2)
  bool showCustomNativeAds;
  @HiveField(3)
  bool showCustomNativeAdvancedAds;
  @HiveField(4)
  bool showCustomRewardVideoAds;
  @HiveField(5)
  bool showCustomAppOpenAds;

// enable_banner_ads
// enable_full_screen
// enable_native
// enable_native_advanced
// enable_reward_video_ads
// enable_app_open_ads

  CustomAdsSetting({
    required this.showCustomBannerAds,
    required this.showCustomFullScreenAds,
    required this.showCustomNativeAds,
    required this.showCustomNativeAdvancedAds,
    required this.showCustomRewardVideoAds,
    required this.showCustomAppOpenAds,
  });

  CustomAdsSetting copyWith({
    bool? showCustomBannerAds,
    bool? showCustomFullScreenAds,
    bool? showCustomNativeAds,
    bool? showCustomNativeAdvancedAds,
    bool? showCustomRewardVideoAds,
    bool? showCustomAppOpenAds,
  }) {
    return CustomAdsSetting(
      showCustomBannerAds: showCustomBannerAds ?? this.showCustomBannerAds,
      showCustomFullScreenAds: showCustomFullScreenAds ?? this.showCustomFullScreenAds,
      showCustomNativeAds: showCustomNativeAds ?? this.showCustomNativeAds,
      showCustomNativeAdvancedAds: showCustomNativeAdvancedAds ?? this.showCustomNativeAdvancedAds,
      showCustomRewardVideoAds: showCustomRewardVideoAds ?? this.showCustomRewardVideoAds,
      showCustomAppOpenAds: showCustomAppOpenAds ?? this.showCustomAppOpenAds,
    );
  }

  factory CustomAdsSetting.fromJson(Map<String, dynamic> json) {
    return CustomAdsSetting(
      showCustomBannerAds: (int.tryParse(json["enable_banner_ads"]) ?? 0) == 0 ? false : true,
      showCustomFullScreenAds: (int.tryParse(json["enable_full_screen"]) ?? 0) == 0 ? false : true,
      showCustomNativeAds: (int.tryParse(json["enable_native"]) ?? 0) == 0 ? false : true,
      showCustomNativeAdvancedAds: (int.tryParse(json["enable_native_advanced"]) ?? 0) == 0 ? false : true,
      showCustomRewardVideoAds: (int.tryParse(json["enable_reward_video_ads"]) ?? 0) == 0 ? false : true,
      showCustomAppOpenAds: (int.tryParse(json["enable_app_open_ads"]) ?? 0) == 0 ? false : true,
    );
  }
}

@HiveType(typeId: 4)
class AdsData {
  @HiveField(0)
  Setting? setting;
  @HiveField(1)
  AdsIdData? listData;
  @HiveField(2)
  AdsIdData? admob;
  @HiveField(3)
  AdsIdData? fb;
  @HiveField(4)
  AdsIdData? adx;
  @HiveField(5)
  String? adsClick;
  @HiveField(6)
  String? positionOfLoad;

  AdsData({
    this.setting,
    this.listData,
    this.admob,
    this.fb,
    this.adx,
    this.adsClick,
    this.positionOfLoad,
  });

  AdsData.fromJson(Map<String, dynamic> json) {
    setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
    listData = json['list'] != null ? AdsIdData.fromJson(json['list']) : null;
    admob = json['admob'] != null ? AdsIdData.fromJson(json['admob']) : null;
    fb = json['fb'] != null ? AdsIdData.fromJson(json['fb']) : null;
    adx = json['adx'] != null ? AdsIdData.fromJson(json['adx']) : null;
    adsClick = json['ads_click'];
    positionOfLoad = json['position_of_load'];
  }
}

@HiveType(typeId: 5)
class Setting {
  @HiveField(0)
  String? defaultAppAd;
  @HiveField(1)
  String? adShowStatus;

  Setting({this.defaultAppAd, this.adShowStatus});

  Setting.fromJson(Map<String, dynamic> json) {
    defaultAppAd = json['default_app_ad'];
    adShowStatus = json['ad_show_status'];
  }
}

@HiveType(typeId: 6)
class AdsIdData {
  @HiveField(0)
  final String banner;
  @HiveField(1)
  final String native;
  @HiveField(2)
  final String nativeBanner;
  @HiveField(3)
  final String interstitial;
  @HiveField(4)
  final String rewardedVideo;
  @HiveField(5)
  final String appOpen;
  @HiveField(6)
  String? nativeVideo;

  AdsIdData({
    required this.banner,
    required this.native,
    required this.nativeBanner,
    required this.interstitial,
    required this.rewardedVideo,
    required this.appOpen,
    required this.nativeVideo,
  });

  factory AdsIdData.fromJson(Map<String, dynamic> json) {
    return AdsIdData(
      banner: json.containsKey('banner') ? json['banner'] : '',
      native: json.containsKey('native') ? json['native'] : '',
      nativeBanner: json.containsKey('native_banner') ? json['native_banner'] : '',
      interstitial: json.containsKey('interstitial') ? json['interstitial'] : '',
      rewardedVideo: json.containsKey('rewarded_video') ? json['rewarded_video'] : '',
      appOpen: json.containsKey('app_open') ? json['app_open'] : '',
      nativeVideo: json.containsKey('native_video') ? json['native_video'] : null,
    );
  }
}

@HiveType(typeId: 10)
class FreePlanAds {
  @HiveField(0)
  final int trialDays;
  @HiveField(1)
  final int totalDownloadPost;
  @HiveField(2)
  final int appOpenCount;
  @HiveField(3)
  final bool paymentScreen;
  @HiveField(4)
  final bool shareAds;
  @HiveField(5)
  final bool businessProfileScreen;
  @HiveField(6)
  final bool feedbackScreen;
  @HiveField(7)
  final bool helpSupportScreen;
  @HiveField(8)
  final bool digitalCardScreen;
  @HiveField(9)
  final bool logoScreen;
  @HiveField(10)
  final bool customFrameScreen;
  @HiveField(11)
  final bool? catalogueScreen;

  FreePlanAds({
    required this.trialDays,
    required this.totalDownloadPost,
    required this.appOpenCount,
    required this.paymentScreen,
    required this.shareAds,
    required this.businessProfileScreen,
    required this.feedbackScreen,
    required this.helpSupportScreen,
    required this.digitalCardScreen,
    required this.logoScreen,
    required this.customFrameScreen,
    required this.catalogueScreen,
  });

  factory FreePlanAds.fromJson(Map<String, dynamic> json) {
    return FreePlanAds(
      trialDays: json.containsKey('trial_days') ? int.tryParse(json['trial_days'].toString()) ?? 0 : 0,
      totalDownloadPost:
          json.containsKey('total_download_post') ? int.tryParse(json['total_download_post'].toString()) ?? 0 : 0,
      appOpenCount: json.containsKey('app_open_count') ? int.tryParse(json['app_open_count'].toString()) ?? 0 : 0,
      paymentScreen: json.containsKey('payment_screen')
          ? json['payment_screen'].toString() == "1"
              ? true
              : false
          : true,
      shareAds: json.containsKey('share_ads')
          ? json['share_ads'].toString() == "1"
              ? true
              : false
          : true,
      businessProfileScreen: json.containsKey('business_profile_screen')
          ? json['business_profile_screen'].toString() == "1"
              ? true
              : false
          : true,
      feedbackScreen: json.containsKey('feedback_screen')
          ? json['feedback_screen'].toString() == "1"
              ? true
              : false
          : true,
      helpSupportScreen: json.containsKey('help_support_screen')
          ? json['help_support_screen'].toString() == "1"
              ? true
              : false
          : true,
      digitalCardScreen: json.containsKey('digital_card_screen')
          ? json['digital_card_screen'].toString() == "1"
              ? true
              : false
          : true,
      logoScreen: json.containsKey('logo_screen')
          ? json['logo_screen'].toString() == "1"
              ? true
              : false
          : true,
      customFrameScreen: json.containsKey('custom_frame_screen')
          ? json['custom_frame_screen'].toString() == "1"
              ? true
              : false
          : true,
      catalogueScreen: json.containsKey('catalogue_screen')
          ? json['catalogue_screen'].toString() == "1"
              ? true
              : false
          : true,
    );
  }
}
