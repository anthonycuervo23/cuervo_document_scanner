part of 'product_list_cubit.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

final class ProductListInitalState extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductListLoadingState extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductListLoadedState extends ProductListState {
  final List<ProductFilterEnum> selectedFilter;
  final bool isProductAdded;
  final int quantityRadioGroup;
  final int customizableItem;
  final int totalCustomPrice;
  final int totalProduct;
  final double? random;
  final List<ProductItem> productDataList;
  final List<ProductQuantityAttributesPrice> productQuantityList;
  final List<String> listOfProductCategoryType1;
  final List<String> listOfProductCategoryType2;
  final int? totalProductMessaeCharacters;
  final ProductDataEntity productDataEntity;

  const ProductListLoadedState({
    required this.selectedFilter,
    required this.isProductAdded,
    required this.quantityRadioGroup,
    required this.customizableItem,
    required this.totalCustomPrice,
    required this.totalProduct,
    required this.productDataList,
    required this.productQuantityList,
    required this.listOfProductCategoryType1,
    required this.listOfProductCategoryType2,
    this.random,
    this.totalProductMessaeCharacters,
    required this.productDataEntity,
  });

  ProductListLoadedState copyWith({
    List<ProductFilterEnum>? selectedFilter,
    bool? isProductAdded,
    int? quantityRadioGroup,
    int? customizableItem,
    int? totalCustomPrice,
    int? totalProduct,
    double? random,
    List<ProductItem>? productDataList,
    List<ProductItem>? tempData,
    List<ProductQuantityAttributesPrice>? productQuantityList,
    int? totalProductMessaeCharacters,
    List<String>? listOfProductCategoryType1,
    List<String>? listOfProductCategoryType2,
    ProductDataEntity? productDataEntity,
  }) {
    return ProductListLoadedState(
      listOfProductCategoryType1: listOfProductCategoryType1 ?? this.listOfProductCategoryType1,
      listOfProductCategoryType2: listOfProductCategoryType2 ?? this.listOfProductCategoryType2,
      productQuantityList: productQuantityList ?? this.productQuantityList,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isProductAdded: isProductAdded ?? this.isProductAdded,
      quantityRadioGroup: quantityRadioGroup ?? this.quantityRadioGroup,
      customizableItem: customizableItem ?? this.customizableItem,
      totalCustomPrice: totalCustomPrice ?? this.totalCustomPrice,
      totalProduct: totalProduct ?? this.totalProduct,
      random: random ?? this.random,
      productDataList: productDataList ?? this.productDataList,
      totalProductMessaeCharacters: totalProductMessaeCharacters ?? this.totalProductMessaeCharacters,
      productDataEntity: productDataEntity ?? this.productDataEntity,
    );
  }

  @override
  List<Object?> get props => [
        selectedFilter,
        isProductAdded,
        quantityRadioGroup,
        customizableItem,
        totalCustomPrice,
        totalProduct,
        random,
        productQuantityList,
        totalProductMessaeCharacters,
        listOfProductCategoryType1,
      ];
}

final class ProductListErrorState extends ProductListState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ProductListErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
