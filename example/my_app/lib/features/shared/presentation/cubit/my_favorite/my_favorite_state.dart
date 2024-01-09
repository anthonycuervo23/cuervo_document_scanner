// ignore_for_file: must_be_immutable

part of 'my_favorite_cubit.dart';

sealed class MyFavoriteState extends Equatable {
  const MyFavoriteState();

  @override
  List<Object?> get props => [];
}

final class MyFavoriteInitialState extends MyFavoriteState {
  const MyFavoriteInitialState();
  @override
  List<Object?> get props => [];
}

final class MyFavoriteLoadingState extends MyFavoriteState {
  const MyFavoriteLoadingState();
  @override
  List<Object?> get props => [];
}

class MyFavoriteLoadedState extends MyFavoriteState {
  final List<TempProductData> productList;
  double? random;

  MyFavoriteLoadedState({
    required this.productList,
    this.random,
  });
  MyFavoriteLoadedState copyWith({
    double? random,
    List<TempProductData>? productList,
  }) {
    return MyFavoriteLoadedState(
      productList: productList ?? this.productList,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [productList, random];
}

final class MyFavoriteErrorState extends MyFavoriteState {
  final AppErrorType errorType;
  final String errorMessage;

  const MyFavoriteErrorState({required this.errorType, required this.errorMessage});

  @override
  List<Object> get props => [errorMessage, errorType];
}
