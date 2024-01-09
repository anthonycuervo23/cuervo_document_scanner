// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class AddProductMyCartParms extends Equatable {
  final int? productId;
  final int? productPriceId;
  final int qty;

  const AddProductMyCartParms({this.productId, this.productPriceId, required this.qty});

  @override
  List<Object?> get props => [productId, productPriceId, qty];
}
