part of 'supplier_cubit.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();

  @override
  List<Object?> get props => [];
}

class SupplierLoadingState extends SupplierState {
  @override
  List<Object?> get props => [];
}

class SupplierLoadedState extends SupplierState {
  final List<SupplierDetailModel> supplierDetailList;
  final List<SupplierDetailModel>? filterList;
  final double? random;

  const SupplierLoadedState({required this.supplierDetailList, this.filterList, this.random});

  SupplierLoadedState copyWith({
    List<SupplierDetailModel>? supplierDetailList,
    double? random,
    List<SupplierDetailModel>? filterList,
  }) {
    return SupplierLoadedState(
      supplierDetailList: supplierDetailList ?? this.supplierDetailList,
      random: random ?? this.random,
      filterList: filterList ?? this.filterList,
    );
  }

  @override
  List<Object?> get props => [supplierDetailList, random, filterList];
}

class CustomerErrorState extends SupplierState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const CustomerErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
