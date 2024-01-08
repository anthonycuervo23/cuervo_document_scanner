part of 'create_customer_cubit.dart';

sealed class CreateCustomerState extends Equatable {
  const CreateCustomerState();

  @override
  List<Object?> get props => [];
}

class CreateCustomerLoadingState extends CreateCustomerState {
  @override
  List<Object?> get props => [];
}

class CreateCustomerLoadedState extends CreateCustomerState {
  final List<FamilyRelationshipDetails> searcheditems;
  final List<FamilyDetails> familyDetailData;
  final int selectIndexType;
  final int? selectTabValue;
  final double? random;

  const CreateCustomerLoadedState({
    required this.searcheditems,
    required this.selectIndexType,
    required this.familyDetailData,
    required this.selectTabValue,
    this.random,
  });

  CreateCustomerLoadedState copywith({
    List<FamilyRelationshipDetails>? searcheditems,
    int? selectIndexType,
    List<FamilyDetails>? familyDetailData,
    int? selectTabValue,
    double? random,
  }) {
    return CreateCustomerLoadedState(
      selectTabValue: selectTabValue ?? this.selectTabValue,
      familyDetailData: familyDetailData ?? this.familyDetailData,
      searcheditems: searcheditems ?? this.searcheditems,
      selectIndexType: selectIndexType ?? this.selectIndexType,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [
        searcheditems,
        selectIndexType,
        familyDetailData,
        selectTabValue,
        random,
      ];
}

class CreateCustomerErrorState extends CreateCustomerState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const CreateCustomerErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [appErrorType,errorMessage];
}
