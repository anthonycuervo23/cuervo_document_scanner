import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/offers/data/models/offer_details_model.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/add_offers/add_offers_state.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/view/add_offers/add_offers_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOffersScreen extends StatefulWidget {
  final OfferDetailsModel arguments;
  const AddOffersScreen({super.key, required this.arguments});

  @override
  State<AddOffersScreen> createState() => _AddOffersScreenState();
}

class _AddOffersScreenState extends AddOffersWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          context,
          shadowcolor: appConstants.grey,
          elevation: 0.4,
          onTap: () => CommonRouter.pop(),
          fontSize: 16.sp,
          title: addOffersCubitCubit.amountController.text.isEmpty
              ? TranslationConstants.add_offer.translate(context)
              : TranslationConstants.edit_offer.translate(context),
          titleCenter: false,
        ),
        body: BlocBuilder(
          bloc: addOffersCubitCubit,
          builder: (context, state) {
            if (state is AddOffersLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      textfildAndLabel(
                        textEditingController: addOffersCubitCubit.offerTitleController,
                        title: TranslationConstants.offer_title.translate(context),
                        hint: TranslationConstants.enter_offer_title.translate(context),
                        textInputType: TextInputType.text,
                      ),
                      textfildAndLabel(
                        textEditingController: addOffersCubitCubit.shortDescriptionController,
                        title: TranslationConstants.short_description.translate(context),
                        hint: TranslationConstants.enter_description.translate(context),
                        textInputType: TextInputType.text,
                        maxline: 3,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                selectDiscountBottomSheet(
                                  title: TranslationConstants.select_discount.translate(context),
                                  state: state,
                                );
                              },
                              child: textfildAndLabel(
                                enabled: false,
                                suffixwidget: CommonWidget.commonIcon(
                                  icon: Icons.arrow_drop_down,
                                  iconColor: appConstants.neutral6Color,
                                  iconSize: 25.sp,
                                ),
                                textEditingController: TextEditingController(
                                  text: addOffersCubitCubit.selectedDiscountValue == 1 ? "Percentage" : "Discount",
                                ),
                                title: TranslationConstants.offer_type.translate(context),
                                hint: TranslationConstants.enter_offer_type.translate(context),
                                textInputType: TextInputType.text,
                              ),
                            ),
                          ),
                          CommonWidget.sizedBox(width: 10.w),
                          Expanded(
                            child: textfildAndLabel(
                              textEditingController: addOffersCubitCubit.amountController,
                              title: TranslationConstants.amount.translate(context),
                              hint: TranslationConstants.enter_amount.translate(context),
                              textInputType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: textfildAndLabel(
                              textEditingController: addOffersCubitCubit.offerCodeController,
                              textCapitalization: TextCapitalization.characters,
                              title: TranslationConstants.offer_code.translate(context),
                              hint: TranslationConstants.enter_offer_code.translate(context),
                              textInputType: TextInputType.text,
                            ),
                          ),
                          CommonWidget.sizedBox(width: 10.w),
                          Expanded(
                            child: textfildAndLabel(
                              textEditingController: addOffersCubitCubit.offerLimitController,
                              title: TranslationConstants.order_limit.translate(context),
                              hint: TranslationConstants.enter_order_limit.translate(context),
                              textInputType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      datePickView(state: state),
                    ],
                  ),
                ),
              );
            } else if (state is AddOffersLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddOffersErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CommonWidget.commonButton(
            context: context,
            height: 55.h,
            text: TranslationConstants.submit.translate(context),
            alignment: Alignment.center,
            color: appConstants.themeColor,
            textColor: appConstants.white,
            onTap: () {
              CustomSnackbar.show(
                snackbarType: SnackbarType.SUCCESS,
                message: "Save",
              );
            },
          ),
        ));
  }
}
