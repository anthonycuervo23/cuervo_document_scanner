// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdsDataAdapter extends TypeAdapter<AdsData> {
  @override
  final int typeId = 4;

  @override
  AdsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdsData(
      setting: fields[0] as Setting?,
      listData: fields[1] as AdsIdData?,
      admob: fields[2] as AdsIdData?,
      fb: fields[3] as AdsIdData?,
      adx: fields[4] as AdsIdData?,
      adsClick: fields[5] as String?,
      positionOfLoad: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdsData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.setting)
      ..writeByte(1)
      ..write(obj.listData)
      ..writeByte(2)
      ..write(obj.admob)
      ..writeByte(3)
      ..write(obj.fb)
      ..writeByte(4)
      ..write(obj.adx)
      ..writeByte(5)
      ..write(obj.adsClick)
      ..writeByte(6)
      ..write(obj.positionOfLoad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SettingAdapter extends TypeAdapter<Setting> {
  @override
  final int typeId = 5;

  @override
  Setting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Setting(
      defaultAppAd: fields[0] as String?,
      adShowStatus: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Setting obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.defaultAppAd)
      ..writeByte(1)
      ..write(obj.adShowStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AdsIdDataAdapter extends TypeAdapter<AdsIdData> {
  @override
  final int typeId = 6;

  @override
  AdsIdData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdsIdData(
      banner: fields[0] as String,
      native: fields[1] as String,
      nativeBanner: fields[2] as String,
      interstitial: fields[3] as String,
      rewardedVideo: fields[4] as String,
      appOpen: fields[5] as String,
      nativeVideo: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdsIdData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.banner)
      ..writeByte(1)
      ..write(obj.native)
      ..writeByte(2)
      ..write(obj.nativeBanner)
      ..writeByte(3)
      ..write(obj.interstitial)
      ..writeByte(4)
      ..write(obj.rewardedVideo)
      ..writeByte(5)
      ..write(obj.appOpen)
      ..writeByte(6)
      ..write(obj.nativeVideo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdsIdDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GeneralSettingEntityAdapter extends TypeAdapter<GeneralSettingEntity> {
  @override
  final int typeId = 3;

  @override
  GeneralSettingEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralSettingEntity(
      companyName: fields[0] as String,
      companyAddress1: fields[1] as String,
      supportEmail: fields[2] as String,
      supportMobileNo: fields[3] as String,
      supportWhatsappMobileNo: fields[4] as String,
      shareMessage: fields[5] as String,
      shareAppMessage: fields[6] as String,
      preOpenEventDay: fields[7] as String,
      makeFrameVideo: fields[8] as String,
      dbvcInfoVideoLink: fields[9] as String,
      fbUrl: fields[10] as String,
      instagramUrl: fields[11] as String,
      cdnUrl: fields[12] as String,
      ads: fields[13] as AdsData?,
      totalFrameSelection: fields[16] as int?,
      totalTemplateDownloadLimit: fields[17] as int?,
      welcomScreenVideoURL: fields[18] as String?,
      politicalCatId: fields[19] as int?,
      splashScreenVideoURL: fields[20] as String?,
      versionCode: fields[21] as int?,
      appVersionCode: fields[22] as String?,
      isForceUpdate: fields[23] as String?,
      referScreenVideoURL: fields[24] as String?,
      afterClosecountDisplayForAds: fields[25] as int?,
      catalogueBaseURL: fields[26] as String?,
      coinConversationRate: fields[27] as int?,
      isWatermarkEnabled: fields[28] as bool?,
      isMaintenanceEnbled: fields[29] as bool?,
      appHashtag: fields[30] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralSettingEntity obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.companyAddress1)
      ..writeByte(2)
      ..write(obj.supportEmail)
      ..writeByte(3)
      ..write(obj.supportMobileNo)
      ..writeByte(4)
      ..write(obj.supportWhatsappMobileNo)
      ..writeByte(5)
      ..write(obj.shareMessage)
      ..writeByte(6)
      ..write(obj.shareAppMessage)
      ..writeByte(7)
      ..write(obj.preOpenEventDay)
      ..writeByte(8)
      ..write(obj.makeFrameVideo)
      ..writeByte(9)
      ..write(obj.dbvcInfoVideoLink)
      ..writeByte(10)
      ..write(obj.fbUrl)
      ..writeByte(11)
      ..write(obj.instagramUrl)
      ..writeByte(12)
      ..write(obj.cdnUrl)
      ..writeByte(13)
      ..write(obj.ads)
      ..writeByte(16)
      ..write(obj.totalFrameSelection)
      ..writeByte(17)
      ..write(obj.totalTemplateDownloadLimit)
      ..writeByte(18)
      ..write(obj.welcomScreenVideoURL)
      ..writeByte(19)
      ..write(obj.politicalCatId)
      ..writeByte(20)
      ..write(obj.splashScreenVideoURL)
      ..writeByte(21)
      ..write(obj.versionCode)
      ..writeByte(22)
      ..write(obj.appVersionCode)
      ..writeByte(23)
      ..write(obj.isForceUpdate)
      ..writeByte(24)
      ..write(obj.referScreenVideoURL)
      ..writeByte(25)
      ..write(obj.afterClosecountDisplayForAds)
      ..writeByte(26)
      ..write(obj.catalogueBaseURL)
      ..writeByte(27)
      ..write(obj.coinConversationRate)
      ..writeByte(28)
      ..write(obj.isWatermarkEnabled)
      ..writeByte(29)
      ..write(obj.isMaintenanceEnbled)
      ..writeByte(30)
      ..write(obj.appHashtag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralSettingEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
