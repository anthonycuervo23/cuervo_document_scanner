import 'package:bakery_shop_flutter/features/products/data/models/product_category_model.dart';
import 'package:equatable/equatable.dart';

class ProductCategoryEntity extends Equatable {
  final List<CategoryModel> categoryList;

  const ProductCategoryEntity({required this.categoryList});

  @override
  List<Object?> get props => [categoryList];
}
