import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/productsCubit/products_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/products_screen/products_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class OrderScreenArgs extends Equatable {
  List<ProductModel> selectedProduct;
  ProductsCubit productCubit;
  OpeneingOrderScreenFrom openeingOrderScreenFrom;
  bool displayAppBar;
  CustomerDetailModel? customerDetailModel;

  OrderScreenArgs({
    required this.productCubit,
    required this.selectedProduct,
    required this.openeingOrderScreenFrom,
    required this.displayAppBar,
    this.customerDetailModel,
  });

  OrderScreenArgs copyWith({
    List<ProductModel>? selectedProduct,
    ProductsCubit? productCubit,
    OpeneingOrderScreenFrom? openeingOrderScreenFrom,
    bool? displayAppBar,
    CustomerDetailModel? customerDetailModel,
  }) {
    return OrderScreenArgs(
      productCubit: productCubit ?? this.productCubit,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      openeingOrderScreenFrom: openeingOrderScreenFrom ?? this.openeingOrderScreenFrom,
      displayAppBar: displayAppBar ?? this.displayAppBar,
      customerDetailModel: customerDetailModel ?? this.customerDetailModel,
    );
  }

  @override
  List<Object?> get props => [
        selectedProduct,
        productCubit,
        openeingOrderScreenFrom,
        displayAppBar,
        customerDetailModel,
      ];
}
