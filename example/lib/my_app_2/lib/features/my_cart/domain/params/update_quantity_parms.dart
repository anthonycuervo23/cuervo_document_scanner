import 'package:equatable/equatable.dart';

class UpdateQuantityParms extends Equatable {
  final int cartId;
  final int quantity;
  const UpdateQuantityParms({required this.cartId, required this.quantity});
  @override
  List<Object?> get props => [cartId, quantity];
}
