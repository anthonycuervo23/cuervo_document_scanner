part of 'point_wise_color_btn_cubit.dart';

sealed class PointWiseColorBtnState extends Equatable {
  const PointWiseColorBtnState();

  @override
  List<Object?> get props => [];
}

final class PointWiseColorBtnInitial extends PointWiseColorBtnState {}

class PointWiseColorBtnLoadingState extends PointWiseColorBtnState {
  @override
  List<Object> get props => [];
}

class PointWiseColorBtnLoadedState extends PointWiseColorBtnState {
  final List<PointWiseColorBtnModel> pointWiseColorBtnList;
  final double? random;
  final bool? isEdited;
  final Color? selectedColor;
  final String? colorCode;
  final int? index;

  const PointWiseColorBtnLoadedState({
    required this.pointWiseColorBtnList,
    this.isEdited,
    this.random,
    this.selectedColor,
    this.colorCode,
    this.index,
  });

  PointWiseColorBtnLoadedState copyWith({
    List<PointWiseColorBtnModel>? pointWiseColorBtnList,
    double? random,
    Color? selectedColor,
    bool? isEdited,
    String? colorCode,
    int? index,
  }) {
    return PointWiseColorBtnLoadedState(
      pointWiseColorBtnList: pointWiseColorBtnList ?? this.pointWiseColorBtnList,
      isEdited: isEdited ?? this.isEdited,
      random: random ?? this.random,
      selectedColor: selectedColor ?? this.selectedColor,
      colorCode: colorCode ?? this.colorCode,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [
        pointWiseColorBtnList,
        isEdited,
        selectedColor,
        colorCode,
        index,
        random,
      ];
}

class PointWiseColorBtnErrorState extends PointWiseColorBtnState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const PointWiseColorBtnErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
