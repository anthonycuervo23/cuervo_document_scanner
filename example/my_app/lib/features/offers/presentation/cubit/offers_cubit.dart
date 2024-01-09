import 'dart:math';

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/offer_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/entities/offer_entity.dart';
import 'package:bakery_shop_flutter/features/offers/domain/params/apply_coupon_parms.dart';
import 'package:bakery_shop_flutter/features/offers/domain/usecases/apply_coupons.dart';
import 'package:bakery_shop_flutter/features/offers/domain/usecases/get_coupons.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'offers_state.dart';

enum OfferScreenChangeEnum { cart, main }

class OfferCubit extends Cubit<OfferState> {
  final GetCouponsData getCouponsData;
  final LoadingCubit loadingCubit;
  final ApplyCouponsData applyCouponsData;
  OfferCubit({
    required this.getCouponsData,
    required this.loadingCubit,
    required this.applyCouponsData,
  }) : super(OfferInitialState());

  void showOfferDetail({
    required int index,
    required OfferLoadedState state,
  }) {
    state.listOfCouponsData[index].isOpenViewDetails = !state.listOfCouponsData[index].isOpenViewDetails;
    emit(state.copyWith(listOfCouponsData: state.listOfCouponsData, random: Random().nextDouble()));
  }

  Future<void> loadInitialData() async {
    if (userToken != null) {
      loadingCubit.show();
      if (offerDataEntity == null) {
        Either<AppError, OfferDataEntity> response = await getCouponsData(NoParams());
        response.fold(
          (AppError error) async {
            loadingCubit.hide();
            if (error.errorType == AppErrorType.unauthorised) {
              await AppFunctions().forceLogout();
              return error.errorMessage;
            }
            emit(OfferErrorState(errorMessage: error.errorMessage, appErrorType: error.errorType));
          },
          (OfferDataEntity data) {
            loadingCubit.hide();
            offerDataEntity = data;
            if (state is OfferLoadedState) {
              var loadedState = state as OfferLoadedState;
              emit(
                loadedState.copyWith(
                  offerDataEntity: data,
                  listOfCouponsData: data.coupons,
                  random: Random().nextDouble(),
                ),
              );
            } else {
              emit(OfferLoadedState(listOfCouponsData: data.coupons, offerDataEntity: data));
            }
          },
        );
      } else {
        loadingCubit.hide();
        emit(OfferLoadedState(listOfCouponsData: offerDataEntity!.coupons, offerDataEntity: offerDataEntity!));
      }
    }
  }

  Future<void> applyCoupons({
    required ApplyCouponParms parms,
    required OfferLoadedState state,
    required BuildContext context,
    required bool isCart,
  }) async {
    if (userToken != null) {
      loadingCubit.show();
      Either<AppError, CouponApplyModel> response = await applyCouponsData(parms);
      response.fold(
        (AppError error) async {
          loadingCubit.hide();
          if (error.errorType == AppErrorType.unauthorised) {
            await AppFunctions().forceLogout();
            return error.errorMessage;
          }
          CustomSnackbar.show(
            snackbarType: SnackbarType.ERROR,
            message: error.errorMessage,
          );
        },
        (CouponApplyModel data) {
          loadingCubit.hide();
          if (data.status) {
            appliedCouponData = CouponData(
              code: data.data?.coupon?.code ?? "",
              type: data.data?.coupon?.type ?? "",
              amount: data.data?.coupon?.amount ?? "",
              orderLimit: data.data?.coupon?.orderLimit ?? "",
              startDate: data.data?.coupon?.startDate ?? DateTime.now(),
              endDate: data.data?.coupon?.endDate ?? DateTime.now(),
              applyOrNot: CouponCode.apply.name,
            );
            BlocProvider.of<CartCubit>(context).updateBillDetails(
              appliedCouponData: appliedCouponData,
              couponCode: CouponCode.apply,
              isRemoveCoupon: false,
            );
            if (isCart) {
              CommonRouter.pop(args: parms.couponCode);
            }
            applyCouponSuccessAnimation(
              isPersentage: data.data?.coupon?.type == "Percentage" ? true : false,
              price: data.data?.coupon?.amount ?? "",
              couponCode: data.data?.coupon?.code ?? "",
              context: context,
            );
            Future.delayed(
              const Duration(seconds: 2),
              () => CommonRouter.pop(args: parms.couponCode),
            );
          }
          emit(state.copyWith(couponApplyModel: data, random: Random().nextDouble()));
        },
      );
    }
  }
}

void applyCouponSuccessAnimation({
  required String price,
  required String couponCode,
  required BuildContext context,
  required bool isPersentage,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: appConstants.default2Color,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        surfaceTintColor: appConstants.whiteBackgroundColor,
        backgroundColor: appConstants.whiteBackgroundColor,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        actionsPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: CommonWidget.sizedBox(
          height: 300,
          width: ScreenUtil().screenWidth * 0.9,
          child: Column(
            children: [
              Column(
                children: [
                  CommonWidget.sizedBox(height: 30),
                  CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/cart_screen/success_arrow.svg"),
                  CommonWidget.sizedBox(height: 20),
                  CommonWidget.commonText(
                    text: "'$couponCode' applied",
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.sizedBox(height: 20),
                  CommonWidget.commonText(
                    text: isPersentage
                        ? "${TranslationConstants.you_saved.translate(context)} $price%"
                        : "${TranslationConstants.you_saved.translate(context)} ₹$price",
                    style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.sizedBox(height: 8),
                  CommonWidget.commonText(
                    text: "with this coupon code",
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.sizedBox(height: 30),
                  CommonWidget.commonText(
                    text: TranslationConstants.woohoo_thanks.translate(context),
                    style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                          color: appConstants.notificationColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
