// ignore_for_file: must_be_immutable

part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final List<ProductModel> filterdeData;
  final List<ProductModel> productData;
  final List<ProductModel> searchedData;
  final List<ProductModel> selectedProduct;
  final bool isSearchIsActive;
  final CheckScreen checkScreenIndex;
  double? random;
  ProductsLoadedState({
    required this.filterdeData,
    required this.productData,
    required this.isSearchIsActive,
    required this.searchedData,
    required this.selectedProduct,
    required this.checkScreenIndex,
    this.random,
  });

  ProductsLoadedState copyWith({
    double? random,
    List<ProductModel>? filterdeData,
    List<ProductModel>? productData,
    bool? isSearchIsActive,
    List<ProductModel>? searchedData,
    List<ProductModel>? selectedProduct,
    CheckScreen? checkScreenIndex,
  }) {
    return ProductsLoadedState(
      random: random ?? this.random,
      checkScreenIndex: checkScreenIndex ?? this.checkScreenIndex,
      productData: productData ?? this.productData,
      filterdeData: filterdeData ?? this.filterdeData,
      isSearchIsActive: isSearchIsActive ?? this.isSearchIsActive,
      searchedData: searchedData ?? this.searchedData,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }

  @override
  List<Object?> get props => [
        random,
        checkScreenIndex,
        productData,
        filterdeData,
        isSearchIsActive,
        searchedData,
        selectedProduct,
      ];
}

class ProductsErrorState extends ProductsState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ProductsErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [];
}
