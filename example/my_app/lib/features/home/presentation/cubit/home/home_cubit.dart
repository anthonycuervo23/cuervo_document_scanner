import 'package:bakery_shop_flutter/features/home/domain/entitys/home_entity.dart';
import 'package:bakery_shop_flutter/features/home/domain/usecases/get_home_data_use_cases.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoadingCubit loadingCubit;
  final GetHomeDatauseCases getHomeDatauseCases;
  final CounterCubit counterCubit;
  final ProductListCubit productListCubit;
  HomeCubit({
    required this.loadingCubit,
    required this.getHomeDatauseCases,
    required this.counterCubit,
    required this.productListCubit,
  }) : super(HomeInitialState());

  Future<void> loadData() async {
    Either<AppError, HomeEntity> response = await getHomeDatauseCases(NoParams());
    response.fold(
      (error) async {
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(HomeErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (HomeEntity homeData) {
        emit(HomeLoadedState(homeDataEntity: homeData));
      },
    );
  }

  HomeLoadedState? getHomeState() {
    HomeLoadedState? homeLoadedState;

    if (state is HomeLoadedState) {
      homeLoadedState = state as HomeLoadedState;
    }
    return homeLoadedState;
  }

  // void changeSilderIndex({required int index}) {
  //   var state = getHomeState();
  //   if (state != null) {
  //     emit(state.copywith(index: index));
  //   }
  // }

  // void changelike({required TempProductData product}) {
  //   var state = getHomeState();
  //   if (state != null) {
  //     product.isFavorite = !product.isFavorite;
  //     if (product.isFavorite) {
  //       favoriteProductList.add(product);
  //     } else {
  //       favoriteProductList.remove(product);
  //     }
  //     emit(state.copywith(product: product, random: Random().nextDouble()));
  //   }
  // }
}
