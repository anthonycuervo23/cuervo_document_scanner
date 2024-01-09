import 'package:equatable/equatable.dart';

class ProductDataParms extends Equatable {
  final int? categoryId;
  final List<String>? filterOrderBy;
  final int? page;

  const ProductDataParms({
    this.categoryId,
    this.filterOrderBy,
    this.page,
  });
  @override
  List<Object?> get props => [categoryId, filterOrderBy, page];
}
