import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/offers/data/models/offer_model.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/view/offers_screen_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/without_login_screen/without_login_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferScreenView extends StatefulWidget {
  final OfferScreenChangeEnum offerScreenChange;

  const OfferScreenView({super.key, required this.offerScreenChange});

  @override
  State<OfferScreenView> createState() => _OffersScreenState();
}

class _OffersScreenState extends OffersScreenWidget {
  @override
  Widget build(BuildContext context) {
    return userToken == null
        ? const WithoutLoginScreen(isApplyAppbar: false)
        : BlocBuilder<OfferCubit, OfferState>(
            bloc: offerCubit,
            builder: (context, state) {
              if (state is OfferLoadedState) {
                return Scaffold(
                  appBar: (widget.offerScreenChange == OfferScreenChangeEnum.cart && state.listOfCouponsData.isEmpty)
                      ? customAppBar(
                          context,
                          title: TranslationConstants.offers.translate(context),
                          onTap: () => CommonRouter.pop(),
                        )
                      : null,
                  backgroundColor: appConstants.greyBackgroundColor,
                  body: state.listOfCouponsData.isEmpty
                      ? CommonWidget.dataNotFound(
                          context: context,
                          bgColor: appConstants.greyBackgroundColor,
                          actionButton: const SizedBox.shrink(),
                        )
                      : Column(
                          children: [
                            cartOfferView(context: context, state: state),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                primary: true,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.h, bottom: 10.h),
                                      child: Center(
                                        child: CommonWidget.commonText(
                                          text: widget.offerScreenChange == OfferScreenChangeEnum.cart
                                              ? TranslationConstants.best_offers_for_you
                                                  .translate(context)
                                                  .toUpperCase()
                                              : TranslationConstants.offers.translate(context).toUpperCase(),
                                          style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                                color: appConstants.default1Color,
                                                letterSpacing: 5.w,
                                                wordSpacing: 4.w,
                                              ),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount: state.listOfCouponsData.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        SingleCouponData offerData = state.listOfCouponsData[index];
                                        return offerBox(offerData: offerData, state: state, index: index);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              } else if (state is OfferLoadingState) {
                return CommonWidget.loadingIos();
              } else if (state is OfferErrorState) {
                return CommonWidget.dataNotFound(
                  context: context,
                  heading: TranslationConstants.something_went_wrong.translate(context),
                  subHeading: state.errorMessage,
                  buttonLabel: TranslationConstants.try_again.translate(context),
                  // onTap: () => productCategoryCubit.getCategory(),
                );
              }
              return const SizedBox.shrink();
            },
          );
  }
}
