import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

sealed class SearchFilterState extends Equatable {
  const SearchFilterState();

  @override
  List<Object?> get props => [];
}

class SearchFilterLoadingState extends SearchFilterState {
  @override
  List<Object> get props => [];
}

class SearchFilterLoadedState extends SearchFilterState {
  final List selectedFilter;
  final bool? isCustomRange;
  final double? random;

  const SearchFilterLoadedState({this.isCustomRange, this.random, required this.selectedFilter});

  SearchFilterLoadedState copyWith({
    List? selectedFilter,
    double? random,
    bool? isCustomRange,
  }) {
    return SearchFilterLoadedState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      random: random ?? this.random,
      isCustomRange: isCustomRange ?? this.isCustomRange,
    );
  }

  @override
  List<Object?> get props => [selectedFilter, isCustomRange, random];
}

class SearchFilterErrorState extends SearchFilterState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const SearchFilterErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
