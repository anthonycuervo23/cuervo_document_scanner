// ignore_for_file: prefer_const_constructors_in_immutables, overridden_fields, annotate_overrides

import 'package:bakery_shop_flutter/features/products/domain/entities/produt_category_entites.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/model_response_extends.dart';

class CategoryDataModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final ProductCategoryEntity? data;

  CategoryDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) => CategoryDataModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null ? ProductCategoryDataModel.fromJson(json["data"]) : null,
      );
}

class ProductCategoryDataModel extends ProductCategoryEntity {
  final List<CategoryModel> categories;

  ProductCategoryDataModel({
    required this.categories,
  }) : super(categoryList: categories);

  factory ProductCategoryDataModel.fromJson(Map<String, dynamic> json) => ProductCategoryDataModel(
        categories: json["categories"] == null
            ? []
            : List<CategoryModel>.from(json["categories"].map((element) => CategoryModel.fromJson(element))),
      );
}

class CategoryModel {
  final int id;
  final String name;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] ?? 1,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
      );
}
