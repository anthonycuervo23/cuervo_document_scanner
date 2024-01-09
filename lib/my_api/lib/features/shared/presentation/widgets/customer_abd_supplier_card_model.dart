import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:equatable/equatable.dart';

class CustomerAndSupplierCardModel extends Equatable {
  final String name;
  final String mobileNumber;
  final String orderAmount;
  final String balanceAmount;
  final String image;
  final String date;
  final CustomerBalanceType balanceAmountType;
  final bool? isPending;
  final String? totalItem;
  final CustomerType? customerType;

  const CustomerAndSupplierCardModel({
    required this.name,
    required this.mobileNumber,
    required this.orderAmount,
    required this.balanceAmount,
    required this.image,
    required this.date,
    required this.balanceAmountType,
    this.isPending,
    this.totalItem,
    this.customerType,
  });

  CustomerAndSupplierCardModel copyWith({
    String? name,
    String? mobileNumber,
    String? orderAmount,
    String? balanceAmount,
    String? image,
    String? date,
    bool? isPending,
    String? totalItem,
    CustomerType? customerType,
    CustomerBalanceType? balanceAmountType,
  }) {
    return CustomerAndSupplierCardModel(
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      orderAmount: orderAmount ?? this.orderAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      image: image ?? this.image,
      date: date ?? this.date,
      balanceAmountType: balanceAmountType ?? this.balanceAmountType,
      customerType: customerType,
      isPending: isPending,
      totalItem: totalItem,
    );
  }

  @override
  List<Object?> get props => [
        name,
        mobileNumber,
        orderAmount,
        balanceAmount,
        image,
        date,
        isPending,
        totalItem,
        customerType,
        balanceAmountType,
      ];
}
