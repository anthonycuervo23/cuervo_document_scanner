part of 'help_support_cubit.dart';

sealed class HelpAndSupportState extends Equatable {
  const HelpAndSupportState();

  @override
  List<Object> get props => [];
}

final class HelpAndSupportInitialState extends HelpAndSupportState {
  const HelpAndSupportInitialState();

  @override
  List<Object> get props => [];
}

final class HelpAndSupportLoadingState extends HelpAndSupportState {
  const HelpAndSupportLoadingState();

  @override
  List<Object> get props => [];
}

final class HelpAndSupportLoadedState extends HelpAndSupportState {
  const HelpAndSupportLoadedState();

  @override
  List<Object> get props => [];
}

final class HelpAndSupportErrorState extends HelpAndSupportState {
  final String errorMessge;
  final AppErrorType appErrorType;
  const HelpAndSupportErrorState({required this.errorMessge, required this.appErrorType});

  @override
  List<Object> get props => [errorMessge, appErrorType];
}
