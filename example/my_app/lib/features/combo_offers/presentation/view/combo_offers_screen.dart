import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/combo_offers/presentation/cubit/combo_offer_cubit.dart';
import 'package:bakery_shop_flutter/features/combo_offers/presentation/view/combo_offers_widget.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/without_login_screen/without_login_screen.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ComboOffersScreen extends StatefulWidget {
  const ComboOffersScreen({super.key});

  @override
  State<ComboOffersScreen> createState() => _ComboOffersScreenState();
}

class _ComboOffersScreenState extends ComboOfferScreenWidget {
  @override
  Widget build(BuildContext context) {
    return userToken == null
        ? const WithoutLoginScreen(isApplyAppbar: false)
        : BlocBuilder<ComboOfferCubit, ComboOfferState>(
            bloc: comboOfferCubit,
            builder: (context, state) {
              if (state is ComboOfferLoadedState) {
                return Scaffold(
                  backgroundColor: appConstants.greyBackgroundColor,
                  body: state.comboProductEntity.productList.isEmpty
                      ? CommonWidget.dataNotFound(
                          context: context,
                          bgColor: appConstants.greyBackgroundColor,
                          actionButton: const SizedBox.shrink(),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: LazyLoadScrollView(
                            scrollDirection: Axis.vertical,
                            onEndOfPage: () {
                              if (state.comboProductEntity.nextPageUrl.isNotEmpty) {
                                comboOfferCubit.loadInitialData();
                              }
                            },
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16.h),
                                      child: CommonWidget.commonText(
                                        text: TranslationConstants.combo_offers.translate(context),
                                        style: Theme.of(context).textTheme.bodyMediumHeading.copyWith(
                                              color: appConstants.default1Color,
                                              letterSpacing: 5.w,
                                              wordSpacing: 4.w,
                                              fontSize: 15.sp,
                                            ),
                                      ),
                                    ),
                                  ),
                                  state.comboProductList.isEmpty
                                      ? CommonWidget.dataNotFound(
                                          context: context,
                                          actionButton: const SizedBox.shrink(),
                                        )
                                      : ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: state.comboProductEntity.productList.length,
                                          itemBuilder: (context, index) {
                                            return comboBox(
                                              comboOfferCubit: comboOfferCubit,
                                              index: index,
                                              productData: state.comboProductList[index],
                                              state: state,
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                );
              } else if (state is ComboOfferLoadingState) {
                return Center(child: CommonWidget.loadingIos());
              } else if (state is ComboOfferErrorState) {
                return CommonWidget.dataNotFound(
                  context: context,
                  heading: TranslationConstants.something_went_wrong.translate(context),
                  subHeading: state.errorMessage,
                  buttonLabel: TranslationConstants.try_again.translate(context),
                  onTap: () => comboOfferCubit.loadInitialData(),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
  }
}
