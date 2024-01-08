part of 'app_layouts_cubit.dart';

abstract class AppLayoutsState extends Equatable {
  const AppLayoutsState();

  @override
  List<Object?> get props => [];
}

class AppLayoutsInitial extends AppLayoutsState {}

class AppLayoutsLoadingState extends AppLayoutsState {
  @override
  List<Object> get props => [];
}

class AppLayoutsLoadedState extends AppLayoutsState {
  final Color primaryColor;
  final Color secendoryColor;
  final Color defualtColor;
  final String primaryColorText;
  final String secondoryColorText;
  final String defualtColorText;
  final bool buttonStyleCheckBox;
  final double? random;
  const AppLayoutsLoadedState({
    required this.buttonStyleCheckBox,
    required this.defualtColor,
    required this.defualtColorText,
    required this.primaryColor,
    required this.primaryColorText,
    required this.secendoryColor,
    required this.secondoryColorText,
    this.random,
  });

  AppLayoutsLoadedState copyWth({
    bool? buttonStyleCheckBox,
    double? random,
    Color? primaryColor,
    Color? secendoryColor,
    Color? defualtColor,
    String? primaryColorText,
    String? secondoryColorText,
    String? defualtColorText,
  }) {
    return AppLayoutsLoadedState(
      buttonStyleCheckBox: buttonStyleCheckBox ?? this.buttonStyleCheckBox,
      defualtColorText: defualtColorText ?? this.defualtColorText,
      defualtColor: defualtColor ?? this.defualtColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secendoryColor: secendoryColor ?? this.secendoryColor,
      primaryColorText: primaryColorText ?? this.primaryColorText,
      secondoryColorText: secondoryColorText ?? this.secondoryColorText,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [
        buttonStyleCheckBox,
        defualtColor,
        defualtColorText,
        primaryColor,
        primaryColorText,
        secendoryColor,
        secondoryColorText,
        random,
      ];
}

class AppLayoutsErrorState extends AppLayoutsState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const AppLayoutsErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
