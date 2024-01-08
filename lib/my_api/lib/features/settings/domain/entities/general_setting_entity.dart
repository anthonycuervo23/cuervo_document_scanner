// ignore_for_file: must_be_immutable

import 'package:bakery_shop_admin_flutter/features/settings/data/models/general_setting_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'general_setting_entity.g.dart';

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
  @HiveField(14)
  final FreePlanAds? freePlanAds;
  @HiveField(15)
  CustomAdsSetting? customAdsSetting;
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
  });

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
        freePlanAds,
        customAdsSetting,
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
      ];
}
