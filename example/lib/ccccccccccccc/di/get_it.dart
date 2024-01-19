import 'package:captain_score/features/home_screen/presentation/cubit/home_screen_cubit/home_page_cubit_cubit.dart';
import 'package:captain_score/features/shorts/presentation/cubit/shorts_cubit.dart';
import 'package:captain_score/shared/cubit/ads/ads_setting/ads_setting_cubit.dart';
import 'package:captain_score/shared/cubit/ads/banner_ads/banner_ads_cubit.dart';
import 'package:captain_score/shared/cubit/ads/interstitial_ads/interstitial_ads_cubit.dart';
import 'package:captain_score/shared/cubit/ads/native_ads/native_ads_cubit.dart';
import 'package:captain_score/shared/cubit/ads/reward_ads/reward_ads_cubit.dart';
import 'package:captain_score/shared/cubit/analytics/deep_link/deep_link_cubit.dart';
import 'package:captain_score/shared/cubit/app_language/app_language_cubit.dart';
import 'package:captain_score/shared/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:captain_score/shared/cubit/counter/counter_cubit.dart';
import 'package:captain_score/shared/cubit/general_setting/general_setting_cubit.dart';
import 'package:captain_score/shared/cubit/language/language_cubit.dart';
import 'package:captain_score/shared/cubit/loading/loading_cubit.dart';
import 'package:captain_score/shared/cubit/notification/selected_notification/selected_notification_cubit.dart';
import 'package:captain_score/shared/cubit/theme/theme_cubit.dart';
import 'package:captain_score/shared/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:captain_score/shared/services/shared_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:captain_score/common/core/api_client.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // Analytics Property
  // getItInstance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  //Data source Dependency
  getItInstance.registerLazySingleton<SharedDataSource>(() => SharedServicesDataSourceImpl(client: getItInstance()));

  //Bloc Dependency
  getItInstance.registerFactory(() => BannerAdsCubit());
  getItInstance.registerFactory(() => RewardAdsCubit());
  getItInstance.registerFactory(() => InterstitialAdsCubit());
  getItInstance.registerFactory(() => NativeAdsCubit());
  getItInstance.registerFactory(() => AdsSettingCubit(
        loadingCubit: getItInstance(),
        bACubit: getItInstance(),
        iACubit: getItInstance(),
        nACubit: getItInstance(),
        rACubit: getItInstance(),
      ));

  getItInstance.registerFactory(() => ToggleCubit());
  getItInstance.registerFactory(() => DeepLinkCubit());
  getItInstance.registerFactory(() => GeneralSettingCubit(
      loadingCubit: getItInstance(), sharedDataSource: getItInstance(), appLanguageCubit: getItInstance()));
  getItInstance.registerFactory<SelectedNotificationCubit>(() => SelectedNotificationCubit());
  getItInstance.registerFactory<HomePageCubit>(() => HomePageCubit());
  getItInstance.registerFactory<CounterCubit>(() => CounterCubit());
  getItInstance.registerFactory<ShortsCubit>(() => ShortsCubit());

  //Theme Dependency
  getItInstance.registerLazySingleton<BottomNavigationCubit>(() => BottomNavigationCubit());
  getItInstance.registerSingleton<LanguageCubit>(LanguageCubit(dataSource: getItInstance()));
  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(dataSource: getItInstance()));
  getItInstance.registerFactory(() => AppLanguageCubit(dataSource: getItInstance(), loadingCubit: getItInstance()));
}
