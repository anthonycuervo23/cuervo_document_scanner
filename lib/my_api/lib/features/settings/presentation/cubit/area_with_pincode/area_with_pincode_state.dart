// ignore_for_file: must_be_immutable

part of 'area_with_pincode_cubit.dart';

sealed class AreaWithPincodeState extends Equatable {
  const AreaWithPincodeState();

  @override
  List<Object?> get props => [];
}

final class AreaWithPincodeInitial extends AreaWithPincodeState {}

class AreaWithPincodeLoadingState extends AreaWithPincodeState {
  @override
  List<Object> get props => [];
}

class AreaWithPincodeLoadedState extends AreaWithPincodeState {
  final List<AreaWithPincodeModel> areaWithPincodeList;
  double? random;
  bool? isEdited;

  AreaWithPincodeLoadedState({required this.areaWithPincodeList, this.random, this.isEdited});

  AreaWithPincodeLoadedState copyWith({
    List<AreaWithPincodeModel>? areaWithPincodeList,
    double? random,
    bool? isEdited,
  }) {
    return AreaWithPincodeLoadedState(
      areaWithPincodeList: areaWithPincodeList ?? this.areaWithPincodeList,
      random: random ?? this.random,
      isEdited: isEdited ?? this.isEdited,
    );
  }

  @override
  List<Object?> get props => [areaWithPincodeList, random, isEdited];
}

class AreaWithPincodeErrorState extends AreaWithPincodeState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AreaWithPincodeErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
