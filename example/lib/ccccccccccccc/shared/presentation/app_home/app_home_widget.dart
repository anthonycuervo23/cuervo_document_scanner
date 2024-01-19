import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/common/extention/theme_extension.dart';
import 'package:captain_score/di/get_it.dart';
import 'package:captain_score/features/home_screen/presentation/pages/home_screen.dart';
import 'package:captain_score/features/match/presentation/pages/match_screen.dart';
import 'package:captain_score/features/more/presentation/pages/more_screen.dart';
import 'package:captain_score/features/news/presentation/pages/news_screen.dart';
import 'package:captain_score/features/shorts/presentation/cubit/shorts_cubit.dart';
import 'package:captain_score/features/shorts/presentation/pages/shorts_screen.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:captain_score/shared/cubit/counter/counter_cubit.dart';
import 'package:captain_score/shared/presentation/app_home/app_home_screen.dart';
import 'package:captain_score/shared/presentation/app_home/bottom_nav_constants.dart';
import 'package:captain_score/shared/presentation/app_home/nav_title_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppHomeWidget extends State<AppHome> with WidgetsBindingObserver {
  late BottomNavigationCubit bottomNavigationCubit;
  // late GetUserDataCubit userDataLoadCubit;

  final screen = [
    const HomePage(),
    const ShortsScreen(),
    const MatchesScreen(),
    const NewsScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    shortsCubit = getItInstance<ShortsCubit>();

    // userDataLoadCubit = getItInstance<GetUserDataCubit>();
    // comboOfferCubit = getItInstance<ComboOfferCubit>();
    // offerCubit = getItInstance<OfferCubit>();
    super.initState();
    // AppFunctions().getUserToken();
    bottomNavigationCubit = BlocProvider.of<BottomNavigationCubit>(context);
    // if (userToken != null) {
    //   userDataLoadCubit.loadUserData(loadShow: true);
    // Future.delayed(
    //   const Duration(seconds: 1),
    // ).then((value) => userDataLoadCubit.loadUserData(loadShow: true));
    // }
  }

  @override
  void dispose() {
    shortsCubit.close();
    super.dispose();
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
        text: TranslationConstants.captain_score.translate(context),
        style: Theme.of(context).textTheme.subTitle2MediumHeading.copyWith(color: appConstants.default1Color),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            // CommonRouter.pushNamed(RouteList.notification_screen);
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
                        color: appConstants.default10Color,
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
            onTap: () {
              // CommonRouter.pushNamed(RouteList.refer_earn_screen);
            },
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 75.h,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(vertical: isNeedSafeArea ? 8.h : 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.01, 0.9],
                  colors: <Color>[
                    appConstants.gradiantColor1,
                    appConstants.gradiantColor2,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: appConstants.default9Color,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i = 0; i < bottomBarItems.length; i++)
                          Expanded(
                            child: NavTitleWidget(
                              title: bottomBarItems[i].title.translate(context),
                              onTap: () {
                                if (i == 1) {
                                  shortsCubit.controller.play();
                                } else {
                                  shortsCubit.controller.pause();
                                }

                                // if (i == 0) {
                                //   // comboOfferCubit.loadInitialData();
                                // } else if (i == 2) {
                                //   // offerCubit.loadInitialData();
                                // }
                                bottomNavigationCubit.changedBottomNavigation(i);
                              },
                              iconPath: bottomBarItems[i].icon,
                              isSelected: bottomBarItems[i].index == state,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
