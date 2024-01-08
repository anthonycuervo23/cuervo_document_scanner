import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/products_screen/products_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProductScreenArgs extends Equatable {
  final OpeneingOrderScreenFrom openeingOrderScreenFrom;
  final bool displayAppBar;
  final CustomerDetailModel? customerDetailModel;

  const ProductScreenArgs({required this.openeingOrderScreenFrom, required this.displayAppBar, this.customerDetailModel});

  ProductScreenArgs copyWith({
    OpeneingOrderScreenFrom? openeingOrderScreenFrom,
    bool? displayAppBar,
    CustomerDetailModel? customerDetailModel,
  }) {
    return ProductScreenArgs(
      openeingOrderScreenFrom: openeingOrderScreenFrom ?? this.openeingOrderScreenFrom,
      displayAppBar: displayAppBar ?? this.displayAppBar,
      customerDetailModel: customerDetailModel ?? this.customerDetailModel,
    );
  }

  @override
  List<Object?> get props => [openeingOrderScreenFrom, displayAppBar,customerDetailModel];
}
