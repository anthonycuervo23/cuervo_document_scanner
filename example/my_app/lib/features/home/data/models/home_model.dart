// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/home/domain/entitys/home_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class HomeModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final HomeEntity? data;

  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: HomeDataModel.fromJson(json["data"]),
      );
}

class HomeDataModel extends HomeEntity {
  final List<BannerData> banners;
  final List<CategoryDataModel> categories;

  const HomeDataModel({
    required this.banners,
    required this.categories,
  }) : super(banners: banners, categories: categories);

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        banners: json["banners"] == null
            ? []
            : List<BannerData>.from(json["banners"]!.map((element) => BannerData.fromJson(element))),
        categories: json["categories"] == null
            ? []
            : List<CategoryDataModel>.from(json["categories"]!.map((element) => CategoryDataModel.fromJson(element))),
      );
}

class BannerData {
  final int id;
  final String banner;
  final String showLink;
  final String showLinkValue;

  BannerData({
    required this.id,
    required this.banner,
    required this.showLink,
    required this.showLinkValue,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"] ?? 0,
        banner: json["banner"] ?? "",
        showLink: json["show_link"] ?? "",
        showLinkValue: json["show_link_value"] ?? "",
      );
}

class CategoryDataModel {
  final int id;
  final String name;
  final String image;

  CategoryDataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
      );
}
