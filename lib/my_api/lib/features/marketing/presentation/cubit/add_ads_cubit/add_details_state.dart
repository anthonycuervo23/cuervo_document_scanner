import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:equatable/equatable.dart';

abstract class AddDetailsState extends Equatable {
  const AddDetailsState();

  @override
  List<Object?> get props => [];
}

class AddDetailsLoadingState extends AddDetailsState {
  @override
  List<Object> get props => [];
}

class AddDetailsLoadedState extends AddDetailsState {
  final SelectedTab selectedTab;
  final int index;
  final String typeLink;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool status;
  final double? random;

  const AddDetailsLoadedState({
    required this.selectedTab,
    required this.index,
    required this.typeLink,
    required this.status,
    this.endDate,
    this.startDate,
    this.random,
  });

  AddDetailsLoadedState copyWith({
    SelectedTab? selectedTab,
    int? index,
    String? typeLink,
    bool? status,
    DateTime? startDate,
    DateTime? endDate,
    double? random,
  }) {
    return AddDetailsLoadedState(
      selectedTab: selectedTab ?? this.selectedTab,
      index: index ?? this.index,
      typeLink: typeLink ?? this.typeLink,
      status: status ?? this.status,
      endDate: endDate ?? this.endDate,
      startDate: startDate ?? this.startDate,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [selectedTab, index, typeLink, status, random];
}

class AddDeatilsErrorState extends AddDetailsState {
  final ErrorType errorType;
  final String errormessage;

  const AddDeatilsErrorState({required this.errorType, required this.errormessage});
  @override
  List<Object> get props => [
        errorType,
        errormessage,
      ];
}
