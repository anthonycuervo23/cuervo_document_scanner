// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:io';
import 'package:captain_score/features/home_screen/presentation/cubit/home_screen_cubit/home_page_cubit_cubit.dart';
import 'package:captain_score/shared/common_widgets/appsflyer_constants.dart';
import 'package:captain_score/shared/cubit/ads/ads_setting/ads_setting_cubit.dart';
import 'package:captain_score/shared/cubit/analytics/deep_link/deep_link_cubit.dart';
import 'package:captain_score/shared/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:captain_score/shared/cubit/general_setting/general_setting_cubit.dart';
import 'package:captain_score/shared/cubit/language/language_cubit.dart';
import 'package:captain_score/shared/cubit/loading/loading_cubit.dart';
import 'package:captain_score/shared/cubit/notification/selected_notification/selected_notification_cubit.dart';
import 'package:captain_score/shared/cubit/theme/theme_cubit.dart';
import 'package:captain_score/shared/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:captain_score/shared/presentation/loading/loading_screen.dart';
import 'package:captain_score/shared/utils/ads_configuration.dart';
import 'package:captain_score/shared/utils/app_functions.dart';
import 'package:captain_score/shared/utils/app_localizations.dart';
import 'package:captain_score/shared/utils/custom_snackbar.dart';
import 'package:captain_score/shared/utils/deep_link_data.dart';
import 'package:captain_score/shared/utils/fade_page_route_builder.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:captain_score/shared/utils/my_route_observor.dart';
import 'package:captain_score/shared/utils/new_notification_service.dart';
import 'package:captain_score/shared/utils/routes.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:catcher_2/utils/catcher_2_error_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:captain_score/analytics_service.dart';
import 'package:captain_score/common/constants/hive_constants.dart';
import 'package:captain_score/common/constants/languages.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/common/constants/snackbar_type.dart';
import 'package:captain_score/common/constants/theme.dart';
import 'package:captain_score/di/get_it.dart';
import 'package:captain_score/shared/themes/theme_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

AppOpenAd? myAppOpenAd;

enum DeviceType { phone, tablet }

Future<void> loadAppOpenAd() async {
  await AppOpenAd.load(
    adUnitId: AdsConfiguration.getAppOpenId!,
    request: const AdRequest(),
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (ad) {
        shouldShowAppOpenAdd = false;
        myAppOpenAd = ad;
        myAppOpenAd!.show();
      },
      onAdFailedToLoad: (error) {},
    ),
    orientation: AppOpenAd.orientationPortrait,
  );
}

class CaptainScoreApp extends StatefulWidget {
  const CaptainScoreApp({super.key});

  @override
  State<CaptainScoreApp> createState() => _CaptainScoreAppState();
}

class _CaptainScoreAppState extends State<CaptainScoreApp> with WidgetsBindingObserver {
  late LanguageCubit _languageCubit;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;
  late BottomNavigationCubit _bottomNavigationCubit;
  late HomePageCubit _homePageCubit;
  late ToggleCubit _toggleCubit;

  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    // _languageCubit.loadPreferredLanguage();
    _loadingCubit = getItInstance<LoadingCubit>();
    _themeCubit = getItInstance<ThemeCubit>();
    _bottomNavigationCubit = getItInstance<BottomNavigationCubit>();
    _themeCubit.loadPreferredTheme();
    _homePageCubit = getItInstance<HomePageCubit>();
    generalSettingCubit = getItInstance<GeneralSettingCubit>();
    _toggleCubit = getItInstance<ToggleCubit>();
    // _generalSettingCubit.loadGeneralSettingData();

    // _paymentCubit.loadPaymentKeys();
    _configureSelectNotificationSubject();

    adsCubit = getItInstance<AdsSettingCubit>();
    // WidgetsBinding.instance.addObserver(this);
    updateTimeOnInterval();
    if (Platform.isAndroid) {
      // unawaited(checkAppVersion());
    }

    loadAdsSettingAndBannerAd();

    isNewTemplateLoaded = true;

    routingIsolateReceivePort.listen((message) {}).onData((data) {
      int totalDuration = data.first;
      String routeName = data.last;

      userAppActivity.addAll({routeName: totalDuration});
      dmtBox.put(HiveConstants.USER_APP_ACTIVITY, userAppActivity);

      // adsCubit.reloadAdsCubit();
      // if (kDebugMode) {
      //   print(jsonEncode(userAppActivity).toString());
      // }
    });

