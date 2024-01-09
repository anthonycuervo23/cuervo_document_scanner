// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/offers/domain/entities/offer_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:equatable/equatable.dart';

class OfferModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final OfferDataEntity? data;

  OfferModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: CouponsData.fromJson(json["data"]),
      );
}

class CouponsData extends OfferDataEntity {
  final List<SingleCouponData> coupons;

  const CouponsData({
    required this.coupons,
  }) : super(coupons: coupons);

  factory CouponsData.fromJson(Map<String, dynamic> json) => CouponsData(
        coupons: json["coupons"] == null
            ? []
            : List<SingleCouponData>.from(json["coupons"].map((element) => SingleCouponData.fromJson(element))),
      );
}

class SingleCouponData extends Equatable {
  final int id;
  final String title;
  final String type;
  final String amount;
  final String code;
  final String orderLimit;
  final String shortDescription;
  final String description;
  bool isOpenViewDetails;

  SingleCouponData({
    required this.id,
    required this.title,
    required this.type,
    required this.amount,
    required this.code,
    required this.orderLimit,
    required this.shortDescription,
    required this.description,
    required this.isOpenViewDetails,
  });

  factory SingleCouponData.fromJson(Map<String, dynamic> json) => SingleCouponData(
        id: json["id"] ?? 0,
        title: json["title"].toString(),
        type: json["type"].toString(),
        amount: json["amount"].toString(),
        code: json["code"].toString(),
        orderLimit: json["order_limit"].toString(),
        shortDescription: json["short_description"].toString(),
        description: json["description"].toString(),
        isOpenViewDetails: false,
      );

  SingleCouponData copyWith({
    int? id,
    String? title,
    String? type,
    String? amount,
    String? code,
    String? orderLimit,
    String? shortDescription,
    String? description,
    bool? isOpenViewDetails,
  }) {
    return SingleCouponData(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      code: code ?? this.code,
      orderLimit: orderLimit ?? this.orderLimit,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      isOpenViewDetails: isOpenViewDetails ?? this.isOpenViewDetails,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        amount,
        code,
        orderLimit,
        shortDescription,
        description,
        isOpenViewDetails,
      ];
}
