import 'dart:developer';
import 'dart:io';
import 'package:bakery_shop_flutter/app_localizations.dart';
import 'package:bakery_shop_flutter/common/constants/languages.dart';
import 'package:bakery_shop_flutter/common/constants/theme.dart';
import 'package:bakery_shop_flutter/di/get_it.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/language/language_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/account_info/account_info_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/theme/theme_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/loading/loading_screen.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/network_connection/network_connection.dart';
import 'package:bakery_shop_flutter/routing/fade_page_route_builder.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/routing/router.dart';
import 'package:bakery_shop_flutter/utils/analytics_service.dart';
import 'package:bakery_shop_flutter/utils/app_functions.dart';
import 'package:bakery_shop_flutter/utils/my_route_observor.dart';
import 'package:catcher_2/core/catcher_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DeviceType { phone, tablet }

class BakeryApp extends StatefulWidget {
  const BakeryApp({super.key});

  @override
  State<BakeryApp> createState() => _BakeryAppState();
}

class _BakeryAppState extends State<BakeryApp> {
  late LanguageCubit _languageCubit;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;
  late BottomNavigationCubit _bottomNavigationCubit;
  late ToggleCubit _toggleCubit;
  late EditProfileCubit _editProfileCubit;
  late ProductListCubit _productListCubit;
  late AccountInfoCubit _accountInfoCubit;
  late CartCubit _cartCubit;
  late GetUserDataCubit _userDataLoadCubit;
  @override
  void initState() {
    appConstants.loadLight();
    super.initState();

    _languageCubit = getItInstance<LanguageCubit>();
    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();
    _loadingCubit = getItInstance<LoadingCubit>();
    _bottomNavigationCubit = getItInstance<BottomNavigationCubit>();
    _toggleCubit = getItInstance<ToggleCubit>();
    _editProfileCubit = getItInstance<EditProfileCubit>();
    badgeCounterCubit = getItInstance<CounterCubit>();
    _productListCubit = getItInstance<ProductListCubit>();
    badgeCounterCubit = getItInstance<CounterCubit>();
    _accountInfoCubit = getItInstance<AccountInfoCubit>();
    _cartCubit = getItInstance<CartCubit>();
    _userDataLoadCubit = getItInstance<GetUserDataCubit>();

    _cartCubit.loadInitialData(isShowLoader: false);
    loadInitialData();
    initialization();
    logicOfIntroductionScreen();
    // interceptorsDio();
    getPreviousNotificationCount();
    internetCheck();
  }

  void loadInitialData() {
    _accountInfoCubit.loadInitialData();
  }

  @override
  void dispose() {
    _languageCubit.close();
    _themeCubit.close();
    _loadingCubit.close();
    _bottomNavigationCubit.close();
    _toggleCubit.close();
    _editProfileCubit.close();
    badgeCounterCubit.close();
    _productListCubit.close();
    _accountInfoCubit.close();
    _cartCubit.close();
    _userDataLoadCubit.close();
    super.dispose();
  }

  Future<void> getPreviousNotificationCount() async {
    totalNotificationCounts = await AppFunctions().getNotificationCount();
  }

// splash remove
  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  void internetCheck() {
    if (Platform.isAndroid) {
      listenConnection();
    }
  }

  // initialize dio and add interceptors
  // void interceptorsDio() {
  //   var dio = NetworkApiService.client;
  //   dio.interceptors.addAll([
  //     LoggingInterceptor(),
  //     RetryOnConnectionChangeInterceptor(
  //       requestRetrier: DioConnectivityRequestRetrier(
  //         dio: dio,
  //         connectivity: Connectivity(),
  //       ),
  //     ),
  //   ]);
  // }

  DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(View.of(context));
    return data.size.shortestSide < 550 ? DeviceType.phone : DeviceType.tablet;
  }

  int counter = 0;
  logicOfIntroductionScreen() async {
    final prefs = await SharedPreferences.getInstance();
    counter = prefs.getInt('counter') ?? 0;
  }

  BuildContext? rootContext;

  @override
  Widget build(BuildContext context) {
    rootContext = context;

    if (kDebugMode && 1 != 1) {
      debugInvertOversizedImages = true;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
        BlocProvider<BottomNavigationCubit>.value(value: _bottomNavigationCubit),
        BlocProvider<ToggleCubit>.value(value: _toggleCubit),
        BlocProvider<EditProfileCubit>.value(value: _editProfileCubit),
        BlocProvider<CounterCubit>.value(value: badgeCounterCubit),
        BlocProvider<AccountInfoCubit>.value(value: _accountInfoCubit),
        BlocProvider<CartCubit>.value(value: _cartCubit),
        BlocProvider<GetUserDataCubit>.value(value: _userDataLoadCubit),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        bloc: _themeCubit,
        builder: (context, theme) {
          if (Platform.isAndroid) {
            // SystemChrome.setSystemUIOverlayStyle(
            //   SystemUiOverlayStyle(
            //     statusBarColor: theme == Themes.dark ? appConstants.theme1Color : appConstants.theme1Color,
            //     statusBarIconBrightness: theme == Themes.dark ? Brightness.dark : Brightness.light,
            //   ),
            // );
          } else if (Platform.isIOS) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: theme == Themes.dark ? appConstants.primary1Color : appConstants.primary1Color,
              statusBarIconBrightness: theme == Themes.dark ? Brightness.light : Brightness.dark,
              statusBarBrightness: theme == Themes.dark ? Brightness.dark : Brightness.light,
            ));
          }
          return Material(
            child: BlocBuilder<LanguageCubit, LanguageState>(
              bloc: _languageCubit,
              builder: (context, state) {
                if (state is LanguageLoadedState) {
                  return ScreenUtilInit(
                    useInheritedMediaQuery: true,
                    designSize: getDeviceType() == DeviceType.tablet ? const Size(834, 1194) : const Size(360, 800),
                    rebuildFactor: (old, data) => RebuildFactors.orientation(old, data),
                    splitScreenMode: true,
                    minTextAdapt: true,
                    builder: (context, snapshot) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        locale: state.locale,
                        supportedLocales: languages.map((e) => Locale(e.shortCode.toString())).toList(),
                        localizationsDelegates: const [
                          AppLocalizations.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        themeMode: theme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
                        scaffoldMessengerKey: snackbarKey,
                        navigatorKey: Catcher2.navigatorKey,
                        navigatorObservers: <NavigatorObserver>[
                          AnalyticsService.getAnalyticsObserver(),
                          MyRouteObserver(),
                        ],
                        theme: ThemeData(
                          fontFamily: 'Circular Std',
                          dialogBackgroundColor: appConstants.greyBackgroundColor,
                          scaffoldBackgroundColor: appConstants.greyBackgroundColor,
                          highlightColor: Colors.transparent,
                          colorScheme: ColorScheme.fromSeed(
                            seedColor: Colors.transparent,
                            background: appConstants.greyBackgroundColor,
                          ),
                          useMaterial3: true,
                        ),
                        builder: (context, child) {
                          return LoadingScreen(screen: child!);
                        },
                        initialRoute: RouteList.initial,
                        onGenerateRoute: (RouteSettings settings) {
                          if (kDebugMode) {
                            log(settings.name.toString());
                          }
                          final routes = Routes.getRoutes(settings);
                          final WidgetBuilder? builder = routes[settings.name];
                          return FadePageRouteBuilder(builder: builder!, settings: settings);
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
