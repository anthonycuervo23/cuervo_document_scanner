import 'package:bakery_shop_admin_flutter/features/purchase_list/data/models/purchase_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:equatable/equatable.dart';

abstract class PurchaseListState extends Equatable {
  const PurchaseListState();

  @override
  List<Object?> get props => [];
}

class PurchseListInitial extends PurchaseListState {
  @override
  List<Object> get props => [];
}

class PurchseListLodingState extends PurchaseListState {
  @override
  List<Object> get props => [];
}

class PurchaseListLoadedState extends PurchaseListState {
  final List<PurchaseModel> purchaseModel;
  final double? random;
  final List<PurchaseModel> purchaseListModel;
  final bool deliveryStatus;

  const PurchaseListLoadedState({required this.purchaseModel, this.random, required this.purchaseListModel,required this.deliveryStatus});

  PurchaseListLoadedState copyWith({
    List<PurchaseModel>? purchaseModel,
    double? random,
    final List<PurchaseModel>? purchaseListModel,
    final bool? deliveryStatus,
  }) {
    return PurchaseListLoadedState(
      purchaseModel: purchaseModel ?? this.purchaseModel,
      random: random ?? this.random,
      purchaseListModel: purchaseListModel ?? this.purchaseListModel,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus
    );
  }

  @override
  List<Object?> get props => [
        purchaseModel,
        random,
        purchaseListModel,
        deliveryStatus,
      ];
}

class PurchseListErrorState extends PurchaseListState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const PurchseListErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [];
}
