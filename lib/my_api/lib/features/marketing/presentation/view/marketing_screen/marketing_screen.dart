import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/banner_screen/banner_screen.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/marketing_screen/marketing_widget.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/notification/notification_widget.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/popup_screen/popup_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketingScreen extends StatefulWidget {
  const MarketingScreen({super.key});

  @override
  State<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends MarketingWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: SelectedTab.values.length,
        child: BlocBuilder<MarketingCubit, MarketingState>(
          bloc: marketingCubit,
          builder: (context, state) {
            if (state is MarketingLoadedState) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: appConstants.backGroundColor,
                appBar: appbar(context, state),
                body: Column(
                  children: [
                    tabBarView(context: context, state: state),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: marketingFilterAndSearchField(state: state),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  bannerView(
                                    state: state,
                                    context: context,
                                    marketingCubit: marketingCubit,
                                    displayData: state.filteredAndSearchedData ?? state.marketingData,
                                  ),
                                  popUpView(
                                    state: state,
                                    context: context,
                                    marketingCubit: marketingCubit,
                                    displayData: state.filteredAndSearchedData ?? state.marketingData,
                                  ),
                                  notificationView(
                                    state: state,
                                    context: context,
                                    marketingCubit: marketingCubit,
                                    displayData: state.filteredAndSearchedData ?? state.marketingData,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Visibility(
                  visible: state.displayFilter ? false : true,
                  child: addAdsButton(state, context),
                ),
              );
            } else if (state is MarketingLoadingState) {
              return CommonWidget.loadingIos();
            } else if (state is MarketingErrorState) {
              return Center(
                child: CommonWidget.commonText(text: state.errormessage),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
