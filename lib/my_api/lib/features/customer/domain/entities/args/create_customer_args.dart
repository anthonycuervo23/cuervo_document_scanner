import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:equatable/equatable.dart';

class CreateCustomerArgs extends Equatable {
  final CreateNewNavigate navigate;
  final CustomerDetailModel? customerModel;
  final SupplierDetailModel? supplierModel;
  final bool isForEdit;

  const CreateCustomerArgs({required this.navigate, this.customerModel, this.supplierModel, required this.isForEdit});

  CreateCustomerArgs copyWith({
    CreateNewNavigate? navigate,
    CustomerDetailModel? customerModel,
    SupplierDetailModel? supplierModel,
    bool? isForEdit,
  }) {
    return CreateCustomerArgs(
      navigate: navigate ?? this.navigate,
      customerModel: customerModel ?? this.customerModel,
      supplierModel: supplierModel ?? this.supplierModel,
      isForEdit: isForEdit ?? this.isForEdit,
    );
  }

  @override
  List<Object?> get props => [navigate, customerModel, supplierModel, isForEdit];
}
