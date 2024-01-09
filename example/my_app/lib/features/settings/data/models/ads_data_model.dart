// ignore_for_file: overridden_fields, annotate_overrides, duplicate_ignore, must_be_immutable

class AdsDataModel {
  int? status;
  bool? success;
  String? message;
  CustomAds? customAds;

  AdsDataModel({this.status, this.success, this.message, this.customAds});

  AdsDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    customAds = json['data'] != null ? CustomAds.fromJson(json['data']) : null;
  }
}

class CustomAds {
  int id;
  String title;
  String adsType;
  String description;
  String mediaType;
  String mediaLink;
  String ctaType;
  String ctaLink;
  String ctaButtonLabel;
  bool isClosable;
  int closeTime;
  AdsAppScreen? adsAppScreen;
  HomePlanOffer? planOffer;

  CustomAds({
    required this.id,
    required this.title,
    required this.adsType,
    required this.description,
    required this.mediaType,
    required this.mediaLink,
    required this.ctaType,
    required this.ctaLink,
    required this.ctaButtonLabel,
    required this.isClosable,
    required this.closeTime,
    required this.adsAppScreen,
    required this.planOffer,
  });

  factory CustomAds.fromJson(Map<String, dynamic> json) {
    return CustomAds(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      adsType: json["ads_type"] ?? '',
      description: json["description"] ?? '',
      mediaType: json["type"] ?? ((json["file"] ?? '').toString().contains('mp4') ? 'video' : 'image'),
      mediaLink: (json["file"] ?? '').toString().isEmpty ? 'https://example.com' : json["file"].toString(),
      ctaType: json["cta_type"] ?? '',
      ctaLink: json["cta"] ?? '',
      ctaButtonLabel: json["cta_button_label"] ?? '',
      isClosable: (json["is_closable"] ?? 0) == 0 ? false : true,
      closeTime: json["close_time"] ?? 0,
      adsAppScreen: json["app_screen"] != null ? AdsAppScreen.fromJson(json["app_screen"]) : null,
      planOffer:
          (json['offer'] != null && json['offer'].toString().isNotEmpty) ? HomePlanOffer.fromJson(json['offer']) : null,
    );
  }
}

class AdsAppScreen {
  int? id;
  String? title;
  String? appScreenSlug;
  String? appScreenName;

  AdsAppScreen({
    required this.id,
    required this.title,
    required this.appScreenSlug,
    required this.appScreenName,
  });

  factory AdsAppScreen.fromJson(Map<String, dynamic> json) {
    return AdsAppScreen(
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      appScreenSlug: json["app_screen_slug"] ?? '',
      appScreenName: json["app_screen_name"] ?? '',
    );
  }
}

class HomePlanOffer {
  int? offerId;
  String? title;
  String? image;
  String? offerType;
  int? offerValue;
  String? description;
  int? planId;

  HomePlanOffer({
    this.offerId,
    this.title,
    this.image,
    this.offerType,
    this.offerValue,
    this.description,
    this.planId,
  });

  HomePlanOffer.fromJson(Map<String, dynamic> json) {
    offerId = int.tryParse(json['id'].toString()) ?? 0;
    title = json['title']?.toString() ?? '';
    image = json['image']?.toString();
    offerType = json['offer_type']?.toString();
    offerValue = int.tryParse(json['offer_value'].toString());
    description = json['description']?.toString() ?? '';
    planId =
        json['plan'] != null ? int.tryParse(json['plan']['id'].toString()) : int.tryParse(json['plan_id'].toString());
  }
}

class AdsSchedule {
  int id;
  String adsType;
  String startTime;
  String endTime;

  AdsSchedule({
    required this.id,
    required this.adsType,
    required this.startTime,
    required this.endTime,
  });

  factory AdsSchedule.fromJson(Map<String, dynamic> json) {
    return AdsSchedule(
      id: json["id"] ?? 0,
      adsType: json["ads_type"].toString(),
      startTime: json["start_time"].toString(),
      endTime: json["end_time"].toString(),
    );
  }
}
