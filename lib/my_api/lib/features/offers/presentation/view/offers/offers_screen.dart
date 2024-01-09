import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/offers/data/models/offer_details_model.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/offers/offers_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/view/offers/offers_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/bakery_app.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends OffersWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder(
        bloc: offersCubit,
        builder: (context, state) {
          if (state is OffersLoadedState) {
            return Scaffold(
              backgroundColor: appConstants.blueBgColor,
              appBar: CustomAppBar(
                elevation: 0.5,
                shadowcolor: appConstants.grey,
                context,
                titleCenter: false,
                onTap: () => CommonRouter.pop(),
                title: TranslationConstants.offers.translate(context),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    textfile(
                      context: context,
                      onChanged: (v) => offersCubit.filterForSearch(state: state, value: v),
                    ),
                    Expanded(
                      child: state.searcheditems.isEmpty
                          ? CommonWidget.dataNotFound(context: context, actionButton: const SizedBox.shrink())
                          : ListView.builder(
                              itemCount: state.searcheditems.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return commonBox(state: state, index: index);
                              },
                            ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Visibility(
                visible: state.searcheditems.isNotEmpty,
                child: Container(
                  height: 90.h,
                  width: newDeviceType == NewDeviceType.phone
                      ? ScreenUtil().screenWidth
                      : newDeviceType == NewDeviceType.tablet
                          ? ScreenUtil().screenWidth
                          : double.infinity,
                  color: appConstants.white,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => CommonRouter.pushNamed(
                        RouteList.add_offers_screen,
                        arguments: OfferDetailsModel(
                          offerTital: "",
                          offerDescripption: "",
                          cuponText: "",
                          price: "",
                          validUntil: "",
                          maxPrice: "",
                          endDate: "",
                          date: "",
                          offerId: 0,
                          orderLimit: "",
                        ),
                      ),
                      child: Container(
                        height: 45.h,
                        width: newDeviceType == NewDeviceType.phone
                            ? 200.w
                            : newDeviceType == NewDeviceType.tablet
                                ? ScreenUtil().screenWidth / 1.5
                                : ScreenUtil().screenWidth / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: appConstants.themeColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonWidget.imageBuilder(
                              imageUrl: "assets/photos/svg/customer/add_new.svg",
                              height: 20.h,
                            ),
                            CommonWidget.sizedBox(width: 10.w),
                            CommonWidget.commonText(
                              text: TranslationConstants.add_offer.translate(context),
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: appConstants.white,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (state is OffersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OffersErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
