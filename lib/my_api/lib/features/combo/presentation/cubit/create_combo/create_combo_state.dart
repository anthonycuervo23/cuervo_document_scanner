// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_combo_cubit.dart';

abstract class CreateComboState extends Equatable {
  const CreateComboState();

  @override
  List<Object?> get props => [];
}

class CreateComboInitialState extends CreateComboState {
  const CreateComboInitialState();

  @override
  List<Object> get props => [];
}

class CreateComboLoadingState extends CreateComboState {
  const CreateComboLoadingState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CreateComboLoadedState extends CreateComboState {
  final File? imageFile;
  List<CreateComboModel>? searchedData = [];
  List<CreateComboModel>? selectedData = [];
  final double? random;
  final bool isSearchIsActive;

  CreateComboLoadedState({
    this.imageFile,
    this.searchedData,
    this.selectedData,
    this.random,
    required this.isSearchIsActive,
  });

  CreateComboLoadedState copyWith({
    File? imageFile,
    List<CreateComboModel>? searchedData,
    List<CreateComboModel>? selectedData,
    double? random,
    bool? isSearchIsActive,
  }) {
    return CreateComboLoadedState(
      imageFile: imageFile ?? this.imageFile,
      searchedData: searchedData ?? this.searchedData,
      selectedData: selectedData ?? this.selectedData,
      random: random ?? this.random,
      isSearchIsActive: isSearchIsActive ?? this.isSearchIsActive,
    );
  }

  @override
  List<Object?> get props => [imageFile, searchedData, random, isSearchIsActive, selectedData];
}

class CreateComboErrorState extends CreateComboState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const CreateComboErrorState({required this.errorMessage, required this.appErrorType});
  @override
  List<Object> get props => [errorMessage, appErrorType];
}
