// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class VerifyOtpModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final VerifyOtpEntity? data;

  VerifyOtpModel({required this.status, required this.message, required this.data});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? VerifyOtpData.fromJson(json["data"]) : null,
      );
}

class VerifyOtpData extends VerifyOtpEntity {
  final String token;
  const VerifyOtpData({required this.token}) : super(token: token);
  factory VerifyOtpData.fromJson(Map<String, dynamic> json) => VerifyOtpData(token: json["token"] ?? "");
}
