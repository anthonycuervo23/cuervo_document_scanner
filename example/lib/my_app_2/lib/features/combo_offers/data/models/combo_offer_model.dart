// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/combo_offers/domain/entities/combo_offer_entity.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';
import 'package:equatable/equatable.dart';

class ComboOfferModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final ComboProductEntity? data;

  ComboOfferModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory ComboOfferModel.fromJson(Map<String, dynamic> json) => ComboOfferModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? ComboProductList.fromJson(json["data"]) : null,
      );
}

class ComboProductList extends ComboProductEntity {
  final int from;
  final int to;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final String nextPageUrl;
  final String prevPageUrl;
  final int total;
  final List<ComboProductModel> productList;

  const ComboProductList({
    required this.from,
    required this.to,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.total,
    required this.productList,
  }) : super(
          productList: productList,
          from: from,
          to: to,
          currentPage: currentPage,
          lastPage: lastPage,
          perPage: perPage,
          nextPageUrl: nextPageUrl,
          prevPageUrl: prevPageUrl,
          total: total,
        );

  factory ComboProductList.fromJson(Map<String, dynamic> json) => ComboProductList(
        from: json["from"] ?? 1,
        to: json["to"] ?? 1,
        currentPage: json["current_page"] ?? 1,
        lastPage: json["last_page"] ?? 1,
        perPage: json["per_page"] ?? 1,
        nextPageUrl: json["next_page_url"] ?? "",
        prevPageUrl: json["prev_page_url"] ?? "",
        total: json["total"] ?? 1,
        productList: json["items"] == null
            ? []
            : List<ComboProductModel>.from(json["items"].map((x) => ComboProductModel.fromJson(x))),
      );
}

class ComboProductModel extends Equatable {
  final int id;
  final String name;
  final String type;
  final String thumbnail;
  final List<String> images;
  final String price;
  final DiscountedPrice discountedPrice;
  final List<RelatedProduct> relatedProducts;
  final String startDate;
  final String endDate;
  final int totalItem;

  const ComboProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.thumbnail,
    required this.images,
    required this.price,
    required this.discountedPrice,
    required this.relatedProducts,
    required this.startDate,
    required this.endDate,
    required this.totalItem,
  });

  factory ComboProductModel.fromJson(Map<String, dynamic> json) => ComboProductModel(
        id: json["id"] ?? 1,
        name: json["name"] ?? '',
        type: json["type"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"] ?? '',
        discountedPrice: DiscountedPrice.fromJson(json["discounted_price"]),
        relatedProducts: List<RelatedProduct>.from(json["related_products"].map((x) => RelatedProduct.fromJson(x))),
        startDate: json["start_date"] ?? '',
        endDate: json["end_date"] ?? '',
        totalItem: 0,
      );

  ComboProductModel copyWith({
    int? id,
    String? name,
    String? type,
    String? thumbnail,
    List<String>? images,
    String? price,
    DiscountedPrice? discountedPrice,
    List<RelatedProduct>? relatedProducts,
    String? startDate,
    String? endDate,
    int? totalItem,
  }) {
    return ComboProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      price: price ?? this.price,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalItem: totalItem ?? this.totalItem,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        thumbnail,
        images,
        price,
        discountedPrice,
        relatedProducts,
        startDate,
        endDate,
        totalItem,
      ];
}

class DiscountedPrice {
  String price;
  String discountAmount;

  DiscountedPrice({
    required this.price,
    required this.discountAmount,
  });

  factory DiscountedPrice.fromJson(Map<String, dynamic> json) => DiscountedPrice(
        price: json["price"] ?? '',
        discountAmount: json["discount_amount"] ?? '',
      );
}

class RelatedProduct {
  String name;
  String price;

  RelatedProduct({
    required this.name,
    required this.price,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
        name: json["name"] ?? '',
        price: json["price"] ?? '',
      );
}
