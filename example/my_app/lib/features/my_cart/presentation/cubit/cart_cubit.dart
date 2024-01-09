import 'dart:math';
import 'package:bakery_shop_flutter/common/constants/hive_constants.dart';
import 'package:bakery_shop_flutter/features/address/domain/model/address_detail_model.dart';
import 'package:bakery_shop_flutter/features/my_cart/data/models/my_cart_model.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/entities/my_cart_entity.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/my_cart_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/update_quantity_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/add_product_to_cart.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/delete_product.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/get_my_cart_product_use_cases.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/update_product_quanity.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/usecases/apply_coupons.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_data_for_cart_model.dart';
import 'package:bakery_shop_flutter/features/shared/data/models/post_api_response.dart';
import 'package:bakery_shop_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_flutter/features/shared/domain/params/no_params.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CartCubit extends Cubit<CartState> {
  final GetMyCartProductUseCases getMyCartProductUseCases;
  final AddProductToCart addProductToCart;
  final UpdateProductQuntity updateProductQuntity;
  final DeleteProductUseCase deleteProductUseCase;
  final LoadingCubit loadingCubit;
  final ApplyCouponsData applyCouponsData;
  CartCubit({
    required this.getMyCartProductUseCases,
    required this.addProductToCart,
    required this.updateProductQuntity,
    required this.loadingCubit,
    required this.deleteProductUseCase,
    required this.applyCouponsData,
  }) : super(CartInitialState());

  List<TimeslotModel> slotList = [];

  TextEditingController cookingInsructionController = TextEditingController();
  TextEditingController otherNameController = TextEditingController();
  TextEditingController otherNumberController = TextEditingController();
  TextEditingController altNumberController = TextEditingController();
  TextEditingController otherAreaController = TextEditingController();
  TextEditingController otherLandmarkController = TextEditingController();

  Future<void> loadInitialData({required bool isShowLoader}) async {
    if (userToken != null) {
      if (isShowLoader) {
        loadingCubit.show();
      }
      Either<AppError, MyCartEntity> response = await getMyCartProductUseCases(NoParams());
      response.fold(
        (error) async {
          if (error.errorType == AppErrorType.unauthorised) {
            await AppFunctions().forceLogout();
            return error.errorMessage;
          }
          CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
          // emit(CartErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
        },
        (MyCartEntity data) {
          loadingCubit.hide();
          if (data.cart.isNotEmpty) {
            if (state is CartLoadedState) {
              var loadedState = state as CartLoadedState;
              myCartEntity = data;
              emit(loadedState.copyWith(myCartData: data, random: Random().nextDouble()));
            } else {
              String times = addProductDataForLocal(data: data);
              emit(
                CartLoadedState(
                  otherDateForTimeSlot: "",
                  discountPrice: data.overview.discountPrice,
                  totalPrice: data.overview.grandTotalPrice,
                  deleveryCharge: 0,
                  couponCode: CouponCode.notApply,
                  deliveryTimeDate: "",
                  firstDateForRoutingOrder: "",
                  lastDateForRoutingOrder: "",
                  nevigateToDrawer: RoutineOrder.cart,
                  routineOrdersForToggle: false,
                  selectedTimeSlotTime: times,
                  myCartData: data,
                  random: Random().nextDouble(),
                  deliveryTimeSlotDateType: DeliveryDay.today,
                  deliveryType: DeliveryType.standard,
                ),
              );
            }
          } else {
            myCartEntity = MyCartEntity(
              cart: const [],
              deliveryType: data.deliveryType,
              paymentMethod: data.paymentMethod,
              overview: data.overview,
            );
            if (state is CartLoadedState) {
              var loadedstate = state as CartLoadedState;
              emit(loadedstate.copyWith(myCartData: myCartEntity));
            }
          }
        },
      );
    }
  }

  String addProductDataForLocal({required MyCartEntity data}) {
    List<ProductDataForCartModel> localList = [];
    for (var product in data.cart) {
      ProductDataForCartModel model = ProductDataForCartModel(
        productId: product.product.id,
        productName: product.product.name,
        productPrice: product.product.productPrice,
        productAttributsId: product.product.attributePriceId,
        slugs: product.product.attributSlug,
        productSlugPrice: 00,
        totalProduct: product.qty,
      );
      localList.add(model);
    }
    localCartDataStore = localList;
    bakeryBox.put(HiveConstants.CART_DATA_STORE, localCartDataStore);
    bakeryBox.get(HiveConstants.CART_DATA_STORE);
    myCartEntity = data;
    List<SlotModel> listOfSlot = addTimeslot(
      deliveryTypeIndex: 0,
      deliveryTimeDate: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    );
    String times = "";
    for (var e in listOfSlot) {
      times = "${e.start} - ${e.end}";
      break;
    }
    return times;
  }

  Future<void> updateQuantityData({
    required UpdateQuantityParms parms,
    bool isLoaderShow = false,
    bool isCallGetCartApi = false,
  }) async {
    if (isLoaderShow) {
      loadingCubit.show();
    }
    Either<AppError, PostApiResponse> response = await updateProductQuntity(parms);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        // emit(CartErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (data) {
        loadingCubit.hide();
        if (isCallGetCartApi) {
          loadInitialData(isShowLoader: isLoaderShow);
        }
      },
    );
  }

  Future<void> deleteProductData({required int parms, bool isLoaderShow = false, bool isCallGetCartApi = false}) async {
    if (isLoaderShow) {
      loadingCubit.show();
    }
    Either<AppError, PostApiResponse> response = await deleteProductUseCase(parms);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        // emit(CartErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (data) {
        loadingCubit.hide();
        if (isCallGetCartApi) {
          loadInitialData(isShowLoader: isLoaderShow);
        }
      },
    );
  }

  Future<void> addQuantityData({
    required AddProductMyCartParms parms,
    bool isLoaderShow = false,
    bool isCallGetCartApi = false,
  }) async {
    if (isLoaderShow) {
      loadingCubit.show();
    }
    Either<AppError, PostApiResponse> response = await addProductToCart(parms);
    response.fold(
      (error) async {
        loadingCubit.hide();
        if (error.errorType == AppErrorType.unauthorised) {
          await AppFunctions().forceLogout();
          return error.errorMessage;
        }
        CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: error.errorMessage);
        // emit(CartErrorState(appErrorType: error.errorType, errorMessage: error.errorMessage));
      },
      (data) {
        loadingCubit.hide();
        if (isCallGetCartApi) {
          loadInitialData(isShowLoader: isLoaderShow);
        }
      },
    );
  }

  void updateAllData({
    DeliveryDay? deliveryTimeSlotDateType,
    DeliveryType? deliveryType,
    String? selectedTimeSlotTime,
    bool? routineOrdersForToggle,
    String? firstDateForRoutingOrder,
    String? lastDateForRoutingOrder,
    AddressDetailModel? addressDetailsModel,
    double? deleveryCharge,
    String? deliveryTimeDate,
    String? otherDateForTimeSlot,
    required CartLoadedState state,
  }) {
    emit(
      state.copyWith(
        deliveryTimeSlotDateType: deliveryTimeSlotDateType,
        deliveryType: deliveryType,
        selectedTimeSlotTime: selectedTimeSlotTime,
        routineOrdersForToggle: routineOrdersForToggle,
        firstDateForRoutingOrder: firstDateForRoutingOrder,
        lastDateForRoutingOrder: lastDateForRoutingOrder,
        addressDetailsModel: addressDetailsModel,
        deleveryCharge: deleveryCharge,
        deliveryTimeDate: deliveryTimeDate,
        otherDateForTimeSlot: otherDateForTimeSlot,
        random: Random().nextDouble(),
      ),
    );
  }

  void updateBillDetails({
    CouponData? appliedCouponData,
    CouponCode? couponCode,
    bool? isRemoveCoupon,
    double? deliveryCharge,
  }) {
    if (state is CartLoadedState) {
      var loadedState = state as CartLoadedState;
      appliedCouponData = appliedCouponData;
      double grandTotalPrice = 0;
      double deliveryCharges = deliveryCharge ?? 0;
      double discountPrice = loadedState.discountPrice;
      if (isRemoveCoupon == false) {
        if (deliveryCharge == null) {
          double discountPrice = double.parse(appliedCouponData?.amount ?? "0");
          double total = loadedState.myCartData.overview.grandTotalPrice;
          double dis = (total * discountPrice / 100);
          if (appliedCouponData?.type == "Percentage") {
            discountPrice = loadedState.discountPrice + dis;
            grandTotalPrice = total - dis;
          } else {
            grandTotalPrice = total - discountPrice;
          }
        } else {
          grandTotalPrice = loadedState.myCartData.overview.grandTotalPrice + deliveryCharges;
        }
      } else {
        grandTotalPrice = loadedState.myCartData.overview.grandTotalPrice;
      }
      emit(
        loadedState.copyWith(
          appliedCouponData: appliedCouponData,
          totalPrice: grandTotalPrice,
          discountPrice: discountPrice,
          couponCode: couponCode,
          random: Random().nextDouble(),
        ),
      );
    }
  }

  String findTimeSlotData({required String deliveryTimeDate}) {
    if (deliveryTimeDate.isEmpty) {
      return DateFormat('EEEE').format(CommonWidget.parseDate(
        dateString: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      ));
    } else {
      return DateFormat('EEEE').format(CommonWidget.parseDate(dateString: deliveryTimeDate));
    }
  }

  List<SlotModel> addTimeslot({
    required int deliveryTypeIndex,
    required String deliveryTimeDate,
    String? time,
  }) {
    List<SlotModel> listOfSlot = [];

    if (deliveryTimeDate.isNotEmpty) {
      List dateList = deliveryTimeDate.split('/');
      if (DateTime.now().day == int.parse(dateList[0])) {
        for (var element in myCartEntity!.deliveryType[deliveryTypeIndex].timeslots) {
          if (element.day == findTimeSlotData(deliveryTimeDate: deliveryTimeDate)) {
            for (var e1 in element.slots) {
              if (int.parse(e1.start.replaceAll(':00', '')) > TimeOfDay.now().hour) {
                listOfSlot.add(e1);
              }
            }
          }
        }
      } else {
        for (var element in myCartEntity!.deliveryType[deliveryTypeIndex].timeslots) {
          if (element.day == findTimeSlotData(deliveryTimeDate: deliveryTimeDate)) {
            for (var e1 in element.slots) {
              listOfSlot.add(e1);
            }
          }
        }
      }
    } else {
      for (var element in myCartEntity!.deliveryType[deliveryTypeIndex].timeslots) {
        if (element.day == findTimeSlotData(deliveryTimeDate: deliveryTimeDate)) {
          for (var e1 in element.slots) {
            if (int.parse(e1.start.replaceAll(':00', '')) > TimeOfDay.now().hour) {
              listOfSlot.add(e1);
            }
          }
        }
      }
    }

    return listOfSlot;
  }
}
