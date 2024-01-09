import 'package:equatable/equatable.dart';

class ProductCategoryArgs extends Equatable {
  final int categroyId;
  final String categoryName;

  const ProductCategoryArgs({required this.categroyId, required this.categoryName});

  @override
  List<Object?> get props => [categroyId];
}
