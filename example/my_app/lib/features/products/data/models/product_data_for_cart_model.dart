import 'package:hive/hive.dart';

part 'product_data_for_cart_model.g.dart';

@HiveType(typeId: 13)
class ProductDataForCartModel extends HiveObject {
  @HiveField(0)
  int productId;
  @HiveField(1)
  String productName;
  @HiveField(2)
  double productPrice;
  @HiveField(3)
  int productAttributsId;
  @HiveField(4)
  List<String> slugs;
  @HiveField(5)
  double productSlugPrice;
  @HiveField(6)
  int totalProduct;

  ProductDataForCartModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productAttributsId,
    required this.slugs,
    required this.productSlugPrice,
    required this.totalProduct,
  });

  ProductDataForCartModel copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    int? productAttributsId,
    List<String>? slugs,
    double? productSlugPrice,
    int? totalProduct,
  }) {
    return ProductDataForCartModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productAttributsId: productAttributsId ?? this.productAttributsId,
      slugs: slugs ?? this.slugs,
      productSlugPrice: productSlugPrice ?? this.productSlugPrice,
      totalProduct: totalProduct ?? this.totalProduct,
    );
  }
}
