import 'dart:io';

import 'package:bakery_shop_admin_flutter/app_localizations.dart';
import 'package:bakery_shop_admin_flutter/common/constants/languages.dart';
import 'package:bakery_shop_admin_flutter/common/constants/theme.dart';
import 'package:bakery_shop_admin_flutter/data/remote/network_api_service.dart';
import 'package:bakery_shop_admin_flutter/data/service/dio_connectivity_retrier.dart';
import 'package:bakery_shop_admin_flutter/data/service/logging_interceptor.dart';
import 'package:bakery_shop_admin_flutter/data/service/retrier_interceptor.dart';
import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/productsCubit/products_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/language/language_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/theme/theme_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/view/loading/loading_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/network_connection/network_connection.dart';
import 'package:bakery_shop_admin_flutter/routing/fade_page_route_builder.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:bakery_shop_admin_flutter/routing/router.dart';
import 'package:bakery_shop_admin_flutter/utils/analytics_service.dart';
import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';
import 'package:bakery_shop_admin_flutter/utils/my_route_observor.dart';
import 'package:catcher/core/catcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NewDeviceType { phone, tablet, web }

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
  late ProductsCubit _productsCubit;

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
    badgeCounterCubit = getItInstance<CounterCubit>();
    _productsCubit = getItInstance<ProductsCubit>();
    // _createNewOrderCubit.fetchingInitialData(cate: 'cake');
    initialization();
    logicOfIntroductionScreen();
    interceptorsDio();
    getPreviousNotificationCount();
    internetCheck();
  }

  @override
  void dispose() {
    _languageCubit.close();
    _themeCubit.close();
    _loadingCubit.close();
    _bottomNavigationCubit.close();
    _toggleCubit.close();
    badgeCounterCubit.close();
    _productsCubit.close();

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
    if (!kIsWeb && (!kIsWeb && Platform.isAndroid)) {
      listenConnection();
    }
  }

  // initialize dio and add interceptors
  void interceptorsDio() {
    var dio = NetworkApiService.client;
    dio.interceptors.addAll([
      LoggingInterceptor(),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    ]);
  }

  Size getDesignSize() {
    NewDeviceType deviceType = getDeviceType();
    Size size;
    switch (deviceType) {
      case NewDeviceType.web:
        size = const Size(1366, 768);
        break;
      case NewDeviceType.tablet:
        size = const Size(601, 962);
        break;
      case NewDeviceType.phone:
      default:
        size = const Size(360, 800);
    }

    // if (deviceType == NewDeviceType.web) {
    //   ScreenUtil.init(context, designSize: size);
    // }

    return size;
  }

  NewDeviceType getDeviceType() {
    final data = MediaQuery.of(context);
    if (data.size.shortestSide < 550) {
      newDeviceType = NewDeviceType.phone;
      return NewDeviceType.phone;
    } else if (data.size.width < 1100 && data.size.width >= 550) {
      newDeviceType = NewDeviceType.tablet;
      return NewDeviceType.tablet;
    } else {
      newDeviceType = NewDeviceType.web;
      return NewDeviceType.web;
    }
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
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
        BlocProvider<BottomNavigationCubit>.value(value: _bottomNavigationCubit),
        BlocProvider<ToggleCubit>.value(value: _toggleCubit),
        BlocProvider<CounterCubit>.value(value: badgeCounterCubit),
        BlocProvider<ProductsCubit>.value(value: _productsCubit),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        bloc: _themeCubit,
        builder: (context, theme) {
          if ((!kIsWeb && Platform.isAndroid)) {
            // SystemChrome.setSystemUIOverlayStyle(
            //   SystemUiOverlayStyle(
            //     statusBarColor: theme == Themes.dark ? appConstants.theme1Color : appConstants.theme1Color,
            //     statusBarIconBrightness: theme == Themes.dark ? Brightness.dark : Brightness.light,
            //   ),
            // );
          } else if ((!kIsWeb && Platform.isIOS)) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: theme == Themes.dark ? appConstants.theme1Color : appConstants.theme1Color,
              statusBarIconBrightness: theme == Themes.dark ? Brightness.light : Brightness.dark,
              statusBarBrightness: theme == Themes.dark ? Brightness.dark : Brightness.light,
            ));
          }
          // ScreenUtil.init(context, designSize: getDesignSize());
          return ScreenUtilInit(
            designSize: getDesignSize(),
            child: Material(
              child: BlocBuilder<LanguageCubit, LanguageState>(
                bloc: _languageCubit,
                builder: (context, state) {
                  if (state is LanguageLoadedState) {
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
                      navigatorKey: Catcher.navigatorKey,
                      navigatorObservers: <NavigatorObserver>[
                        AnalyticsService.getAnalyticsObserver(),
                        MyRouteObserver(),
                      ],
                      theme: ThemeData(
                        fontFamily: 'Noto Sans Display',
                        fontFamilyFallback: const ['Circular Std'],
                        textTheme: GoogleFonts.notoSansDisplayTextTheme(textTheme),
                        dialogBackgroundColor: appConstants.background,
                        scaffoldBackgroundColor: appConstants.background,
                        highlightColor: Colors.transparent,
                        useMaterial3: true,
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: Colors.transparent,
                          background: appConstants.background,
                        ),
                      ),
                      builder: (context, child) {
                        return LoadingScreen(screen: child!);
                      },
                      initialRoute: RouteList.initial,
                      // initialRoute: RouteList.app_home,
                      onGenerateRoute: (RouteSettings settings) {
                        final routes = Routes.getRoutes(settings);
                        final WidgetBuilder? builder = routes[settings.name];
                        if (kDebugMode) {
                          print(settings.name.toString());
                        }

                        return FadePageRouteBuilder(builder: builder!, settings: settings);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
