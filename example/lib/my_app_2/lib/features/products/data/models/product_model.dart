// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

import 'package:equatable/equatable.dart';

import 'package:bakery_shop_flutter/features/products/domain/entities/product_data_entities.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class ProductModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final ProductDataEntity? data;

  ProductModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? ProductData.fromJson(json["data"]) : null,
      );
}

class ProductData extends ProductDataEntity {
  final int from;
  final int to;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final String nextPageUrl;
  final String prevPageUrl;
  final int total;
  final List<ProductItem> productList;

  const ProductData({
    required this.productList,
    required this.from,
    required this.to,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.total,
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

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
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
            : List<ProductItem>.from(json["items"]?.map((element) => ProductItem.fromJson(element))),
      );
}

class ProductItem extends Equatable {
  final int id;
  final String name;
  final bool vegNonVeg;
  final bool isBestseller;
  final String thumbnail;
  final List<dynamic> images;
  final String price;
  final double productPrice;
  final DiscountedPrice discountedPrice;
  final String discount;
  final String discountType;
  final String description;
  final List<ProductQuantityAttributes> productQuantityAttributes;
  final List<ProductQuantityAttributesPrice> productQuantityAttributesPrice;
  final int totalItem;

  const ProductItem({
    required this.id,
    required this.name,
    required this.vegNonVeg,
    required this.isBestseller,
    required this.thumbnail,
    required this.images,
    required this.price,
    required this.productPrice,
    required this.discountedPrice,
    required this.discount,
    required this.discountType,
    required this.description,
    required this.productQuantityAttributes,
    required this.productQuantityAttributesPrice,
    required this.totalItem,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"] ?? 1,
        name: json["name"] ?? "",
        vegNonVeg: json["type"] == "Veg" ? true : false,
        isBestseller: json["is_bestseller"] == 1 ? true : false,
        thumbnail: json["thumbnail"] ?? "",
        images: json["images"] == null ? [] : List<dynamic>.from(json["images"]?.map((element) => element)),
        price: json["price"] ?? "",
        productPrice: double.parse(json["price"].toString().replaceAll(',', '')),
        discountedPrice: DiscountedPrice.fromJson(json["discounted_price"]),
        discount: json["discount"] ?? "",
        discountType: json["discount_type"] ?? "",
        description: json["description"] ?? "",
        productQuantityAttributes: json["attributes"] == null
            ? []
            : List<ProductQuantityAttributes>.from(
                json["attributes"].map((element) => ProductQuantityAttributes.fromJson(element))),
        productQuantityAttributesPrice: json["attributes_prices"] == null
            ? []
            : List<ProductQuantityAttributesPrice>.from(
                json["attributes_prices"]?.map((element) => ProductQuantityAttributesPrice.fromJson(element))),
        totalItem: 0,
      );

  ProductItem copyWith({
    int? id,
    String? name,
    bool? vegNonVeg,
    bool? isBestseller,
    String? thumbnail,
    List<dynamic>? images,
    String? price,
    double? productPrice,
    DiscountedPrice? discountedPrice,
    String? discount,
    String? discountType,
    String? description,
    List<ProductQuantityAttributes>? productQuantityAttributes,
    List<ProductQuantityAttributesPrice>? productQuantityAttributesPrice,
    int totalItem = 0,
  }) {
    return ProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      vegNonVeg: vegNonVeg ?? this.vegNonVeg,
      isBestseller: isBestseller ?? this.isBestseller,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      price: price ?? this.price,
      productPrice: productPrice ?? this.productPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      discount: discount ?? this.discount,
      discountType: discountType ?? this.discountType,
      description: description ?? this.description,
      productQuantityAttributes: productQuantityAttributes ?? this.productQuantityAttributes,
      productQuantityAttributesPrice: productQuantityAttributesPrice ?? this.productQuantityAttributesPrice,
      totalItem: totalItem,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        vegNonVeg,
        isBestseller,
        thumbnail,
        images,
        price,
        productPrice,
        discountedPrice,
        discount,
        discountType,
        description,
        productQuantityAttributes,
        productQuantityAttributesPrice,
        totalItem,
      ];
}

class ProductQuantityAttributes {
  final String name;
  final List<ProductQuantityOption> options;

  ProductQuantityAttributes({
    required this.name,
    required this.options,
  });

  factory ProductQuantityAttributes.fromJson(Map<String, dynamic> json) => ProductQuantityAttributes(
        name: json["name"] ?? "",
        options: json["options"] == null
            ? []
            : List<ProductQuantityOption>.from(
                json["options"]?.map((element) => ProductQuantityOption.fromJson(element)),
              ),
      );
}

class ProductQuantityOption {
  final String value;
  final String slug;

  ProductQuantityOption({
    required this.value,
    required this.slug,
  });

  factory ProductQuantityOption.fromJson(Map<String, dynamic> json) => ProductQuantityOption(
        value: json["value"] ?? "",
        slug: json["slug"] ?? "",
      );
}

class ProductQuantityAttributesPrice {
  final int id;
  final List<dynamic> slugs;
  final String price;
  final double productPrice;
  final DiscountedPrice discountedPrice;

  ProductQuantityAttributesPrice({
    required this.id,
    required this.slugs,
    required this.price,
    required this.productPrice,
    required this.discountedPrice,
  });

  factory ProductQuantityAttributesPrice.fromJson(Map<String, dynamic> json) => ProductQuantityAttributesPrice(
        id: json["id"] ?? 0,
        slugs: json["slugs"] ?? List<dynamic>.from(json["slugs"]?.map((element) => element)),
        price: json["price"].toString(),
        productPrice: double.parse(json["price"].toString().replaceAll(',', '')),
        discountedPrice: DiscountedPrice.fromJson(json["discounted_price"] ?? {}),
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
        price: json["price"] ?? "",
        discountAmount: json["discount_amount"] ?? "",
      );
}
