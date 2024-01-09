// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:equatable/equatable.dart';

class MyCartModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final MyCartEntity? data;

  MyCartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyCartModel.fromJson(Map<String, dynamic> json) => MyCartModel(
        status: json["status"] ?? false,
        message: json["message"].toString(),
        data: CartData.fromJson(json["data"]),
      );
}

class CartData extends MyCartEntity {
  final List<PaymentMethodModel> paymentMethods;
  final List<DeliveryTypeModel> deliveryType;
  final List<CartProductData> cart;
  final Overview overview;

  const CartData({
    required this.paymentMethods,
    required this.deliveryType,
    required this.cart,
    required this.overview,
  }) : super(cart: cart, deliveryType: deliveryType, paymentMethod: paymentMethods, overview: overview);

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        paymentMethods: json["payment_methods"] == null
            ? []
            : List<PaymentMethodModel>.from(
                json["payment_methods"]!.map((element) => PaymentMethodModel.fromJson(element))),
        deliveryType: json["delivery_type"] == null
            ? []
            : List<DeliveryTypeModel>.from(
                json["delivery_type"]!.map((element) => DeliveryTypeModel.fromJson(element))),
        cart: json["cart"] == null
            ? []
            : List<CartProductData>.from(json["cart"]!.map((element) => CartProductData.fromJson(element))),
        overview: Overview.fromJson(json["overview"]),
      );
}

class CartProductData {
  final int id;
  final ProductModel product;
  final int qty;

  CartProductData({
    required this.id,
    required this.product,
    required this.qty,
  });

  factory CartProductData.fromJson(Map<String, dynamic> json) => CartProductData(
        id: int.tryParse(json["id"].toString()) ?? 0,
        product: ProductModel.fromJson(json["product"]),
        qty: int.tryParse(json["qty"].toString()) ?? 0,
      );
}

class ProductModel {
  final int id;
  final int attributePriceId;
  final String name;
  final List<String> attributSlug;
  final List<String> attributs;
  final bool type;
  final String thumbnail;
  final String price;
  final double productPrice;
  final DiscountedPrice discountedPrice;
  final PurpleGst gst;
  final GstCalculationClass gstCalculation;

  ProductModel({
    required this.id,
    required this.attributePriceId,
    required this.name,
    required this.attributSlug,
    required this.attributs,
    required this.type,
    required this.thumbnail,
    required this.price,
    required this.productPrice,
    required this.discountedPrice,
    required this.gst,
    required this.gstCalculation,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: int.tryParse(json["id"].toString()) ?? 0,
        attributePriceId: int.tryParse(json["attribute_price_id"].toString()) ?? 0,
        name: json["name"].toString(),
        attributSlug:
            json["attribute_slug"] == null ? [] : List<String>.from(json["attribute_slug"].map((element) => element)),
        attributs: json["attributes"] == null ? [] : List<String>.from(json["attributes"].map((element) => element)),
        type: json["type"] == "Veg" ? true : false,
        thumbnail: json["thumbnail"].toString(),
        price: json["price"].toString(),
        productPrice: double.parse(json["price"].toString().replaceAll(',', '')),
        discountedPrice: DiscountedPrice.fromJson(json["discounted_price"]),
        gst: PurpleGst.fromJson(json["gst"]),
        gstCalculation: GstCalculationClass.fromJson(json["gst_calculation"]),
      );
}

class DiscountedPrice {
  final String price;
  final String discountAmount;

  DiscountedPrice({
    required this.price,
    required this.discountAmount,
  });

  factory DiscountedPrice.fromJson(Map<String, dynamic> json) => DiscountedPrice(
        price: json["price"].toString(),
        discountAmount: json["discount_amount"].toString(),
      );
}

class PurpleGst {
  final int sgst;
  final int cgst;

  PurpleGst({
    required this.sgst,
    required this.cgst,
  });

  factory PurpleGst.fromJson(Map<String, dynamic> json) => PurpleGst(
        sgst: int.tryParse(json["sgst"].toString()) ?? 0,
        cgst: int.tryParse(json["cgst"].toString()) ?? 0,
      );
}

class GstCalculationClass {
  final String total;
  final String sgst;
  final String cgst;

