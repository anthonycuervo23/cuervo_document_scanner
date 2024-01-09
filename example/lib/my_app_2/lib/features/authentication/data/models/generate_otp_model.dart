// ignore_for_file: annotate_overrides, overridden_fields

import 'package:bakery_shop_flutter/features/authentication/domain/entities/generate_otp_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class GenerateOtpModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final GenerateOtpEntity? data;

  GenerateOtpModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory GenerateOtpModel.fromJson(Map<String, dynamic> json) => GenerateOtpModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? GenerateOtpData.fromJson(json["data"]) : null,
      );
}

class GenerateOtpData extends GenerateOtpEntity {
  final String otp;
  final bool isUserNew;
  final String token;

  const GenerateOtpData({required this.otp, required this.isUserNew, required this.token})
      : super(otp: otp, isUserNew: isUserNew, token: token);

  factory GenerateOtpData.fromJson(Map<String, dynamic> json) => GenerateOtpData(
        otp: json["otp"] ?? "",
        isUserNew: json["is_new_customer"] == 1 ? true : false,
        token: json["token"] ?? "",
      );
}
