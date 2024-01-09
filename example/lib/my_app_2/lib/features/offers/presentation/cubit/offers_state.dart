// ignore_for_file: prefer_typing_uninitialized_variables

part of 'offers_cubit.dart';

abstract class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object?> get props => [];
}

class OfferInitialState extends OfferState {
  @override
  List<Object> get props => [];
}

class OfferLoadingState extends OfferState {
  @override
  List<Object> get props => [];
}

class OfferLoadedState extends OfferState {
  final List<SingleCouponData> listOfCouponsData;
  final OfferDataEntity offerDataEntity;
  final CouponApplyModel? couponApplyModel;
  final double? random;

  const OfferLoadedState({
    required this.listOfCouponsData,
    required this.offerDataEntity,
    this.couponApplyModel,
    this.random,
  });

  OfferLoadedState copyWith({
    List<SingleCouponData>? listOfCouponsData,
    OfferDataEntity? offerDataEntity,
    CouponApplyModel? couponApplyModel,
    double? random,
  }) {
    return OfferLoadedState(
      couponApplyModel: couponApplyModel ?? this.couponApplyModel,
      offerDataEntity: offerDataEntity ?? this.offerDataEntity,
      listOfCouponsData: listOfCouponsData ?? this.listOfCouponsData,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [listOfCouponsData, random, offerDataEntity, couponApplyModel];
}

class OfferErrorState extends OfferState {
  final String errorMessage;
  final AppErrorType appErrorType;

  const OfferErrorState({required this.errorMessage, required this.appErrorType});

  @override
  List<Object> get props => [errorMessage, appErrorType];
}