  GstCalculationClass({
    required this.total,
    required this.sgst,
    required this.cgst,
  });

  factory GstCalculationClass.fromJson(Map<String, dynamic> json) => GstCalculationClass(
        total: json["total"].toString(),
        sgst: json["sgst"].toString(),
        cgst: json["cgst"].toString(),
      );
}

class DeliveryTypeModel {
  final int id;
  final String name;
  final String price;
  final String afterTime;
  final double deliveryPrice;
  final int timeslotAllowed;
  final List<TimeslotModel> timeslots;

  DeliveryTypeModel({
    required this.id,
    required this.name,
    required this.price,
    required this.timeslotAllowed,
    required this.timeslots,
    required this.deliveryPrice,
    required this.afterTime,
  });

  factory DeliveryTypeModel.fromJson(Map<String, dynamic> json) => DeliveryTypeModel(
        id: int.tryParse(json["id"].toString()) ?? 0,
        name: json["name"].toString(),
        price: json["price"].toString(),
        deliveryPrice: double.parse(json["price"].toString().replaceAll(',', '')),
        afterTime: json["after_time"].toString(),
        timeslotAllowed: int.tryParse(json["timeslot_allowed"].toString()) ?? 0,
        timeslots: json["timeslots"] == null
            ? []
            : List<TimeslotModel>.from(json["timeslots"]!.map((element) => TimeslotModel.fromJson(element))),
      );
}

class TimeslotModel {
  final String day;
  final List<SlotModel> slots;

  TimeslotModel({
    required this.day,
    required this.slots,
  });

  factory TimeslotModel.fromJson(Map<String, dynamic> json) => TimeslotModel(
        day: json["day"].toString(),
        slots: json["slots"] == null
            ? []
            : List<SlotModel>.from(json["slots"]!.map((element) => SlotModel.fromJson(element))),
      );
}

class SlotModel {
  final String start;
  final String end;

  SlotModel({
    required this.start,
    required this.end,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
        start: json["start"].toString(),
        end: json["end"].toString(),
      );
}

class Overview extends Equatable {
  final String total;
  final String discount;
  final double discountPrice;
  final String totalAfterDiscount;
  final String grandTotal;
  final double grandTotalPrice;
  final GstCalculationClass gst;

  const Overview({
    required this.total,
    required this.discount,
    required this.discountPrice,
    required this.totalAfterDiscount,
    required this.grandTotal,
    required this.grandTotalPrice,
    required this.gst,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        total: json["total"].toString(),
        discount: json["discount"].toString(),
        discountPrice: double.parse(json["discount"].toString().replaceAll(',', '')),
        totalAfterDiscount: json["total_after_discount"].toString(),
        grandTotal: json["grand_total"].toString(),
        grandTotalPrice: double.parse(json["grand_total"].toString().replaceAll(',', '')),
        gst: GstCalculationClass.fromJson(json["gst"]),
      );

  Overview copyWith({
    String? total,
    String? discount,
    double? discountPrice,
    String? totalAfterDiscount,
    String? grandTotal,
    double? grandTotalPrice,
    GstCalculationClass? gst,
  }) {
    return Overview(
      total: total ?? this.total,
      discount: discount ?? this.discount,
      discountPrice: discountPrice ?? this.discountPrice,
      totalAfterDiscount: totalAfterDiscount ?? this.totalAfterDiscount,
      grandTotal: grandTotal ?? this.grandTotal,
      grandTotalPrice: grandTotalPrice ?? this.grandTotalPrice,
      gst: gst ?? this.gst,
    );
  }

  @override
  List<Object?> get props => [total, discount, totalAfterDiscount, grandTotal, grandTotalPrice, gst, discountPrice];
}

class PaymentMethodModel {
  final String id;
  final String name;

  PaymentMethodModel({
    required this.id,
    required this.name,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => PaymentMethodModel(
        id: json["id"].toString(),
        name: json["name"].toString(),
      );
}
