import 'dart:math';
import 'package:bakery_shop_flutter/features/combo_offers/data/models/combo_offer_model.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/entities/combo_offer_entity.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/params/combo_offer_params.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/usecases/combo_offer_usecase.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/get_my_cart_product_use_cases.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'combo_offer_state.dart';

class ComboOfferCubit extends Cubit<ComboOfferState> {
  final GetComboOfferData getComboOfferData;
  final CounterCubit counterCubit;
  final LoadingCubit loadingCubit;
  final GetMyCartProductUseCases getMyCartProductUseCases;

  ComboOfferCubit({
    required this.getComboOfferData,
    required this.counterCubit,
    required this.loadingCubit,
    required this.getMyCartProductUseCases,
  }) : super(ComboOfferInitialState());

  Future<void> loadInitialData() async {
    if (userToken != null) {
      int pageNumber = 1;
      if (state is ComboOfferLoadedState) {
        pageNumber = ((state as ComboOfferLoadedState).comboProductEntity.currentPage) + 1;
      } else {
        emit(ComboOfferLoadingState());
      }
      Either<AppError, ComboProductEntity> response = await getComboOfferData(ComboOfferParams(page: pageNumber));
      response.fold(
        (AppError error) async {
          if (error.errorType == AppErrorType.unauthorised) {
            await AppFunctions().forceLogout();
            return error.errorMessage;
          }
          emit(ComboOfferErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
        },
        (ComboProductEntity data) async {
          if (state is ComboOfferLoadedState) {
            var comboOfferLoadedState = state as ComboOfferLoadedState;
            if (data.productList.isNotEmpty) {
              emit(
                comboOfferLoadedState.copyWith(
                  comboProductList: data.productList,
                  comboProductEntity: data,
                  random: Random().nextDouble(),
                ),
              );
            }
          } else {
            emit(
              ComboOfferLoadedState(
                comboProductList: data.productList,
                comboProductEntity: data,
                random: Random().nextDouble(),
              ),
            );
          }
        },
      );
    } else {
      emit(const ComboOfferErrorState(appErrorType: AppErrorType.login, errorMessage: "Unauthenticated..."));
    }
  }

  void updateScreen({required ComboOfferLoadedState state}) {
    emit(state.copyWith(random: Random().nextDouble()));
  }

  List<ComboProductModel> commonUpdateData({required List<ComboProductModel> data}) {
    List<ComboProductModel> productItem = data;
    int item = 0;
    for (var product in productItem) {
      item = 0;
      for (var e1 in myCartEntity!.cart) {
        if (product.id == e1.product.id) {
          item += e1.qty;
          int index = productItem.indexWhere((element) => element.id == product.id);
          productItem[index] = productItem[index].copyWith(totalItem: item);
        }
      }
    }
    loadingCubit.hide();
    return productItem;
  }
}
