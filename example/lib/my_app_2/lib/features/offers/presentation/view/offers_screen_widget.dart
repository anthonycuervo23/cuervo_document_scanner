// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/offer_model.dart';
import 'package:bakery_shop_flutter/features/offers/domain/params/apply_coupon_parms.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/view/offers_screen_view.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;

abstract class OffersScreenWidget extends State<OfferScreenView> {
  late OfferCubit offerCubit;
  TextEditingController couponCodes = TextEditingController();

  @override
  void initState() {
    super.initState();
    offerCubit = getItInstance<OfferCubit>();
    offerCubit.loadInitialData();
  }

  @override
  void dispose() {
    offerCubit.loadingCubit.hide();
    offerCubit.close();
    super.dispose();
  }

  Widget offerBox({required int index, required OfferLoadedState state, required SingleCouponData offerData}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        shadowColor: appConstants.default11Color,
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: ClipPath(
            clipper: OfferCouponClipper(),
            child: Container(
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: appConstants.whiteBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  offerCode(index: index, offerData: offerData),
                  CommonWidget.sizedBox(height: 50, child: dividerLine()),
                  offerDetails(offerData: offerData, index: index, state: state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget offerDetails({required SingleCouponData offerData, required int index, required OfferLoadedState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonText(
            text: offerData.title,
            style: Theme.of(context).textTheme.bodyBookHeading.copyWith(
                  color: appConstants.default3Color,
                ),
          ),
          CommonWidget.commonText(
            maxLines: 2,
            text: offerData.shortDescription,
            style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                  color: appConstants.primary1Color,
                ),
          ),
          viewDetailsAndApply(index: index, state: state, offerData: offerData),
          offerDescription(offerData: offerData),
        ],
      ),
    );
  }

  Widget cartOfferView({required BuildContext context, required OfferLoadedState state}) {
    return Visibility(
      visible: widget.offerScreenChange == OfferScreenChangeEnum.cart,
      child: CommonWidget.container(
        isBorderOnlySide: true,
        bottomLeft: 20.r,
        bottomRight: 20.r,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              CommonWidget.sizedBox(height: 30),
              Stack(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => CommonRouter.pop(),
                        child: CommonWidget.container(
                          height: 20.h,
                          width: 20.w,
                          alignment: Alignment.center,
                          child: CommonWidget.imageBuilder(
                            height: 20.h,
                            width: 20.w,
                            imageUrl: 'assets/photos/svg/common/back_arrow.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonWidget.commonText(
                        text: TranslationConstants.coupons_for_you.translate(context),
                        style: Theme.of(context).textTheme.subTitle2BoldHeading.copyWith(
                              color: appConstants.default1Color,
                              height: 0,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              CommonWidget.sizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonWidget.container(
                      // height: 50.w,
                      child: CommonWidget.textField(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                        context: context,
                        controller: couponCodes,
                        textInputType: TextInputType.text,
                        hintText: TranslationConstants.enter_coupon_code.translate(context),
                      ),
                    ),
                  ),
                  CommonWidget.sizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      String coupon = couponCodes.text;
                      offerCubit.applyCoupons(
                        parms: ApplyCouponParms(couponCode: coupon),
                        state: state,
                        context: context,
                        isCart: true,
                      );
                    },
                    child: CommonWidget.container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 13.h),
                      borderRadius: appConstants.prductCardRadius,
                      color: appConstants.primary1Color,
                      child: CommonWidget.commonText(
                        text: TranslationConstants.apply.translate(context),
                        style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                              color: appConstants.buttonTextColor,
                            ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void commonErrorSnackbar(BuildContext context, {required String message}) {
    CustomSnackbar.show(
      snackbarType: SnackbarType.ERROR,
      message: message,
    );
  }

  Widget viewDetailsAndApply({
    required int index,
    required OfferLoadedState state,
    required SingleCouponData offerData,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => offerCubit.showOfferDetail(index: index, state: state),
          child: Visibility(
            visible: offerData.description.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.commonText(
                    text: offerData.isOpenViewDetails
                        ? TranslationConstants.hide_details.translate(context)
                        : TranslationConstants.view_details.translate(context),
                    style: Theme.of(context).textTheme.captionMediumHeading.copyWith(
                          color: appConstants.default3Color,
                        ),
                  ),
                  CommonWidget.commonIcon(
                    icon: offerData.isOpenViewDetails ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    iconColor: appConstants.default3Color,
                    iconSize: 20.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            if (cartState is CartLoadedState) {
              return CommonWidget.textButton(
                text: TranslationConstants.apply.translate(context),
                textStyle: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                      color: appConstants.primary1Color,
                    ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                onTap: () async {
                  await offerCubit.applyCoupons(
                    isCart: widget.offerScreenChange == OfferScreenChangeEnum.cart,
                    parms: ApplyCouponParms(couponCode: offerData.code),
                    state: state,
                    context: context,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        )
      ],
    );
  }

  Widget offerDescription({required SingleCouponData offerData}) {
    dom.Document document = htmlparser.parse(offerData.description);
    return Visibility(
      visible: offerData.isOpenViewDetails,
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Html.fromDom(document: document),
      ),
    );
  }

  Widget dividerLine() {
    return CommonWidget.sizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CommonWidget.commonDashLine(
                color: appConstants.default7Color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget offerCode({required int index, required SingleCouponData offerData}) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h, right: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: ScreenUtil().screenWidth * 0.7),
            decoration: BoxDecoration(
              color: appConstants.primary1Color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.r),
                bottomRight: Radius.circular(50.r),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 0.5,
                  offset: const Offset(2, 3),
                  color: appConstants.secondary1Color,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: CommonWidget.commonText(
              text: offerData.type == "Percentage"
                  ? "${offerData.amount}% Off Up To ${CommonWidget.sringToCurrencyFormate(text: offerData.orderLimit.replaceAll('.00', ''))}"
                  : "${CommonWidget.sringToCurrencyFormate(text: offerData.amount.replaceAll('.00', ''))} Off Up To ${CommonWidget.sringToCurrencyFormate(text: offerData.orderLimit.replaceAll('.00', ''))}",
              style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                    color: appConstants.buttonTextColor,
                  ),
            ),
          ),
          Row(
            children: [
              CommonWidget.commonText(
                text: offerData.code,
                style: Theme.of(context).textTheme.bodyBoldHeading.copyWith(
                      color: appConstants.default1Color,
                    ),
              ),
              CommonWidget.sizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class OfferCouponClipper extends CustomClipper<Path> {
  OfferCouponClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ),
    );
    path.addOval(
      Rect.fromCircle(center: Offset(0, (190.h / 4.h) * 1.8.h), radius: 15.r),
    );
    path.addOval(
      Rect.fromCircle(center: Offset(size.width + 0, (190.h / 4.h) * 1.8.h), radius: 15.r),
    );
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
