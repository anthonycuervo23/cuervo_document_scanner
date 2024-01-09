import 'package:bakery_shop_flutter/features/products/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductDetailsArgs extends Equatable {
  final ProductItem productData;
  final bool visibleImage;

  const ProductDetailsArgs({
    required this.productData,
    required this.visibleImage,
  });
  @override
  List<Object?> get props => [productData, visibleImage];
}
