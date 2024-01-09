// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class UploadPicture extends ModelResponseExtend {
  final bool status;
  final String message;
  final ImageData data;

  UploadPicture({required this.status, required this.message, required this.data});

  factory UploadPicture.fromJson(Map<String, dynamic> json) => UploadPicture(
        status: json["status"],
        message: json["message"],
        data: ImageData.fromJson(json["data"]),
      );
}

class ImageData {
  final String path;
  final String fullPath;

  ImageData({required this.path, required this.fullPath});

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        path: json["path"] ?? "",
        fullPath: json["full_path"] ?? "",
      );
}
