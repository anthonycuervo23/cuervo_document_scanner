// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class CouponApplyModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final CouponApplyData? data;

  CouponApplyModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory CouponApplyModel.fromJson(Map<String, dynamic> json) => CouponApplyModel(
        status: json["status"],
        message: json["message"],
        data: json["data"].isEmpty ? null : CouponApplyData.fromJson(json["data"]),
      );
}

class CouponApplyData {
  final CouponData? coupon;

  CouponApplyData({this.coupon});

  factory CouponApplyData.fromJson(Map<String, dynamic> json) => CouponApplyData(
        coupon: json["coupon"] == null ? null : CouponData.fromJson(json["coupon"]),
      );
}

class CouponData {
  final String code;
  final String type;
  final String amount;
  final String orderLimit;
  final DateTime startDate;
  final DateTime endDate;
  final String? applyOrNot;

  CouponData({
    required this.code,
    required this.type,
    required this.amount,
    required this.orderLimit,
    required this.startDate,
    required this.endDate,
    this.applyOrNot,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
        code: json["code"].toString(),
        type: json["type"].toString(),
        amount: json["amount"].toString(),
        orderLimit: json["order_limit"].toString(),
        startDate: json["start_date"] == null ? DateTime.now() : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? DateTime.now() : DateTime.parse(json["end_date"]),
      );
}
