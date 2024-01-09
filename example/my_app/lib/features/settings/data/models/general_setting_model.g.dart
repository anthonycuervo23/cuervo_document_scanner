// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomAdsSettingAdapter extends TypeAdapter<CustomAdsSetting> {
  @override
  final int typeId = 11;

  @override
  CustomAdsSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomAdsSetting(
      showCustomBannerAds: fields[0] as bool,
      showCustomFullScreenAds: fields[1] as bool,
      showCustomNativeAds: fields[2] as bool,
      showCustomNativeAdvancedAds: fields[3] as bool,
      showCustomRewardVideoAds: fields[4] as bool,
      showCustomAppOpenAds: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CustomAdsSetting obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.showCustomBannerAds)
      ..writeByte(1)
      ..write(obj.showCustomFullScreenAds)
      ..writeByte(2)
      ..write(obj.showCustomNativeAds)
      ..writeByte(3)
      ..write(obj.showCustomNativeAdvancedAds)
      ..writeByte(4)
      ..write(obj.showCustomRewardVideoAds)
      ..writeByte(5)
      ..write(obj.showCustomAppOpenAds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomAdsSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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

class FreePlanAdsAdapter extends TypeAdapter<FreePlanAds> {
  @override
  final int typeId = 10;

  @override
  FreePlanAds read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FreePlanAds(
      trialDays: fields[0] as int,
      totalDownloadPost: fields[1] as int,
      appOpenCount: fields[2] as int,
      paymentScreen: fields[3] as bool,
      shareAds: fields[4] as bool,
      businessProfileScreen: fields[5] as bool,
      feedbackScreen: fields[6] as bool,
      helpSupportScreen: fields[7] as bool,
      digitalCardScreen: fields[8] as bool,
      logoScreen: fields[9] as bool,
      customFrameScreen: fields[10] as bool,
      catalogueScreen: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, FreePlanAds obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.trialDays)
      ..writeByte(1)
      ..write(obj.totalDownloadPost)
      ..writeByte(2)
      ..write(obj.appOpenCount)
      ..writeByte(3)
      ..write(obj.paymentScreen)
      ..writeByte(4)
      ..write(obj.shareAds)
      ..writeByte(5)
      ..write(obj.businessProfileScreen)
      ..writeByte(6)
      ..write(obj.feedbackScreen)
      ..writeByte(7)
      ..write(obj.helpSupportScreen)
      ..writeByte(8)
      ..write(obj.digitalCardScreen)
      ..writeByte(9)
      ..write(obj.logoScreen)
      ..writeByte(10)
      ..write(obj.customFrameScreen)
      ..writeByte(11)
      ..write(obj.catalogueScreen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FreePlanAdsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
