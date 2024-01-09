// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

sealed class AddOffersState extends Equatable {
  const AddOffersState();

  @override
  List<Object?> get props => [];
}

final class AddOffersInitialState extends AddOffersState {}

class AddOffersLoadingState extends AddOffersState {
  @override
  List<Object?> get props => [];
}

class AddOffersLoadedState extends AddOffersState {
  final double? random;
  final int? selectedDiscountValue;
  final DateTime? startDate;
  final DateTime? endDate;
  const AddOffersLoadedState({
    this.random,
    this.selectedDiscountValue,
    this.startDate,
    this.endDate,
  });
  AddOffersLoadedState copyWith({
    double? random,
    int? selectedDiscountValue,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return AddOffersLoadedState(
      random: random ?? this.random,
      selectedDiscountValue: selectedDiscountValue ?? this.selectedDiscountValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [random, selectedDiscountValue, startDate, endDate];
}

class AddOffersErrorState extends AddOffersState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AddOffersErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [];
}
