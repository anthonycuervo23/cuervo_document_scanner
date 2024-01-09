// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class PostApiResponse extends ModelResponseExtend {
  final bool status;
  final String message;
  final PostApiData data;

  PostApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PostApiResponse.fromJson(Map<String, dynamic> json) => PostApiResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: PostApiData.fromJson(json["data"]),
      );
}

class PostApiData {
  PostApiData();

  factory PostApiData.fromJson(Map<String, dynamic> json) => PostApiData();

  Map<String, dynamic> toJson() => {};
}
