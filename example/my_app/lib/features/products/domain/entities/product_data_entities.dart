import 'package:bakery_shop_flutter/features/products/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductDataEntity extends Equatable {
  final List<ProductItem> productList;
  final int? from;
  final int? to;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final String nextPageUrl;
  final String prevPageUrl;
  final int total;

  const ProductDataEntity({
    required this.productList,
    required this.from,
    required this.to,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
    required this.total,
  });

  @override
  List<Object?> get props => [
        productList,
        from,
        to,
        currentPage,
        lastPage,
        perPage,
        nextPageUrl,
        prevPageUrl,
        total,
      ];
}
