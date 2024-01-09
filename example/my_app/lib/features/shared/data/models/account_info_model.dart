// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/account_info_entity.dart';

class AccountInfoModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final AccountInfoEntity? data;

  AccountInfoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) => AccountInfoModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? AccountInfoData.fromJson(json["data"]) : null,
      );
}

class AccountInfoData extends AccountInfoEntity {
  final int id;
  final String name;
  final String subDomain;
  final String image;
  final String defaultImage;
  final AppSetting appSetting;

  const AccountInfoData({
    required this.id,
    required this.name,
    required this.subDomain,
    required this.image,
    required this.defaultImage,
    required this.appSetting,
  }) : super(
          id: id,
          name: name,
          subDomain: subDomain,
          image: image,
          defaultImage: defaultImage,
          appSetting: appSetting,
        );

  factory AccountInfoData.fromJson(Map<String, dynamic> json) => AccountInfoData(
        id: json["id"] ?? 1,
        name: json["name"] ?? "",
        subDomain: json["sub_domain"] ?? "",
        image: json["image"] ?? "",
        defaultImage: json["default_image"] ?? "",
        appSetting: AppSetting.fromJson(json["app_setting"]),
      );
}

class AppSetting {
  final FontsData fonts;
  final String primaryColor;
  final String secondaryColor;
  final double buttonRadius;
  final double productCardRadius;

  AppSetting({
    required this.fonts,
    required this.primaryColor,
    required this.secondaryColor,
    required this.buttonRadius,
    required this.productCardRadius,
  });

  factory AppSetting.fromJson(Map<String, dynamic> json) => AppSetting(
        fonts: FontsData.fromJson(json["fonts"]),
        primaryColor: json["primary_color"] ?? 'B75400',
        secondaryColor: json["secondary_color"] ?? '222222',
        buttonRadius: double.tryParse(json["button_radius"].toString()) ?? 0,
        productCardRadius: double.tryParse(json["product_card_radius"].toString()) ?? 0,
      );
}

class FontsData {
  final FontType h1;
  final FontType h2;
  final FontType h3;
  final FontType h4;
  final FontType subTitle1;
  final FontType subTitle2;
  final FontType body;
  final FontType caption;
  final FontType overline;

  FontsData({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.subTitle1,
    required this.subTitle2,
    required this.body,
    required this.caption,
    required this.overline,
  });

  factory FontsData.fromJson(Map<String, dynamic> json) => FontsData(
        h1: FontType.fromJson(json["h1"]),
        h2: FontType.fromJson(json["h2"]),
        h3: FontType.fromJson(json["h3"]),
        h4: FontType.fromJson(json["h4"]),
        subTitle1: FontType.fromJson(json["sub_title_1"]),
        subTitle2: FontType.fromJson(json["sub_title_2"]),
        body: FontType.fromJson(json["body"]),
        caption: FontType.fromJson(json["caption"]),
        overline: FontType.fromJson(json["overline"]),
      );
}

class FontType {
  final Heading boldHeading;
  final Heading mediumHeading;
  final Heading bookHeading;
  final Heading lightHeading;

  FontType({
    required this.boldHeading,
    required this.mediumHeading,
    required this.bookHeading,
    required this.lightHeading,
  });

  factory FontType.fromJson(Map<String, dynamic> json) => FontType(
        boldHeading: Heading.fromJson(json["bold_heading"]),
        mediumHeading: Heading.fromJson(json["medium_heading"]),
        bookHeading: Heading.fromJson(json["book_heading"]),
        lightHeading: json["light_heading"] == null
            ? Heading(fontFamily: 'Circular Std', fontSize: 19, fontWeight: 300)
            : Heading.fromJson(json["light_heading"]),
      );
}

class Heading {
  final int fontWeight;
  final double fontSize;
  final String fontFamily;

  Heading({
    required this.fontWeight,
    required this.fontSize,
    required this.fontFamily,
  });

  factory Heading.fromJson(Map<String, dynamic> json) => Heading(
        fontWeight: json["font_weight"] ?? 500,
        fontSize: json["font_size"] == null ? 14 : double.parse(json["font_size"].toString()),
        fontFamily: json["font_family"] ?? "",
      );
}
