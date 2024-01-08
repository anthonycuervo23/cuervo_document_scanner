// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_admin_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_admin_flutter/features/shared/data/models/model_response_extends.dart';

class PolicyModel extends ModelResponseExtend {
  final bool status;
  final int success;
  final String message;
  final List<PolicyEntity> data;

  PolicyModel({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<PolicyEntity>.from(json["data"]!.map((x) => PolicyData.fromJson(x))),
      );
}

class PolicyData extends PolicyEntity {
  final int id;
  final String slug;
  final String title;
  final String description;
  final String bannerImage;

  const PolicyData({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.bannerImage,
  }) : super(
          id: id,
          slug: slug,
          title: title,
          description: description,
          bannerImage: bannerImage,
        );

  factory PolicyData.fromJson(Map<String, dynamic> json) => PolicyData(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        bannerImage: json["banner_image"],
      );
}
