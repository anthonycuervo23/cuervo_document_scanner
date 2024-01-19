// ignore_for_file: must_be_immutable

import 'package:captain_score/shared/models/model_reponse_extend.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'general_setting_model.g.dart';

class GeneralSettingModel extends ModelResponseExtend {
  final int? status;
  final bool? success;
  final String? message;
  final GeneralSettingEntity? data;

  GeneralSettingModel({required this.status, required this.success, required this.message, required this.data});

  factory GeneralSettingModel.fromJson(Map<String, dynamic> json) {
    return GeneralSettingModel(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: (json['data'] != null && json['status'] == 200) ? GeneralSettingEntity.fromJson(json['data']) : null,
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

@HiveType(typeId: 3)
class GeneralSettingEntity extends Equatable {
  @HiveField(0)
  final String companyName;
  @HiveField(1)
  final String companyAddress1;
  @HiveField(2)
  final String supportEmail;
  @HiveField(3)
  final String supportMobileNo;
  @HiveField(4)
  final String supportWhatsappMobileNo;
  @HiveField(5)
  final String shareMessage;
  @HiveField(6)
  final String shareAppMessage;
  @HiveField(7)
  final String preOpenEventDay;
  @HiveField(8)
  final String makeFrameVideo;
  @HiveField(9)
  final String dbvcInfoVideoLink;
  @HiveField(10)
  final String fbUrl;
  @HiveField(11)
  final String instagramUrl;
  @HiveField(12)
  final String cdnUrl;
  @HiveField(13)
  final AdsData? ads;
  @HiveField(16)
  int? totalFrameSelection;
  @HiveField(17)
  int? totalTemplateDownloadLimit;
  @HiveField(18)
  String? welcomScreenVideoURL;
  @HiveField(19)
  int? politicalCatId;
  @HiveField(20)
  String? splashScreenVideoURL;
  @HiveField(21)
  int? versionCode;
  @HiveField(22)
  String? appVersionCode;
  @HiveField(23)
  String? isForceUpdate;
  @HiveField(24)
  String? referScreenVideoURL;
  @HiveField(25)
  int? afterClosecountDisplayForAds;
  @HiveField(26)
  String? catalogueBaseURL;
  @HiveField(27)
  int? coinConversationRate;
  @HiveField(28)
  bool? isWatermarkEnabled;
  @HiveField(29)
  bool? isMaintenanceEnbled;
  @HiveField(30)
  String? appHashtag;

  GeneralSettingEntity({
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
    required this.isMaintenanceEnbled,
    required this.appHashtag,
  });

  factory GeneralSettingEntity.fromJson(Map<String, dynamic> json) {
    return GeneralSettingEntity(
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
      totalFrameSelection:
          json.containsKey('total_frame_selection') ? (int.tryParse(json['total_frame_selection']) ?? 2) : 2,
      totalTemplateDownloadLimit: json.containsKey('total_template_download_limit')
          ? (int.tryParse(json['total_template_download_limit']) ?? 5)
          : 5,
      ads: json['ads'] != null ? AdsData.fromJson(json['ads']) : null,
      welcomScreenVideoURL: json['static_video_url'],
      splashScreenVideoURL: json['splash_screen_file']?.toString() ?? "",
      politicalCatId: json['political_category_id'] ?? 134,
      versionCode: json['version_code'] ?? 1,
      appVersionCode: json["app_version_code"] != null ? json["app_version_code"].toString() : "",
      isForceUpdate: json["is_force_update"] != null ? json["is_force_update"].toString() : "",
      referScreenVideoURL: json['referral_video_url']?.toString(),
      catalogueBaseURL: json.containsKey('catalog_base_url') ? json['catalog_base_url'] : '',
      afterClosecountDisplayForAds: int.tryParse(json['after_closecount_display_for_ads'].toString()) ?? 0,
      coinConversationRate: int.tryParse(json['coin_covert_ratio'].toString()) ?? 10,
      isWatermarkEnabled: int.tryParse(json['is_watermark_enbled'].toString()) == 1 ? true : false,
      isMaintenanceEnbled: int.tryParse(json['is_maintenance_enbled'].toString()) == 1 ? true : false,
      appHashtag: json['app_hashtag']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [
        companyName,
        companyAddress1,
        supportEmail,
        supportMobileNo,
        supportWhatsappMobileNo,
        shareMessage,
        shareAppMessage,
        preOpenEventDay,
        makeFrameVideo,
        dbvcInfoVideoLink,
        fbUrl,
        instagramUrl,
        cdnUrl,
        ads,
        totalFrameSelection,
        totalTemplateDownloadLimit,
        welcomScreenVideoURL,
        politicalCatId,
        splashScreenVideoURL,
        versionCode,
        appVersionCode,
        isForceUpdate,
        referScreenVideoURL,
        afterClosecountDisplayForAds,
        catalogueBaseURL,
        coinConversationRate,
        isWatermarkEnabled,
        isMaintenanceEnbled,
        appHashtag,
      ];
}
