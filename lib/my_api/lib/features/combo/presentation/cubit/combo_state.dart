// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:bakery_shop_admin_flutter/features/combo/data/models/combo_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';

abstract class ComboState extends Equatable {
  const ComboState();

  @override
  List<Object?> get props => [];
}

class ComboInitialState extends ComboState {
  const ComboInitialState();

  @override
  List<Object> get props => [];
}

class ComboLoadingState extends ComboState {
  const ComboLoadingState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ComboLoadedState extends ComboState {
  final List<ComboModel> listOfCombo;
  double? random;
  ComboLoadedState({this.random, required this.listOfCombo});

  @override
  List<Object?> get props => [listOfCombo, random];

  ComboLoadedState copyWith({List<ComboModel>? listOfCombo, double? random}) {
    return ComboLoadedState(
      listOfCombo: listOfCombo ?? this.listOfCombo,
      random: random ?? this.random,
    );
  }
}

class ComboErrorState extends ComboState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ComboErrorState({required this.errorMessage, required this.appErrorType});
  @override
  List<Object> get props => [errorMessage, appErrorType];
}
