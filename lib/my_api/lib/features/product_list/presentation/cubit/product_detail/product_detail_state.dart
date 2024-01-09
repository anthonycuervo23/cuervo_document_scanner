import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

class ProductDetailInitialState extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

class ProductDetailLodingInitialState extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

class ProductDetailLoadedState extends ProductDetailState {
  const ProductDetailLoadedState();

  ProductDetailLoadedState copyWith() {
    return const ProductDetailLoadedState();
  }

  @override
  List<Object?> get props => [];
}

class ProductDetailErrorState extends ProductDetailState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ProductDetailErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
