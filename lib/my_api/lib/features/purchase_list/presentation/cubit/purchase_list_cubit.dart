// ignore_for_file: unnecessary_null_comparison
import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/purchase_list/data/models/purchase_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/cubit/purchase_list_state.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bloc/bloc.dart';

class PurchaseListCubit extends Cubit<PurchaseListState> {
  final ToggleCubit deliverystatustoggle;
  PurchaseListCubit({required this.deliverystatustoggle})
      : super(
          PurchaseListLoadedState(
            purchaseModel: purchaseList,
            random: Random().nextDouble(),
            purchaseListModel: purchaseList,
            deliveryStatus: false,
          ),
        );

  void deletePurchase({required PurchaseModel purchaseModel}) {
    late PurchaseListLoadedState purchaseListLoadedState;
    purchaseListLoadedState = state as PurchaseListLoadedState;

    if (purchaseListLoadedState != null) {
      purchaseListLoadedState.purchaseModel.remove(purchaseModel);

      emit(purchaseListLoadedState.copyWith(
        purchaseModel: purchaseListLoadedState.purchaseModel,
        random: Random().nextDouble(),
      ));
    }
  }

  void updatePurchaseDeliveryStatus({
    required PurchaseModel purchaseModel,
    required bool deliveryStatus,
    required PurchaseListLoadedState state,
  }) {
    purchaseModel.deliveryStatus = deliveryStatus;
    emit(state.copyWith(purchaseListModel: List.from(state.purchaseListModel), deliveryStatus: deliveryStatus));
  }
}
