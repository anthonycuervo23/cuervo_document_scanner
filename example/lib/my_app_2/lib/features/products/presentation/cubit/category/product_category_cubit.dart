import 'package:bakery_shop_flutter/features/products/domain/entities/produt_category_entites.dart';
import 'package:bakery_shop_flutter/features/products/domain/usecases/product_category_data.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/category/product_category_state.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final GetProductCategoryData getProductCategoryData;
  final LoadingCubit loadingCubit;
  ProductCategoryCubit({
    required this.loadingCubit,
    required this.getProductCategoryData,
  }) : super(const ProductCategopryInitialState());

  Future<void> getCategory() async {
    emit(const ProductCategopryLoadingState());
    final Either<AppError, ProductCategoryEntity> response = await getProductCategoryData(NoParams());
    response.fold(
      (error) async {
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        emit(ProductCategopryErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (ProductCategoryEntity data) {
        emit(ProductCategopryLoadedState(categoryList: data.categoryList));
      },
    );
  }
}
