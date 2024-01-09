import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_state.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/view/my_cart_screen.dart';
import 'package:bakery_shop_flutter/features/combo_offers/presentation/view/combo_offers_screen.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/app_home/app_home_screen.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/app_home/bottom_nav_constants.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/app_home/nav_title_widget.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/home_screen/home_screen.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/view/offers_screen_view.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppHomeWidget extends State<AppHome> with WidgetsBindingObserver {
  late BottomNavigationCubit bottomNavigationCubit;
  late GetUserDataCubit userDataLoadCubit;

  final screen = [
    const HomeScreen(),
    const ComboOffersScreen(),
    const OfferScreenView(offerScreenChange: OfferScreenChangeEnum.main),
    const MyCartScreen(),
  ];

  @override
  void initState() {
    userDataLoadCubit = getItInstance<GetUserDataCubit>();
    // comboOfferCubit = getItInstance<ComboOfferCubit>();
    // offerCubit = getItInstance<OfferCubit>();
    super.initState();
    AppFunctions().getUserToken();
    bottomNavigationCubit = BlocProvider.of<BottomNavigationCubit>(context);
    if (userToken != null) {
      userDataLoadCubit.loadUserData(loadShow: true);
      // Future.delayed(
      //   const Duration(seconds: 1),
      // ).then((value) => userDataLoadCubit.loadUserData(loadShow: true));
    }
  }

  AppBar appBar() {
    return AppBar(
      surfaceTintColor: appConstants.whiteBackgroundColor,
      backgroundColor: appConstants.whiteBackgroundColor,
      iconTheme: IconThemeData(color: appConstants.default1Color),
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(), // And this!
          icon: CommonWidget.imageBuilder(
            imageUrl: "assets/photos/svg/appbar/drawer_icon.svg",
            fit: BoxFit.cover,
            height: 15.h,
          ),
        );
      }),
      title: CommonWidget.commonText(
        text: TranslationConstants.bakery_shop.translate(context),
        style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.default1Color),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            CommonRouter.pushNamed(RouteList.notification_screen);
            // if (adsCubit.shouldShowInterestialAds()) {
            //   adsCubit.createInterstitialAd();
            //   await adsCubit.showInterestialAd();
            // }
            // await Catcher2.navigatorKey?.currentState?.pushNamed(RouteList.notification_page);
            // if (adsCubit.shouldShowInterestialAds()) {
            //   adsCubit.createInterstitialAd();
            //   await adsCubit.showInterestialAd();
            // }
          },
          child: BlocBuilder<CounterCubit, int>(
            bloc: badgeCounterCubit,
            builder: (context, state) {
              return Badge(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(2),
                label: Text(
                  1 == 1 ? '100' : totalNotificationCounts.toString(),
                  style: Theme.of(context).textTheme.h4BoldHeading.copyWith(
                        color: appConstants.buttonTextColor,
                        fontSize: 10.sp,
                        height: 1,
                      ),
                ),
                // isLabelVisible: totalNotificationCounts == 0 ? false : true,
                child: CommonWidget.imageBuilder(
                  imageUrl: 'assets/photos/svg/appbar/notification_icon.svg',
                  height: 20.h,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12.w, left: 15.h),
          child: GestureDetector(
            onTap: () => CommonRouter.pushNamed(RouteList.refer_earn_screen),
            child: Container(
              height: 26.h,
              width: 76.w,
              padding: EdgeInsets.only(right: 3.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: appConstants.secondary2Color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 5.w),
                    height: 26.h,
                    child: CommonWidget.imageBuilder(
                      imageUrl: "assets/photos/svg/common/coin_icon.svg",
                      fit: BoxFit.contain,
                      height: 16.h,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  CommonWidget.commonText(
                    text: "250",
                    fontSize: 13.sp,
                    bold: true,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomBar() {
    return BlocBuilder<BottomNavigationCubit, int>(
      bloc: bottomNavigationCubit,
      builder: (BuildContext context, int state) {
        bool isNeedSafeArea = View.of(context).viewPadding.bottom > 0;
        return Container(
          height: isNeedSafeArea ? 76.h : 64.h,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(vertical: isNeedSafeArea ? 8.h : 0),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: appConstants.default9Color, blurRadius: 2, offset: const Offset(0, 1))],
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < bottomBarItems.length; i++)
                      Expanded(
                        child: i != 3
                            ? NavTitleWidget(
                                title: bottomBarItems[i].title.translate(context),
                                onTap: () {
                                  if (i == 1) {
                                    // comboOfferCubit.loadInitialData();
                                  } else if (i == 2) {
                                    // offerCubit.loadInitialData();
                                  }
                                  bottomNavigationCubit.changedBottomNavigation(i);
                                },
                                iconPath: bottomBarItems[i].icon,
                                activatedIcon: bottomBarItems[i].activatedIcon,
                                isSelected: bottomBarItems[i].index == state,
                              )
                            : BlocBuilder<CartCubit, CartState>(
                                builder: (context, states) {
                                  if (states is CartLoadedState) {
                                    return InkWell(
                                      onTap: () {
                                        bottomNavigationCubit.changedBottomNavigation(3);
                                        // BlocProvider.of<CartCubit>(context).loadInitialData();
                                      },
                                      child: Container(
                                        color: appConstants.whiteBackgroundColor,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Badge(
                                            //   isLabelVisible: states.data.cart.isEmpty ? false : true,
                                            //   alignment: Alignment.topRight,
                                            //   label: Text(
                                            //     " ${states.data.cart.length} ",
                                            //     style: Theme.of(context).textTheme.h4BoldHeading.copyWith(
                                            //           color: appConstants.buttonTextColor,
                                            //           fontSize: 6.sp,
                                            //           height: 1,
                                            //         ),
                                            //   ),
                                            //   backgroundColor: appConstants.requiredColor,
                                            //   child: CommonWidget.imageBuilder(
                                            //     imageUrl: bottomBarItems[3].index == state
                                            //         ? bottomBarItems[3].activatedIcon
                                            //         : bottomBarItems[3].icon,
                                            //     color: bottomBarItems[3].index == state
                                            //         ? appConstants.primary1Color
                                            //         : appConstants.default5Color,
                                            //     width: 22.r,
                                            //     height: 22.r,
                                            //   ),
                                            // ),
                                            SizedBox(
                                              width: 20.w,
                                              child: Stack(
                                                children: [
                                                  CommonWidget.imageBuilder(
                                                    imageUrl: bottomBarItems[3].index == state
                                                        ? bottomBarItems[3].activatedIcon
                                                        : bottomBarItems[3].icon,
                                                    color: bottomBarItems[3].index == state
                                                        ? appConstants.primary1Color
                                                        : appConstants.default5Color,
                                                    width: 22.r,
                                                    height: 22.r,
                                                  ),
                                                  localCartDataStore.isEmpty
                                                      ? const SizedBox.shrink()
                                                      : Align(
                                                          alignment: Alignment.topRight,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: appConstants.requiredColor,
                                                            ),
                                                            padding:
                                                                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                            child: CommonWidget.commonText(
                                                              text: "${localCartDataStore.length}",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .captionBookHeading
                                                                  .copyWith(
                                                                    color: appConstants.whiteBackgroundColor,
                                                                    fontSize: 8.sp,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                            CommonWidget.sizedBox(height: 6),
                                            Text(
                                              TranslationConstants.my_cart.translate(context),
                                              style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                                                    color: bottomBarItems[3].index == state
                                                        ? appConstants.primary1Color
                                                        : appConstants.default5Color,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return InkWell(
                                    onTap: () => bottomNavigationCubit.changedBottomNavigation(3),
                                    child: Container(
                                      color: appConstants.whiteBackgroundColor,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CommonWidget.imageBuilder(
                                            imageUrl: bottomBarItems[3].index == state
                                                ? bottomBarItems[3].activatedIcon
                                                : bottomBarItems[3].icon,
                                            color: bottomBarItems[3].index == state
                                                ? appConstants.primary1Color
                                                : appConstants.default5Color,
                                            width: 22.r,
                                            height: 22.r,
                                          ),
                                          CommonWidget.sizedBox(height: 6),
                                          Text(
                                            TranslationConstants.my_cart.translate(context),
                                            style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                                                  color: bottomBarItems[3].index == state
                                                      ? appConstants.primary1Color
                                                      : appConstants.default5Color,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
