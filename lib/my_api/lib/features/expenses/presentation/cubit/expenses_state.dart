part of 'expenses_cubit.dart';

enum AddExpenseNavigation { edit, add }

abstract class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object?> get props => [];
}

class ExpensesLoadingState extends ExpensesState {
  const ExpensesLoadingState();
  @override
  List<Object> get props => [];
}

class ExpenseInitialState extends ExpensesState {
  const ExpenseInitialState();
  @override
  List<Object> get props => [];
}

class ExpensesLoadedState extends ExpensesState {
  final List<SelectCategoryModel> listOfExpansesCategory;
  final List<ItemListModel> listOfItem;
  final PayMentType payMentType;
  final int selctedCategoryIndex;
  final int selectedBankIndex;
  final List<ExpenseCategory> searchedCategory;
  final bool dispalyCategory;
  final bool dispalyBankName;
  final TextEditingController categoryTypeController;
  final double? random;

  const ExpensesLoadedState({
    required this.listOfExpansesCategory,
    required this.listOfItem,
    required this.payMentType,
    required this.selectedBankIndex,
    required this.selctedCategoryIndex,
    required this.searchedCategory,
    required this.dispalyBankName,
    required this.dispalyCategory,
    required this.categoryTypeController,
    this.random,
  });

  ExpensesLoadedState copyWith({
    List<SelectCategoryModel>? listOfExpansesCategory,
    List<ItemListModel>? listOfItem,
    PayMentType? payMentType,
    int? selectedBankIndex,
    int? selctedCategoryIndex,
    List<ExpenseCategory>? searchedCategory,
    bool? dispalyCategory,
    bool? dispalyBankName,
    double? random,
    final TextEditingController? categoryTypeController,
  }) {
    return ExpensesLoadedState(
      listOfItem: listOfItem ?? this.listOfItem,
      payMentType: payMentType ?? this.payMentType,
      listOfExpansesCategory: listOfExpansesCategory ?? this.listOfExpansesCategory,
      selectedBankIndex: selectedBankIndex ?? this.selectedBankIndex,
      selctedCategoryIndex: selctedCategoryIndex ?? this.selctedCategoryIndex,
      searchedCategory: searchedCategory ?? this.searchedCategory,
      dispalyBankName: dispalyBankName ?? this.dispalyBankName,
      dispalyCategory: dispalyCategory ?? this.dispalyCategory,
      random: random ?? this.random,
      categoryTypeController: categoryTypeController ?? this.categoryTypeController,
    );
  }

  @override
  List<Object?> get props => [
        listOfExpansesCategory,
        random,
        payMentType,
        listOfItem,
        selectedBankIndex,
        selctedCategoryIndex,
        searchedCategory,
        dispalyBankName,
        dispalyCategory,
        categoryTypeController,
      ];
}

class ExpensesErrorState extends ExpensesState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ExpensesErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
