// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class ReferralCodeModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final ReferralCodeData data;

  ReferralCodeModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ReferralCodeModel.fromJson(Map<String, dynamic> json) => ReferralCodeModel(
        status: json["status"],
        message: json["message"],
        data: ReferralCodeData.fromJson(json["data"]),
      );
}

class ReferralCodeData {
  const ReferralCodeData() : super();
  factory ReferralCodeData.fromJson(Map<String, dynamic> json) => const ReferralCodeData();
}
