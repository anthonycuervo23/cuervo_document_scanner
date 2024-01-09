import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object?> get props => [];
}

class CustomerLoadingState extends CustomerState {
  @override
  List<Object> get props => [];
}

class CustomerLoadedState extends CustomerState {
  final List<CustomerDetailModel> customerDetailList;
  final List<CustomerDetailModel>? filterList;
  final double? random;

  const CustomerLoadedState({required this.customerDetailList, this.random, this.filterList});

  CustomerLoadedState copyWith({
    List<CustomerDetailModel>? customerDetailList,
    double? random,
    List<CustomerDetailModel>? filterList,
  }) {
    return CustomerLoadedState(
      customerDetailList: customerDetailList ?? this.customerDetailList,
      random: random ?? this.random,
      filterList: filterList ?? this.filterList,
    );
  }

  @override
  List<Object?> get props => [customerDetailList, random, filterList];
}

class CustomerErrorState extends CustomerState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const CustomerErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
