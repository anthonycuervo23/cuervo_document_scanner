// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/upload_file_entity.dart';

class UploadFileModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final UploadFileEntity? data;

  UploadFileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UploadFileModel.fromJson(Map<String, dynamic> json) => UploadFileModel(
        status: json["status"],
        message: json["message"],
        data:json["data"] != null? UploadFileData.fromJson(json["data"]):null,
      );
}

class UploadFileData extends UploadFileEntity {
  final String path;
  final String fullPath;

  const UploadFileData({
    required this.path,
    required this.fullPath,
  }) : super(
          path: path,
          fullPath: fullPath,
        );

  factory UploadFileData.fromJson(Map<String, dynamic> json) => UploadFileData(
        path: json["path"] ?? '',
        fullPath: json["full_path"] ?? '',
      );
}
