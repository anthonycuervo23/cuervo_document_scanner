part of 'policy_cubit.dart';

sealed class PolicyState extends Equatable {
  const PolicyState();

  @override
  List<Object> get props => [];
}

final class PolicyInitialState extends PolicyState {
  const PolicyInitialState();

  @override
  List<Object> get props => [];
}

class PolicyLoadingState extends PolicyState {
  const PolicyLoadingState();

  @override
  List<Object> get props => [];
}

class PolicyLoadedState extends PolicyState {
  final PolicyEntity policyDataEntity;

  PolicyLoadedState copyWith({PolicyEntity? policyDataEntity}) {
    return PolicyLoadedState(
      policyDataEntity: policyDataEntity ?? this.policyDataEntity,
    );
  }

  const PolicyLoadedState({required this.policyDataEntity});

  @override
  List<Object> get props => [policyDataEntity];
}

class PolicyErrorState extends PolicyState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const PolicyErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
