// ignore_for_file: must_be_immutable

part of 'sort_filter_for_order_cubit.dart';

sealed class SortFilterForOrderState extends Equatable {
  const SortFilterForOrderState();

  @override
  List<Object?> get props => [];
}

final class SortFilterForOrderLoadingState extends SortFilterForOrderState {}

final class SortFilterForOrderLoadedState extends SortFilterForOrderState {
  final List<String> selectedFilterByName;
  final List selectedFilterByPrice;
  final double? random;
  final int typeIndex;
  final int deliveryTypeIndex;
  final int paymentTypeIndex;

  const SortFilterForOrderLoadedState({
    this.random,
    required this.selectedFilterByName,
    required this.selectedFilterByPrice,
    required this.typeIndex,
    required this.deliveryTypeIndex,
    required this.paymentTypeIndex,
  });

  SortFilterForOrderLoadedState copyWith({
    List<String>? selectedFilterByName,
    List? selectedFilterByPrice,
    double? random,
    int? typeIndex,
    int? deliveryTypeIndex,
    int? paymentTypeIndex,
  }) {
    return SortFilterForOrderLoadedState(
      typeIndex: typeIndex ?? this.typeIndex,
      deliveryTypeIndex: deliveryTypeIndex ?? this.deliveryTypeIndex,
      paymentTypeIndex: paymentTypeIndex ?? this.paymentTypeIndex,
      selectedFilterByName: selectedFilterByName ?? this.selectedFilterByName,
      selectedFilterByPrice: selectedFilterByPrice ?? this.selectedFilterByPrice,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [selectedFilterByName, random, selectedFilterByPrice, typeIndex];
}

final class SortFilterForOrderErrorState extends SortFilterForOrderState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const SortFilterForOrderErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
