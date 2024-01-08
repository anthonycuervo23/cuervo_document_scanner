part of 'supplierdetails_cubit.dart';

sealed class SupplierdetailsState extends Equatable {
  const SupplierdetailsState();

  @override
  List<Object> get props => [];
}

final class SupplierdetailsLoading extends SupplierdetailsState {
  @override
  List<Object> get props => [];
}

class SupplierDetailsLoadedState extends SupplierdetailsState {
  final int tab;

  SupplierDetailsLoadedState copyWith({int? tab}) {
    return SupplierDetailsLoadedState(
      tab: tab ?? this.tab,
    );
  }

  const SupplierDetailsLoadedState({
    required this.tab,
  });
  @override
  List<Object> get props => [tab];
}

class SupplierDetailsErrorState extends SupplierdetailsState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const SupplierDetailsErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
