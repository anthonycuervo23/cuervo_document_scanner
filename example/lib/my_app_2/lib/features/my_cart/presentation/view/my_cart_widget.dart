// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/loaction_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/model/address_detail_model.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/data/models/my_cart_model.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/params/update_quantity_parms.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/view/my_cart_screen.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/coupon_apply_model.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:bakery_shop_flutter/features/products/data/models/product_data_for_cart_model.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/widgets/animated_flip_counter.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class MyCartWidget extends State<MyCartScreen> {
  late CartCubit cartCubit;
  FlutterContactPicker contactPicker = FlutterContactPicker();
  List<SlotModel> listOfSlot = [];

  @override
  void initState() {
    cartCubit = BlocProvider.of<CartCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cartCubit.cookingInsructionController.clear();
    cartCubit.otherAreaController.clear();
    cartCubit.altNumberController.clear();
    cartCubit.otherLandmarkController.clear();
    cartCubit.otherNameController.clear();
    cartCubit.otherNumberController.clear();
  }

  Widget cartItems({required CartLoadedState state}) {
    return CommonWidget.container(
      color: appConstants.whiteBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: TranslationConstants.items.translate(context),
            style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.default1Color),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: myCartEntity!.cart.length,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              CartProductData productData = myCartEntity!.cart[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: productData.product.type
                              ? "assets/photos/svg/common/vegetarian_icon.svg"
                              : "assets/photos/svg/common/nonVegetarian_icon.svg",
                          height: 16.sp,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.sizedBox(
                              width: 200,
                              child: CommonWidget.commonText(
                                maxLines: 2,
                                text: productData.product.name,
                                style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                      color: appConstants.default1Color,
                                    ),
                              ),
                            ),
                            Row(
                              children: [
                                CommonWidget.commonText(
                                  text: myCartEntity!.cart[index].product.attributSlug.isEmpty
                                      ? ""
                                      : "${myCartEntity!.cart[index].product.attributSlug}",
                                  style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                        color: appConstants.default1Color,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CommonWidget.container(
                              borderRadius: 8.r,
                              width: 80.w,
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              color: appConstants.secondary1Color,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CommonWidget.sizedBox(
                                    height: 20,
                                    child: CommonWidget.imageButton(
                                      svgPicturePath: "assets/photos/svg/common/minus_icon.svg",
                                      color: appConstants.primary1Color,
                                      iconSize: 2.2.sp,
                                      onTap: () {
                                        int productIndex = localCartDataStore.indexWhere(
                                          (element) => listEquals(
                                            element.slugs,
                                            productData.product.attributSlug,
                                          ),
                                        );
                                        ProductDataForCartModel model = ProductDataForCartModel(
                                          productId: productData.product.id,
                                          productName: productData.product.name,
                                          productPrice: double.parse(productData.product.price.replaceAll(',', '')),
                                          productAttributsId: 0,
                                          slugs: productData.product.attributSlug,
                                          productSlugPrice: 0,
                                          totalProduct: productData.qty - 1,
                                        );
                                        if (model.totalProduct == 0) {
                                          localCartDataStore.removeAt(productIndex);
                                        } else {
                                          localCartDataStore[productIndex] = model;
                                        }
                                        cartCubit.updateQuantityData(
                                          parms: UpdateQuantityParms(
                                            cartId: productData.id,
                                            quantity: productData.qty - 1,
                                          ),
                                          isCallGetCartApi: true,
                                          isLoaderShow: true,
                                        );
                                      },
                                    ),
                                  ),
                                  AnimatedFlipCounter(
                                    value: productData.qty,
                                    textStyle: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                          color: appConstants.primary1Color,
                                        ),
                                    fractionDigits: 0,
                                  ),
                                  CommonWidget.imageButton(
                                    svgPicturePath: "assets/photos/svg/common/plus_icon.svg",
                                    color: appConstants.primary1Color,
                                    iconSize: 12.sp,
                                    onTap: () {
                                      int productIndex = localCartDataStore.indexWhere(
                                        (element) => listEquals(element.slugs, productData.product.attributSlug),
                                      );
                                      ProductDataForCartModel model = ProductDataForCartModel(
                                        productId: productData.product.id,
                                        productName: productData.product.name,
                                        productPrice: double.parse(productData.product.price.replaceAll(',', '')),
                                        productAttributsId: 0,
                                        slugs: productData.product.attributSlug,
                                        productSlugPrice: 0,
                                        totalProduct: productData.qty + 1,
                                      );
                                      if (model.totalProduct == 0) {
                                        localCartDataStore.removeAt(productIndex);
                                      } else {
                                        localCartDataStore[productIndex] = model;
                                      }
                                      cartCubit.updateQuantityData(
                                        parms: UpdateQuantityParms(
                                          cartId: productData.id,
                                          quantity: productData.qty + 1,
                                        ),
                                        isCallGetCartApi: true,
                                        isLoaderShow: true,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            CommonWidget.commonText(
                              text: CommonWidget.sringToCurrencyFormate(
                                text: (productData.product.productPrice * productData.qty),
                              ),
                              style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget addMoreItem({required CartLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () async {
          BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
        },
        child: CommonWidget.container(
          color: appConstants.whiteBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
          isMarginAllSide: true,
          borderRadius: appConstants.prductCardRadius,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.add_more_items.translate(context),
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/cart_screen/add_more_icon.svg", height: 22.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget addCookingInstruction({required CartLoadedState state}) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          barrierColor: appConstants.default2Color,
          backgroundColor: appConstants.whiteBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          context: context,
          builder: (context) => showbottomsheet(),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 12.h),
        child: CommonWidget.container(
          color: appConstants.whiteBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
          isMarginAllSide: true,
          borderRadius: appConstants.prductCardRadius,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.add_cooking_instructions.translate(context),
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/cart_screen/cooking_instructions_icon.svg",
                height: 18.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget couponsandoffer({required CartLoadedState state}) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: CommonWidget.commonText(
              text: TranslationConstants.offer_and_coupons.translate(context).toUpperCase(),
              style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                    color: appConstants.default1Color,
                    letterSpacing: 5.w,
                    wordSpacing: 4.w,
                  ),
            ),
          ),
        ),
        InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () async {
            String? code =
                (await CommonRouter.pushNamed(RouteList.offer_screen, arguments: OfferScreenChangeEnum.cart) ?? "")
                    as String;
            if (offerDataEntity != null) {
              for (var offerData in offerDataEntity!.coupons) {
                if (code == offerData.code) {
                  cartCubit.updateBillDetails(
                    couponCode: CouponCode.apply,
                    isRemoveCoupon: false,
                    appliedCouponData: CouponData(
                      amount: offerData.amount,
                      code: offerData.code,
                      endDate: DateTime.now(),
                      orderLimit: offerData.orderLimit,
                      startDate: DateTime.now(),
                      type: offerData.type,
                    ),
                  );
                }
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: (appliedCouponData == null || (appliedCouponData?.applyOrNot == CouponCode.notApply.name))
                ? CommonWidget.container(
                    color: appConstants.whiteBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
                    isMarginAllSide: true,
                    borderRadius: appConstants.prductCardRadius,
                    child: Row(
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/bottom_navigation_bar/selected_offers.svg",
                          height: 25.h,
                        ),
                        CommonWidget.sizedBox(width: 10),
                        CommonWidget.commonText(
                          text: TranslationConstants.apply_coupons.translate(context),
                          style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                        const Spacer(),
                        CommonWidget.imageBuilder(
                          imageUrl: "assets/photos/svg/cart_screen/errow_next.svg",
                          height: 18.h,
                        )
                      ],
                    ),
                  )
                : CommonWidget.container(
                    color: appConstants.whiteBackgroundColor,
                    isMarginAllSide: true,
                    borderRadius: appConstants.prductCardRadius,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r)),
                                  child: CommonWidget.svgPicture(
                                    svgPicturePath: 'assets/photos/svg/cart_screen/discount_icon.svg',
                                    height: 30.h,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 7, top: 3),
                                  child: CommonWidget.commonText(
                                    text: "%",
                                    style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                          color: appConstants.whiteBackgroundColor,
                                        ),
                                  ),
                                )
                              ],
                            ),
                            CommonWidget.sizedBox(width: 10),
                            SizedBox(
                              width: ScreenUtil().screenWidth * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonWidget.sizedBox(height: 5),
                                  CommonWidget.commonText(
                                    text: appliedCouponData?.type == "Percentage"
                                        ? "Save ${appliedCouponData?.amount}% This Coupon"
                                        : "Save ${CommonWidget.sringToCurrencyFormate(text: "${appliedCouponData?.amount}")} more on this order",
                                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                                          color: appConstants.default1Color,
                                        ),
                                  ),
                                  CommonWidget.commonText(
                                    text:
                                        "${TranslationConstants.code.translate(context)} : ${appliedCouponData?.code}",
                                    style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                          color: appConstants.default3Color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                appliedCouponData = CouponData(
                                  code: "",
                                  type: "",
                                  amount: "",
                                  orderLimit: "",
                                  startDate: DateTime.now(),
                                  endDate: DateTime.now(),
                                  applyOrNot: CouponCode.notApply.name,
                                );
                                cartCubit.updateBillDetails(
                                  couponCode: CouponCode.notApply,
                                  isRemoveCoupon: true,
                                  appliedCouponData: CouponData(
                                    amount: "",
                                    code: "",
                                    endDate: DateTime.now(),
                                    orderLimit: "",
                                    startDate: DateTime.now(),
                                    type: "",
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  CommonWidget.sizedBox(height: 15),
                                  CommonWidget.commonText(
                                    style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                          color: appConstants.primary1Color,
                                        ),
                                    text: TranslationConstants.remove.translate(context),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidget.sizedBox(width: 10),
                          ],
                        ),
                        CommonWidget.commonPadding(
                          allSidePaddingValue: 16.w,
                          isAllSidePdding: true,
                          child: CommonWidget.commonDashLine(color: appConstants.default7Color),
                        ),
                        InkWell(
                          splashFactory: NoSplash.splashFactory,
                          onTap: () => CommonRouter.pushNamed(
                            RouteList.offer_screen,
                            arguments: OfferScreenChangeEnum.cart,
                          ),
                          child: CommonWidget.commonText(
                            text: TranslationConstants.view_all_coupon.translate(context),
                            style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                  color: appConstants.default1Color,
                                ),
                          ),
                        ),
                        CommonWidget.sizedBox(height: 10),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget deliverytimeslot({required CartLoadedState state}) {
    DateTime nextday = DateTime.now().add(const Duration(days: 1));
    DateTime today = DateTime.now();
    return CommonWidget.container(
      color: appConstants.whiteBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: CommonWidget.commonText(
                text: TranslationConstants.routine_order.translate(context).toUpperCase(),
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.default1Color,
                      letterSpacing: 5.w,
                      wordSpacing: 4.w,
                    ),
              ),
            ),
          ),
          CommonWidget.sizedBox(height: 15),
          routinOrder(state: state),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Divider(
              color: appConstants.default7Color,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CommonWidget.commonText(
              text: TranslationConstants.delivery_time_slot.translate(context),
              style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                    color: appConstants.default1Color,
                  ),
            ),
          ),
          Visibility(
            visible: state.routineOrdersForToggle == false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  timeDateSlotBox(
                    state: state,
                    index: 0,
                    day: TranslationConstants.today.translate(context),
                    date: "${today.day}/${today.month}/${today.year}",
                  ),
                  CommonWidget.sizedBox(width: 10),
                  timeDateSlotBox(
                    state: state,
                    index: 1,
                    day: TranslationConstants.tomorrow_cart.translate(context),
                    date: "${nextday.day}/${nextday.month}/${nextday.year}",
                  ),
                  CommonWidget.sizedBox(width: 10),
                  timeDateSlotBox(
                    state: state,
                    index: 2,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 6.h),
            child: CommonWidget.commonText(
              text: state.deliveryType == DeliveryType.standard
                  ? "${TranslationConstants.standard_delivery.translate(context)} : ${state.selectedTimeSlotTime}"
                  : state.deliveryType == DeliveryType.midnight
                      ? TranslationConstants.midnight_delivery.translate(context)
                      : TranslationConstants.fix_time_delivery.translate(context),
              style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                    color: appConstants.primary1Color,
                  ),
            ),
          ),
          Column(
            children: List.generate(
              myCartEntity!.deliveryType.length,
              (index) {
                return Column(
                  children: [
                    CommonWidget.sizedBox(height: 5),
                    deliverytype(
                      state: state,
                      index: index,
                      title: myCartEntity!.deliveryType[index].name,
                      charges: myCartEntity!.deliveryType[index].deliveryPrice == 0
                          ? TranslationConstants.free_time.translate(context)
                          : CommonWidget.sringToCurrencyFormate(text: myCartEntity!.deliveryType[index].deliveryPrice),
                    ),
                    Visibility(
                      visible: (state.deliveryType == DeliveryType.values[index] &&
                          myCartEntity!.deliveryType[index].timeslots.isNotEmpty),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: listOfSlot.isNotEmpty ? 15.w : 0),
                        child: timeslots(deliveryTypeIndex: index, containerHight: 130.h, state: state),
                      ),
                    ),
                    index == 2
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CommonWidget.commonDashLine(),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget routinOrder({required CartLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          routinRow(state: state),
          Visibility(
            visible: state.routineOrdersForToggle,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: CommonWidget.commonDashLine(),
            ),
          ),
          Visibility(
            visible: state.routineOrdersForToggle,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: CommonWidget.commonText(
                  text: TranslationConstants.select_date.translate(context),
                  style: Theme.of(context).textTheme.captionMediumHeading.copyWith(color: appConstants.default1Color),
                ),
              ),
            ),
          ),
          routinTime(state: state),
        ],
      ),
    );
  }

  Widget routinTime({required CartLoadedState state}) {
    return Visibility(
      visible: state.routineOrdersForToggle == true,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () async {
          List<DateTime> dateList = await CommonWidget.datePicker(
            isRangeDate: true,
            context: context,
            maxDate: DateTime(2025),
            minDate: DateTime.now(),
          );
          cartCubit.updateAllData(
            state: state,
            firstDateForRoutingOrder: CommonWidget.dateToString(date: dateList[0]),
            lastDateForRoutingOrder: CommonWidget.dateToString(date: dateList[1]),
          );
        },
        child: CommonWidget.container(
          borderRadius: appConstants.prductCardRadius,
          margin: EdgeInsets.only(bottom: 10.h),
          isBorder: true,
          borderColor: appConstants.greyBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (state.firstDateForRoutingOrder == state.lastDateForRoutingOrder)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: 'assets/photos/svg/cart_screen/other.svg',
                          height: 25.h,
                        ),
                        CommonWidget.sizedBox(width: 10),
                        CommonWidget.commonText(
                          text: TranslationConstants.select_date.translate(context),
                          style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: 'assets/photos/svg/cart_screen/other.svg',
                          height: 25.h,
                        ),
                        CommonWidget.sizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.commonText(
                              text: state.firstDateForRoutingOrder,
                              style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                            CommonWidget.commonText(
                              text: DateFormat.EEEE().format(
                                CommonWidget.parseDate(dateString: state.firstDateForRoutingOrder),
                              ),
                              style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                    color: appConstants.default5Color,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CommonWidget.container(
                          ispaddingAllSide: false,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          color: appConstants.secondary2Color,
                          borderRadius: 25.r,
                          child: CommonWidget.commonText(
                            text: TranslationConstants.to.translate(context).trim(),
                            style: Theme.of(context).textTheme.overLineBoldHeading.copyWith(
                                  color: appConstants.primary1Color,
                                ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.commonText(
                              text: state.lastDateForRoutingOrder,
                              style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                                    color: appConstants.default1Color,
                                  ),
                            ),
                            CommonWidget.commonText(
                              text: DateFormat.EEEE().format(
                                CommonWidget.parseDate(dateString: state.lastDateForRoutingOrder),
                              ),
                              style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                    color: appConstants.default5Color,
                                  ),
                            ),
                          ],
                        ),
                        CommonWidget.sizedBox(width: 25)
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget routinRow({required CartLoadedState state}) {
    return Visibility(
      visible: RoutineOrder.cart == state.nevigateToDrawer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.h,
            backgroundColor:
                state.routineOrdersForToggle == false ? appConstants.greyBackgroundColor : appConstants.secondary2Color,
            child: CommonWidget.imageBuilder(
              height: 20.h,
              color: state.routineOrdersForToggle == false ? appConstants.default1Color : appConstants.primary1Color,
              imageUrl: "assets/photos/svg/cart_screen/routine_order.svg",
            ),
          ),
          CommonWidget.sizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidget.commonText(
                text: TranslationConstants.routine_order.translate(context),
                style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              CommonWidget.commonText(
                text: TranslationConstants.if_you_order_for_daily.translate(context),
                style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.default4Color,
                    ),
              ),
              CommonWidget.sizedBox(height: 5),
              CommonWidget.commonText(
                text: TranslationConstants.note_minimum_2_daysorder.translate(context),
                style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                      color: state.routineOrdersForToggle == false
                          ? appConstants.default5Color
                          : appConstants.requiredColor,
                    ),
              ),
            ],
          ),
          const Spacer(),
          CommonWidget.toggleButton(
            value: state.routineOrdersForToggle,
            onChanged: (value) {
              cartCubit.updateAllData(routineOrdersForToggle: value, state: state);
            },
          ),
        ],
      ),
    );
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  Widget timeslots({
    required int deliveryTypeIndex,
    required double containerHight,
    required CartLoadedState state,
  }) {
    listOfSlot = cartCubit.addTimeslot(
      deliveryTypeIndex: deliveryTypeIndex,
      deliveryTimeDate: state.otherDateForTimeSlot.isNotEmpty ? state.otherDateForTimeSlot : state.deliveryTimeDate,
    );
    if (listOfSlot.isNotEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: ScreenUtil().screenWidth,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: List.generate(
            listOfSlot.length,
            (index) {
              SlotModel model = listOfSlot[index];
              return InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  cartCubit.updateAllData(
                    state: state,
                    selectedTimeSlotTime: "${model.start} - ${model.end}",
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, right: 10.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: state.selectedTimeSlotTime == "${model.start} - ${model.end}"
                          ? appConstants.secondary2Color
                          : appConstants.whiteBackgroundColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: state.selectedTimeSlotTime == "${model.start} - ${model.end}"
                            ? appConstants.primary1Color
                            : appConstants.default6Color,
                      ),
                    ),
                    child: CommonWidget.commonText(
                      text: "${model.start} - ${model.end}",
                      style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                            color: state.selectedTimeSlotTime == "${model.start} - ${model.end}"
                                ? appConstants.primary1Color
                                : appConstants.default1Color,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget deliverytype({
    required int index,
    required String title,
    required String charges,
    required CartLoadedState state,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            changeDeliveryType(index, state);
          },
          child: Row(
            children: [
              Radio(
                fillColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return appConstants.primary1Color;
                    } else {
                      return appConstants.default6Color;
                    }
                  },
                ),
                value: state.deliveryType,
                groupValue: DeliveryType.values[index],
                onChanged: (value) {
                  changeDeliveryType(index, state);
                },
              ),
              CommonWidget.commonText(
                text: title,
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              CommonWidget.sizedBox(width: 10),
              CommonWidget.container(
                color: state.deliveryType == DeliveryType.values[index]
                    ? appConstants.primary1Color
                    : appConstants.default5Color,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                borderRadius: 20.r,
                child: CommonWidget.commonText(
                  text: charges,
                  style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                        color: appConstants.buttonTextColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void changeDeliveryType(int index, CartLoadedState state) {
    double deliveryCharge = 0;
    String times = "";
    listOfSlot = cartCubit.addTimeslot(deliveryTypeIndex: index, deliveryTimeDate: state.deliveryTimeDate);
    if (index == 0) {
      deliveryCharge = 0;
      String time = "";
      for (var slots in listOfSlot) {
        time = '${slots.start} - ${slots.end}';
        break;
      }
      times = time;
    } else if (index == 1) {
      String time = "";
      for (var slots in listOfSlot) {
        time = '${slots.start} - ${slots.end}';
        break;
      }
      times = time;
      deliveryCharge = 120;
    } else {
      deliveryCharge = 150;
    }
    cartCubit.updateBillDetails(deliveryCharge: deliveryCharge, isRemoveCoupon: false);
    cartCubit.updateAllData(
      state: state,
      deleveryCharge: deliveryCharge,
      deliveryType: DeliveryType.values[index],
      deliveryTimeSlotDateType: state.deliveryTimeSlotDateType,
      selectedTimeSlotTime: times,
    );
  }

  Widget timeDateSlotBox({
    required int index,
    String? day,
    String? date,
    required CartLoadedState state,
  }) {
    cartCubit.findTimeSlotData(deliveryTimeDate: state.deliveryTimeDate);
    return Expanded(
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () async {
          if (index == 2) {
            List<DateTime> otherDate = await CommonWidget.datePicker(
              context: context,
              minDate: DateTime.now(),
              isRangeDate: false,
            );
            cartCubit.updateAllData(
              state: state,
              otherDateForTimeSlot: CommonWidget.dateToString(date: otherDate.first),
              deliveryTimeSlotDateType: DeliveryDay.other,
            );
          } else {
            cartCubit.updateAllData(
              state: state,
              deliveryTimeDate: date,
              deliveryTimeSlotDateType: DeliveryDay.values[index],
              otherDateForTimeSlot: "",
            );
          }
        },
        child: CommonWidget.container(
          height: 50.h,
          borderRadius: appConstants.prductCardRadius,
          borderColor: DeliveryDay.values[index] == state.deliveryTimeSlotDateType
              ? appConstants.primary1Color
              : appConstants.default6Color,
          isBorder: true,
          child: index == 2
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonWidget.imageBuilder(
                          imageUrl: 'assets/photos/svg/cart_screen/other.svg',
                          height: 15.h,
                        ),
                        CommonWidget.sizedBox(width: 10),
                        CommonWidget.commonText(
                          text: TranslationConstants.other.translate(context),
                          style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: state.otherDateForTimeSlot.isNotEmpty,
                      child: CommonWidget.commonText(
                        text: state.otherDateForTimeSlot,
                        style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                              color: appConstants.default4Color,
                            ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonWidget.commonText(
                      text: day ?? "",
                      style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                    CommonWidget.commonText(
                      text: date ?? "",
                      style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                            color: appConstants.default4Color,
                          ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget billDetails({required CartLoadedState state}) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: CommonWidget.commonText(
              text: TranslationConstants.bill_details.translate(context).toUpperCase(),
              style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                    color: appConstants.default1Color,
                    letterSpacing: 5.w,
                    wordSpacing: 4.w,
                  ),
            ),
          ),
        ),
        CommonWidget.sizedBox(height: 12),
        CommonWidget.container(
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          isMarginAllSide: false,
          borderRadius: appConstants.prductCardRadius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.item_total.translate(context),
                    style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonText(
                    text: CommonWidget.sringToCurrencyFormate(text: myCartEntity!.overview.total),
                    style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/cart_screen/gst.svg", height: 18.h),
                  CommonWidget.sizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.commonText(
                        style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                        text: TranslationConstants.gst_charge.translate(context),
                      ),
                      CommonWidget.sizedBox(height: 5),
                      CommonWidget.commonText(
                        text:
                            "${TranslationConstants.cgst.translate(context).toUpperCase()} - ${CommonWidget.sringToCurrencyFormate(text: myCartEntity!.overview.gst.cgst)}",
                        style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                              color: appConstants.default5Color,
                            ),
                      ),
                      CommonWidget.commonText(
                        text:
                            "${TranslationConstants.sgst.translate(context).toUpperCase()} - ${CommonWidget.sringToCurrencyFormate(text: myCartEntity!.overview.gst.sgst)}",
                        style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                              color: appConstants.default5Color,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CommonWidget.commonText(
                        text: CommonWidget.sringToCurrencyFormate(text: myCartEntity!.overview.gst.total),
                        style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 10),
              Row(
                children: [
                  CommonWidget.imageBuilder(
                    imageUrl: "assets/photos/svg/cart_screen/delivery_charge.svg",
                    height: 18.h,
                  ),
                  CommonWidget.sizedBox(width: 10),
                  CommonWidget.commonText(
                    text: TranslationConstants.delivery_charge.translate(context),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  const Spacer(),
                  CommonWidget.commonText(
                    text: CommonWidget.sringToCurrencyFormate(text: state.deleveryCharge),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.imageBuilder(imageUrl: "assets/photos/svg/cart_screen/discount.svg", height: 18.h),
                  CommonWidget.sizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.commonText(
                        text: TranslationConstants.discount.translate(context),
                        style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      ),
                      CommonWidget.sizedBox(height: 5),
                      state.couponCode == CouponCode.apply
                          ? Row(
                              children: [
                                CommonWidget.commonText(
                                  text: "${TranslationConstants.coupon_discount.translate(context)} - ",
                                  style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                        color: appConstants.default3Color,
                                      ),
                                ),
                                CommonWidget.commonText(
                                  text: state.appliedCouponData?.type == "Percentage"
                                      ? "${state.appliedCouponData?.amount}%"
                                      : CommonWidget.sringToCurrencyFormate(text: state.appliedCouponData?.amount),
                                  style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                        color: appConstants.default3Color,
                                      ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const Spacer(),
                  CommonWidget.commonText(
                    text: CommonWidget.sringToCurrencyFormate(text: myCartEntity!.overview.discount),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 10),
              Divider(color: appConstants.default7Color),
              CommonWidget.sizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.commonText(
                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                    text: TranslationConstants.grand_total.translate(context),
                  ),
                  CommonWidget.commonText(
                    text: state.totalPrice.formatCurrency(),
                    style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cancellationPolicy({required CartLoadedState state}) {
    return Column(
      children: [
        CommonWidget.sizedBox(height: 15),
        CommonWidget.container(
          color: appConstants.whiteBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: CommonWidget.commonText(
                  text: TranslationConstants.cancellation_policy.translate(context),
                  style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(color: appConstants.default1Color),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CommonWidget.commonText(
                  text: TranslationConstants.cancellation_policy_data.translate(context),
                  maxLines: 4,
                  style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                        color: appConstants.default3Color,
                      ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 12.h), child: Divider(color: appConstants.default7Color)),
              Visibility(
                visible: state.addressDetailsModel?.isCartOtherOption == null,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () => orderForOthers(state: state),
                    child: CommonWidget.container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: CommonWidget.container(
                              color: appConstants.secondary2Color,
                              height: 70.h,
                              borderRadius: appConstants.prductCardRadius,
                              isBorder: true,
                              borderColor: appConstants.primary3Color,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: CommonWidget.imageBuilder(
                                  height: 75.h,
                                  imageUrl: 'assets/photos/svg/cart_screen/giftbox_color.svg',
                                ),
                              ),
                              CommonWidget.sizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CommonWidget.sizedBox(height: 20),
                                  CommonWidget.commonText(
                                    text: TranslationConstants.order_for_others.translate(context),
                                    style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                          color: appConstants.default1Color,
                                        ),
                                  ),
                                  CommonWidget.commonText(
                                    text: TranslationConstants.if_you_order_for_someone_else.translate(context),
                                    style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                          color: appConstants.default5Color,
                                        ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  CommonWidget.sizedBox(height: 18),
                                  CommonWidget.imageBuilder(
                                    imageUrl: "assets/photos/svg/cart_screen/next_icon.svg",
                                    height: 15.h,
                                    color: appConstants.primary2Color,
                                  ),
                                ],
                              ),
                              CommonWidget.sizedBox(width: 16),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CommonWidget.sizedBox(height: 20),
            ],
          ),
        ),
        CommonWidget.sizedBox(height: 12),
      ],
    );
  }

  Widget proceedButton({required BuildContext context, required CartLoadedState state}) {
    return Column(
      children: [
        state.addressDetailsModel?.isAddress == true && state.addressDetailsModel?.addressType != null
            ? CommonWidget.container(
                padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                isBorderOnlySide: true,
                topLeft: 25.r,
                topRight: 25.r,
                color: appConstants.whiteBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.container(
                      width: 50.w,
                      alignment: Alignment.center,
                      child: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/google_map_scree/map_icon_brown.svg",
                        height: 25.h,
                        width: 50.h,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonWidget.commonText(
                                text: TranslationConstants.delivery_at.translate(context),
                                style: Theme.of(context)
                                    .textTheme
                                    .captionBookHeading
                                    .copyWith(color: appConstants.default2Color),
                              ),
                              CommonWidget.commonText(
                                text: state.addressDetailsModel?.addressType.name.toCamelcase() ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyBoldHeading
                                    .copyWith(color: appConstants.default1Color),
                              ),
                              const Spacer(),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () async {
                                  AddressDetailModel addressModel = await CommonRouter.pushNamed(
                                    RouteList.manage_address_screen,
                                    arguments: CheckLoactionNavigation.cart,
                                  ) as AddressDetailModel;
                                  cartCubit.updateAllData(addressDetailsModel: addressModel, state: state);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: CommonWidget.commonText(
                                    text: TranslationConstants.change.translate(context),
                                    style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                                          color: appConstants.primary1Color,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 80.w),
                            child: CommonWidget.commonText(
                              text: state.addressDetailsModel?.address ?? '',
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .overLineBookHeading
                                  .copyWith(color: appConstants.default2Color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        CommonWidget.container(
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () async {
              if (state.addressDetailsModel?.isAddress == null) {
                var addressModel = await CommonRouter.pushNamed(
                  RouteList.manage_address_screen,
                  arguments: CheckLoactionNavigation.cart,
                );
                if (addressModel is AddressDetailModel) {
                  cartCubit.updateAllData(addressDetailsModel: addressModel, state: state);
                }
              }
            },
            child: CommonWidget.container(
              height: 60.h,
              isBorderOnlySide: true,
              topLeft: 25.r,
              topRight: 25.r,
              alignment: Alignment.center,
              color: appConstants.primary1Color,
              child: CommonWidget.commonText(
                text: state.addressDetailsModel?.isAddress == true
                    ? TranslationConstants.proceed_to_pay.translate(context)
                    : TranslationConstants.add_address_and_continue.translate(context),
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.buttonTextColor,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget showbottomsheet() {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: appConstants.whiteBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidget.commonText(
                  text: TranslationConstants.cooking_instructions.translate(context),
                  style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                        color: appConstants.default1Color,
                        height: 0.h,
                      ),
                ),
                CommonWidget.svgIconButton(
                  svgPicturePath: "assets/photos/svg/common/close_icon.svg",
                  onTap: () => CommonRouter.pop(),
                ),
              ],
            ),
            CommonWidget.sizedBox(height: 20),
            CommonWidget.commonText(
              text: TranslationConstants.instruction.translate(context),
              style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                    color: appConstants.default1Color,
                  ),
            ),
            CommonWidget.sizedBox(height: 5),
            TextField(
              controller: cartCubit.cookingInsructionController,
              onTapOutside: (e) => CommonWidget.keyboardClose(context: context),
              onChanged: (value) {
                value.length;
              },
              cursorColor: appConstants.primary1Color,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: TranslationConstants.type_message.translate(context),
                hintStyle: Theme.of(context).textTheme.captionBookHeading.copyWith(
                      color: appConstants.default5Color,
                    ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
                  borderSide: BorderSide(
                    color: appConstants.primary1Color,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(appConstants.prductCardRadius),
                  borderSide: BorderSide(
                    color: appConstants.default7Color,
                  ),
                ),
              ),
            ),
            CommonWidget.sizedBox(height: 5),
            Align(
              alignment: Alignment.topRight,
              child: CommonWidget.commonText(
                text: "100 ${TranslationConstants.characters_left.translate(context)}",
                style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                      color: appConstants.default4Color,
                    ),
              ),
            ),
            CommonWidget.sizedBox(height: 15),
            CommonWidget.commonText(
              maxLines: 3,
              style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                    color: appConstants.default4Color,
                  ),
              text: TranslationConstants.cooking_warring.translate(context),
            ),
            CommonWidget.sizedBox(height: 16),
            CommonWidget.container(
              borderRadius: appConstants.buttonRadius,
              height: 50.h,
              alignment: Alignment.center,
              color: appConstants.primary1Color,
              child: CommonWidget.commonText(
                text: TranslationConstants.cooking_add.translate(context),
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.buttonTextColor,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> orderForOthers({required CartLoadedState state}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: appConstants.default2Color,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          height: ScreenUtil().screenHeight * 0.78,
          decoration: BoxDecoration(
            color: appConstants.whiteBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.ordering_for_others.translate(context),
                    style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                          height: 0,
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.svgIconButton(
                    svgPicturePath: 'assets/photos/svg/common/close_icon.svg',
                    onTap: () => CommonRouter.pop(),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 80.w),
                child: CommonWidget.commonText(
                  maxLines: 2,
                  text: TranslationConstants.receiver_name_and_others_details.translate(context),
                  style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                        color: appConstants.default4Color,
                      ),
                ),
              ),
              CommonWidget.sizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.name.translate(context),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonRequiredStatr(context: context),
                ],
              ),
              CommonWidget.sizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: CommonWidget.textField(
                        context: context,
                        textInputType: TextInputType.name,
                        controller: cartCubit.otherNameController,
                        hintText: TranslationConstants.name.translate(context),
                      ),
                    ),
                    CommonWidget.sizedBox(width: 10),
                    Column(
                      children: [
                        CommonWidget.commonSvgIconButton(
                          height: 30.h,
                          svgPicturePath: "assets/photos/svg/address_screen/contact_icon.svg",
                          onTap: () async {
                            var permission = await Permission.contacts.request().isGranted;
                            if (permission == true) {
                              Contact? contact = await contactPicker.selectContact();
                              if (contact?.fullName != '') {
                                cartCubit.otherNameController.text = contact?.fullName ?? '';
                                cartCubit.otherNumberController.text = contact?.phoneNumbers![0] ?? '';
                              }
                            } else {
                              CustomSnackbar.show(
                                snackbarType: SnackbarType.ERROR,
                                message: TranslationConstants.contact_permission_required.translate(context),
                              );
                            }
                          },
                        ),
                        CommonWidget.commonText(
                          text: TranslationConstants.cart_contacts.translate(context),
                          style: Theme.of(context).textTheme.overLineBookHeading.copyWith(
                                color: appConstants.default1Color,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CommonWidget.sizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.mobile_number.translate(context),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonRequiredStatr(context: context),
                ],
              ),
              CommonWidget.sizedBox(height: 5),
              SizedBox(
                child: CommonWidget.textField(
                  context: context,
                  controller: cartCubit.otherNumberController,
                  textInputType: TextInputType.number,
                  isPrefixWidget: true,
                  maxLength: 10,
                  prefixWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonWidget.commonText(
                        text: "+91",
                        style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                              color: appConstants.default1Color,
                            ),
                      ),
                    ],
                  ),
                  hintText: TranslationConstants.enter_mobile_number.translate(context),
                ),
              ),
              CommonWidget.sizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.flat_no_building_name.translate(context),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonRequiredStatr(context: context),
                ],
              ),
              CommonWidget.sizedBox(height: 5),
              SizedBox(
                child: CommonWidget.textField(
                  controller: cartCubit.otherLandmarkController,
                  context: context,
                  textInputType: TextInputType.streetAddress,
                  isPrefixWidget: true,
                  hintText: TranslationConstants.enter_flat_house_no.translate(context),
                ),
              ),
              CommonWidget.sizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.area_sector_locality.translate(context),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                  CommonWidget.commonRequiredStatr(context: context),
                ],
              ),
              CommonWidget.sizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  PermissionStatus status = await Permission.location.request();
                  if (status.isGranted) {
                    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
                      var args = await CommonRouter.pushNamed(
                        RouteList.location_picker_screen,
                        arguments: const LoactionArguments(
                          checkLoactionNavigator: CheckLoactionNavigation.cart,
                          isNew: false,
                          isEditProfile: true,
                        ),
                      );
                      if (args is AddressScreenArguments) {
                        cartCubit.otherAreaController.text = args.fullAddress;
                      }
                    } else {
                      CustomSnackbar.show(
                        snackbarType: SnackbarType.ERROR,
                        message: TranslationConstants.please_enalble_location.translate(context),
                      );
                    }
                  } else if (status.isPermanentlyDenied) {
                    CustomSnackbar.show(
                      snackbarType: SnackbarType.ERROR,
                      message: TranslationConstants.location_permission_required.translate(context),
                    );
                    await Future.delayed(const Duration(seconds: 1)).then((value) => openAppSettings());
                  } else {
                    CustomSnackbar.show(
                      snackbarType: SnackbarType.ERROR,
                      message: TranslationConstants.location_permission_required.translate(context),
                    );
                  }
                },
                child: CommonWidget.locationTextFiled(controller: cartCubit.otherAreaController, context: context),
              ),
              CommonWidget.sizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonWidget.commonText(
                    text: TranslationConstants.nearby_landmark.translate(context),
                    style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                          color: appConstants.default1Color,
                        ),
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 5),
              SizedBox(
                child: CommonWidget.textField(
                  context: context,
                  textInputType: TextInputType.streetAddress,
                  hintText: TranslationConstants.enter_nearby.translate(context),
                ),
              ),
              CommonWidget.sizedBox(height: 25),
              CommonWidget.commonButton(
                onTap: () {
                  AddressDetailModel addressModel = AddressDetailModel(
                    isCartOtherOption: true,
                    addressType: AddAddressType.other,
                    address: "${cartCubit.otherLandmarkController.text} ${cartCubit.otherAreaController.text}",
                    mobileNo: cartCubit.otherNumberController.text,
                    name: cartCubit.otherNameController.text,
                    distance: "4.5 K.M.",
                    isAddress: true,
                    isCheckDefaultAddress: false,
                  );

                  cartCubit.updateAllData(addressDetailsModel: addressModel, state: state);

                  CommonRouter.pop();
                },
                height: 50.h,
                alignment: Alignment.center,
                text: TranslationConstants.submit.translate(context),
                style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.buttonTextColor,
                    ),
                context: context,
              )
            ],
          ),
        );
      },
    );
  }
}
