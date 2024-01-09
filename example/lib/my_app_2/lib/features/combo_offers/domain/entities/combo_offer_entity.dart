import 'package:bakery_shop_flutter/features/combo_offers/data/models/combo_offer_model.dart';
import 'package:equatable/equatable.dart';

class ComboProductEntity extends Equatable {
  final List<ComboProductModel> productList;
  final int? from;
  final int? to;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final String nextPageUrl;
  final String prevPageUrl;
  final int total;

  const ComboProductEntity({
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