    postIsolateReceivePort.listen((message) {}).onData((data) {
      int totalDuration = data.first;
      String postName = data.last;

      imageImpression.addAll({postName: totalDuration});
      dmtBox.put(HiveConstants.IMAGE_IMPRESSION, imageImpression);
    });
  }

  Future<void> loadAdsSettingAndBannerAd() async {
    shouldShowAppOpenAdd = true;
    isNewTemplateLoaded = true;

    if (Platform.isAndroid) {
      listenConnection();
    }
  }

  void listenConnection() {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (kDebugMode) {
          print("Connection$result");
        }
        connectivityResult = result;
        if (result == ConnectivityResult.wifi) {
          if (Platform.isAndroid) {
            _tryConnection();
          } else {
            connnectionController?.sink.add(InternetStatus.connected);
            showConnectionMessage = true;
            CustomSnackbar.show(
              snackbarType: SnackbarType.SUCCESS,
              message: "Back Online!!!",
              bgColor: Colors.green[800],
            );
          }
        } else if (result == ConnectivityResult.mobile) {
          if (Platform.isAndroid) {
            _tryConnection();
          } else {
            connnectionController?.sink.add(InternetStatus.connected);
            showConnectionMessage = true;
            CustomSnackbar.show(
              snackbarType: SnackbarType.SUCCESS,
              message: "Back Online!!!",
              bgColor: Colors.green[800],
            );
          }
        } else {
          isConnectionSuccessful = false;
          if (showConnectionMessage) {
            connnectionController?.sink.add(InternetStatus.notConnected);
            CustomSnackbar.show(
              snackbarType: SnackbarType.ERROR,
              message: "No Connection",
              duration: const Duration(hours: 1),
            );
          } else {
            showConnectionMessage = true;
          }
        }
      },
    );
  }

  Future<void> _tryConnection() async {
    try {
      try {
        final ping = Ping('google.com', count: 2);
        ping.stream.listen((event) {
          if (event.summary?.received == 2) {
            isConnectionSuccessful = true;
            if (showConnectionMessage) {
              connnectionController?.sink.add(InternetStatus.connected);
              CustomSnackbar.show(
                snackbarType: SnackbarType.SUCCESS,
                message: "Back Online!!!",
                bgColor: Colors.green[800],
              );
              ping.stop();
            } else {
              showConnectionMessage = true;
            }
          }
        });
      } on SocketException {
        isConnectionSuccessful = false;
        if (showConnectionMessage) {
          connnectionController?.sink.add(InternetStatus.notConnected);
          CustomSnackbar.show(
            snackbarType: SnackbarType.ERROR,
            message: "No Connection",
            duration: const Duration(hours: 3),
          );
        } else {
          showConnectionMessage = true;
        }
      }
    } on Exception {}
  }

  // AppUpdateInfo? _updateInfo;

  // Future<void> checkAppVersion() async {
  //   checkAppStoreUpdate();
  // }

  // Future<void> checkAppStoreUpdate() async {
  //   AppCheckerResult storeData = await AppVersionChecker().checkUpdate();
  //   appStoreData = storeData;
  //   InAppUpdate.checkForUpdate().then((info) async {
  //     appUpdateInfo = info;
  //     _updateInfo = info;
  //     if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
  //       if (storeData.shouldForceUpdate) {
  //         if (_updateInfo?.immediateUpdateAllowed ?? false) {
  //           await InAppUpdate.performImmediateUpdate().catchError((e) => {});
  //         } else if (_updateInfo?.flexibleUpdateAllowed ?? false) {
  //           await InAppUpdate.startFlexibleUpdate().catchError((e) => {});
  //         }
  //       } else if (storeData.shouldUpdate) {
  //         if (_updateInfo?.flexibleUpdateAllowed ?? false) {
  //           await InAppUpdate.startFlexibleUpdate().catchError((e) => {});
  //         }
  //       }
  //     }
  //   }).catchError((e) {
  //     if (kDebugMode) {
  //       print("Error$e");
  //     }
  //   });
  // }

  void updateTimeOnInterval() {
    Timer.periodic(
      const Duration(seconds: 30),
      (Timer timer) async {
        appCloseTime = DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now()).toString();
        await dmtBox.put(HiveConstants.APP_CLOSE_TIME, appCloseTime);
      },
    );
  }

  BuildContext? rootContext;
  @override
  void dispose() {
    AppFunctions().cleanUpMemory();
    // WidgetsBinding.instance.removeObserver(this);
    _languageCubit.close();
    _loadingCubit.close();
    _themeCubit.close();
    _bottomNavigationCubit.close();
    _homePageCubit.close();
    generalSettingCubit.close();
    _toggleCubit.close();

    adsCubit.bACubit.timer?.cancel();
    adsCubit.close();
    routeIsolate?.kill();

    badgeCounterCubit?.close();
    super.dispose();
  }

  void _configureSelectNotificationSubject() {
    try {
      Future.delayed(
        Duration.zero,
        () {
          if (rootContext != null) {
            listenNotificationStream();

            listenDeepLinkStream();
          }
        },
      );
    } on Exception {
      Future.delayed(
        Duration.zero,
        () async {
          if (rootContext != null) {
            Navigator.of(rootContext!).pushReplacementNamed(RouteList.app_home);
          }
        },
      );
    }
  }

  void listenDeepLinkStream() {
    deepLinkCubit.stream.listen(
      (event) async {
        if (event is DeepLinkLoadedState) {
          if (kDebugMode) {
            print("event.deepLinkData ${event.deepLinkData}");
          }
          if (event.deepLinkData == null) {
            return;
          } else {
            Catcher2.navigatorKey?.currentState?.popUntil((route) => route.settings.name == RouteList.app_home);
            if (event.deepLinkData != null) {
              await handleDeepLink(deepLink: event.deepLinkData!, rootContext: rootContext);
            }
          }
        }
      },
    );
  }

  String whatsapp =
      generalSettingEntity?.supportWhatsappMobileNo.toString().replaceAll(" ", "").toString().trim() ?? "+919106902181";

  Future<void> launchWhatsapp() async {
    if (!whatsapp.startsWith('+91')) {
      whatsapp = '+91$whatsapp';
    }
    String url = '';
    if (Platform.isIOS) {
      url = "whatsapp://wa.me/$whatsapp/?text=I am interested, please explain how you can help us grow business?";
    } else {
      url = "whatsapp://send?phone=$whatsapp&text=I am interested, please explain how you can help us grow business?";
    }

    var encoded = Uri.encodeFull(url);
    if (await canLaunchUrlString(encoded)) {
      await launchUrlString(encoded);
    } else {
      CustomSnackbar.show(snackbarType: SnackbarType.ERROR, message: "Unable to open whatsapp.");
    }
  }

  Future<void> handleDeepLink({required DeepLinkData deepLink, BuildContext? rootContext}) async {
    if (deepLink.deepLinkPath != null || deepLink.campaign != null || deepLink.campaignId != null) {
      // Total Page Navigation Handles

      String deepLinkPath = deepLink.deepLinkPath?.toString() ?? "";

      if (deepLinkPath.toString().trim().isEmpty) {
        deepLinkPath = deepLink.deepLinkValue?.toString() ?? "";
      }
      if (deepLinkPath.toString().trim().isEmpty) {
        deepLinkPath = deepLink.campaign?.toString() ?? "";
      }
      if (deepLinkPath.toString().trim().isEmpty) {
        deepLinkPath = deepLink.campaignId?.toString() ?? "";
      }

      //  ?? deepLink.campaign ?? deepLink.campaignId ?? "";

      switch (deepLinkPath) {
        case AppsflyerConstants.afSinglePostPath:
          break;
        case AppsflyerConstants.afWpEnquiryPath:
          launchWhatsapp();
          break;

        case AppsflyerConstants.afCustomTemplatePath:
          BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(0);
          break;

        case AppsflyerConstants.afCustomVideoPath:
          break;
        case AppsflyerConstants.afImageToVideoPath:
          break;

        case AppsflyerConstants.afFaqsPath:
          break;
        case AppsflyerConstants.afVideoTemplatePath:
          break;
        default:
          break;
      }
    }
  }

  void listenNotificationStream() {
    notificationCubit.stream.listen(
      (event) async {
        if (event is SelectedNotificationLoadedState) {
          AppFunctions().decrementNotificationCount();
          if (event.payloadModel != null && event.payloadModel!.type == 'offer') {}
        }
      },
    );
  }

  DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(View.of(context));
    return data.size.shortestSide < 550 ? DeviceType.phone : DeviceType.tablet;
  }

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
        BlocProvider<HomePageCubit>.value(value: _homePageCubit),
        BlocProvider<SelectedNotificationCubit>.value(value: notificationCubit),
        BlocProvider<AdsSettingCubit>.value(value: adsCubit),
        BlocProvider<ToggleCubit>.value(value: _toggleCubit),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        bloc: _themeCubit,
        builder: (context, theme) {
          if (Platform.isAndroid) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: theme == Themes.dark ? Colors.transparent : Colors.transparent,
                statusBarIconBrightness: theme == Themes.dark ? Brightness.light : Brightness.light,
              ),
            );
          } else if (Platform.isIOS) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: theme == Themes.dark ? Colors.transparent : Colors.transparent,
              statusBarIconBrightness: theme == Themes.dark ? Brightness.light : Brightness.dark,
              statusBarBrightness: theme == Themes.dark ? Brightness.dark : Brightness.dark,
            ));
          }
          // var pixelRatio = View.of(context).devicePixelRatio;
          // var logicalScreenSize = View.of(context).physicalSize / pixelRatio;
          // var logicalWidth = logicalScreenSize.width;
          return Material(
            child: BlocBuilder<LanguageCubit, LanguageState>(
              bloc: _languageCubit,
              builder: (context, state) {
                if (state is LanguageLoaded) {
                  return ScreenUtilInit(
                    useInheritedMediaQuery: true,
                    designSize: getDeviceType() == DeviceType.tablet ? const Size(834, 1194) : const Size(414, 896),
                    // ScreenUtil().screenWidth > 600 ? const Size(834, 1194) :
                    // minTextAdapt: true,
                    rebuildFactor: (old, data) => RebuildFactors.orientation(old, data),
                    splitScreenMode: true,
                    builder: (BuildContext context, Widget? widget) => MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: "CaptainScoreApp",

                      scaffoldMessengerKey: snackbarKey,

                      // navigatorKey: navigatorKey,
                      navigatorKey: Catcher2.navigatorKey,
                      navigatorObservers: <NavigatorObserver>[
                        AnalyticsService.getAnalyticsObserver(),
                        MyRouteObserver(),
                      ],
                      theme: ThemeData(
                        fontFamily: 'Poppins',
                        useMaterial3: false,
                        primaryColor: theme == Themes.dark ? appConstants.primary1Color : Colors.white,
                        scaffoldBackgroundColor: theme == Themes.dark ? appConstants.primary1Color : Colors.white,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        textTheme: theme == Themes.dark ? ThemeText.getTextTheme() : ThemeText.getLightTextTheme(),
                        appBarTheme: const AppBarTheme(elevation: 8),
                        cardTheme: CardTheme(
                          color: theme == Themes.dark ? Colors.white : appConstants.primary1Color,
                          surfaceTintColor: Colors.white,
                        ),
                        textSelectionTheme: TextSelectionThemeData(cursorColor: appConstants.primary1Color),
                        // popupMenuTheme: PopupMenuThemeData(
                        //   color: Colors.white,
                        //   textStyle: Theme.of(context).textTheme.body1MediumHeading.copyWith(fontSize: 18.sp),
                        // ),
                        unselectedWidgetColor: appConstants.primary3Color,
                        canvasColor: Colors.white,
                        inputDecorationTheme: InputDecorationTheme(
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.6),
                            fontSize: 20.sp,
                            fontFamily: 'Calibri',
                          ),

                          //   // focusedBorder: OutlineInputBorder(
                          //   //   borderSide: BorderSide(color: theme == Themes.dark ? Colors.white : Colors.white),
                          //   //   borderRadius: BorderRadius.circular(6.r),
                          //   // ),
                          //   // enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        colorScheme: ColorScheme.fromSwatch().copyWith(
                          secondary: theme == Themes.dark ? appConstants.primary1Color : Colors.white,
                          brightness: theme == Themes.dark ? Brightness.light : Brightness.dark,
                          surfaceTint: Colors.white,
                        ),
                      ),
                      themeMode: ThemeMode.light,
                      locale: state.locale,
                      supportedLocales: languages.map((e) => Locale(e.shortCode.toString())).toList(),
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      builder: (BuildContext context, Widget? child) {
                        ErrorWidget.builder = (details) => Material(
                              child: Catcher2ErrorWidget(
                                details: details,
                                showStacktrace: kDebugMode ? true : false,
                                title: kDebugMode ? "An application error has occurred" : "Something went wrong",
                                description: kDebugMode
                                    ? "There was unexpected situation in application. Application has been ' 'able to recover from error state,Please send screenshot to support team"
                                    : "",
                                maxWidthForSmallMode: kDebugMode ? 150 : 0,
                              ),
                            );

                        return LoadingScreen(screen: child ?? Container());
                      },
                      initialRoute: RouteList.initial,
                      onGenerateRoute: (RouteSettings settings) {
                        routeArguments = settings.arguments;

                        if (kDebugMode) {
                          print("Routes${settings.name}");
                        }

                        final routes = Routes.getRoutes(settings);
                        final WidgetBuilder? builder = routes[settings.name];
                        return FadePageRouteBuilder(
                          builder: builder!,
                          settings: settings,
                        );
                      },
                    ),
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
