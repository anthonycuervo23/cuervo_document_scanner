// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/settings/domain/entities/terms_condition_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class PolicyModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final PolicyEntity? data;

  PolicyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        status: json['status'],
        message: json['message'],
        data: json["data"] != null ? PolicyData.fromJson(json["data"]) : null,
      );
}

class PolicyData extends PolicyEntity {
  final String title;
  final String description;

  const PolicyData({required this.title, required this.description}) : super(title: title, description: description);

  factory PolicyData.fromJson(Map<String, dynamic> json) => PolicyData(
        title: json['title'] ?? "",
        description: json['description'] ?? "",
      );
}
