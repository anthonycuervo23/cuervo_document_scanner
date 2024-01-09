import 'package:bakery_shop_flutter/core/api_client.dart';
import 'package:bakery_shop_flutter/features/address/data/datasources/address_data_source.dart';
import 'package:bakery_shop_flutter/features/address/data/repositories/address_remote_repository_impl.dart';
import 'package:bakery_shop_flutter/features/address/domain/repositories/address_remote_repository.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/add_address_detail.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/delete_address_detail.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/manage_address_usecase.dart';
import 'package:bakery_shop_flutter/features/address/domain/usecases/set_default_address.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/authentication/data/repositories/authentication_remote_repositories_impl.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/repositories/authentication_remote_repositories.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/get_generate_otp_data.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/get_referral_code_data.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/get_verify_otp_data.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/my_profile/my_profile_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/otp_verification/otp_verification_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/referral_redeem/referral_redeem_cubit.dart';
import 'package:bakery_shop_flutter/features/chat_support/presentation/cubit/chat_suppport_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/address_search_cubit/address_search_cubit.dart';
import 'package:bakery_shop_flutter/features/combo_offers/data/datasources/combo_offer_data_source.dart';
import 'package:bakery_shop_flutter/features/combo_offers/data/repositories/combo_offer_remote_repository_impl.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/repositories/product_remote_repository.dart';
import 'package:bakery_shop_flutter/features/combo_offers/domain/usecases/combo_offer_usecase.dart';
import 'package:bakery_shop_flutter/features/combo_offers/presentation/cubit/combo_offer_cubit.dart';
import 'package:bakery_shop_flutter/features/home/data/datasources/home_data_sources.dart';
import 'package:bakery_shop_flutter/features/home/data/repositories/home_data_remort_repositories_impl.dart';
import 'package:bakery_shop_flutter/features/home/domain/repositorie/home_data_remort_repositories.dart';
import 'package:bakery_shop_flutter/features/home/domain/usecases/get_home_data_use_cases.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_flutter/features/my_cart/data/datasources/my_cart_data_sources.dart';
import 'package:bakery_shop_flutter/features/my_cart/data/repositories/my_cart_repositories_impl.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/repositories/my_cart_repositories.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/add_product_to_cart.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/delete_product.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/get_my_cart_product_use_cases.dart';
import 'package:bakery_shop_flutter/features/my_cart/domain/usecases/update_product_quanity.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:bakery_shop_flutter/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:bakery_shop_flutter/features/offers/data/datasources/offer_data_sources.dart';
import 'package:bakery_shop_flutter/features/offers/data/repositories/offer_remot_repositories_impl.dart';
import 'package:bakery_shop_flutter/features/offers/domain/repositories/offer_remot_repositories.dart';
import 'package:bakery_shop_flutter/features/offers/domain/usecases/apply_coupons.dart';
import 'package:bakery_shop_flutter/features/offers/domain/usecases/get_coupons.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:bakery_shop_flutter/features/orders_history/presentation/order_history_cubit/orders_history_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/search/search_cubit.dart';
import 'package:bakery_shop_flutter/features/products/data/datasources/product_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/products/data/repositories/product_remote_repositories_impl.dart';
import 'package:bakery_shop_flutter/features/products/domain/repositories/product_remote_repository.dart';
import 'package:bakery_shop_flutter/features/products/domain/usecases/product_category_data.dart';
import 'package:bakery_shop_flutter/features/products/domain/usecases/product_data_usecases.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/category/product_category_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/update_data/update_data_cubit.dart';
import 'package:bakery_shop_flutter/features/rate_us/presentation/cubit/feedback_cubit.dart';
import 'package:bakery_shop_flutter/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/cubit/review_and_feedback_cubit.dart';
import 'package:bakery_shop_flutter/features/products/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/data/data_sources/language_local_data_source.dart';
import 'package:bakery_shop_flutter/features/settings/data/data_sources/setting_data_sources.dart';
import 'package:bakery_shop_flutter/features/settings/data/data_sources/theme_local_data_source.dart';
import 'package:bakery_shop_flutter/features/settings/data/repositories/setting_repository_impl.dart';
import 'package:bakery_shop_flutter/features/settings/domain/repositories/setting_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/get_preferred_language.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/get_preferred_theme.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/update_language.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/update_theme.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/app_language/app_language_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/language/language_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/data/repositories/app_repository_impl.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/order_time_slot/order_time_slot_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/policy_cubit/policy_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/reminder_date/reminder_date_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/setting_cubit/setting_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/domain/repositories/app_repository.dart';
import 'package:bakery_shop_flutter/features/settings/domain/usecases/get_policy_data.dart';
import 'package:bakery_shop_flutter/features/shared/data/data_sources/user_remote_data_source.dart';
import 'package:bakery_shop_flutter/features/shared/data/repositories/user_repository_impl.dart';
import 'package:bakery_shop_flutter/features/shared/domain/repositories/user_remote_repostiory.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/delete_family_detail.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/get_policy_data.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/get_user_details.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/update_login_details.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/update_login_otp.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/usecase/update_user_detail.dart';
import 'package:bakery_shop_flutter/features/shared/domain/usecases/upload_file.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/account_info/account_info_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/help_support/help_support_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/my_favorite/my_favorite_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/theme/theme_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/user_data_load/user_data_load_cubit.dart';
import 'package:bakery_shop_flutter/utils/analytics_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getItInstance = GetIt.I;

Future init() async {
  // getItInstance.registerLazySingleton<Dio>(() => Dio());
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // Analytics Property
  // getItInstance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  //Data source Dependency
  getItInstance.registerLazySingleton<SettingDataSource>(() => SettingDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(client: getItInstance()));
  getItInstance
      .registerLazySingleton<AuuthenticationRemoteDataSource>(() => GenerateDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<ProductRemoteDataSource>(() => ProductDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<ComboOfferRemoteDataSource>(() => ComboOfferDataSourceImpl(
        client: getItInstance(),
      ));
  getItInstance.registerLazySingleton<AddressRemoteDataSource>(() => AddressDataSourceImpl(
        client: getItInstance(),
      ));
  getItInstance.registerLazySingleton<MyCartDataSources>(() => MyCartDataSourcesImpl(
        client: getItInstance(),
      ));
  getItInstance.registerLazySingleton<OfferDataSources>(() => OfferDataSourcesImpl(
        client: getItInstance(),
      ));
  getItInstance.registerLazySingleton<HomeDataSources>(() => HomeDataSourcesImpl(
        client: getItInstance(),
      ));

  //Data Repository Dependency

  getItInstance
      .registerLazySingleton<SettingRemoteRepository>(() => SettingRepositoryImpl(settingDataSource: getItInstance()));
  getItInstance.registerLazySingleton<UserRemoteRepository>(() => UserRepositoryImpl(userDataSource: getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationRemoteRepository>(
      () => AuthenticationRemoteRepositoryImpl(generateDataSource: getItInstance()));
  getItInstance.registerLazySingleton<ProductRemoteRepository>(
      () => ProductRemoteRepositoriesImpl(productRemoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<ComboOfferRemoteRepository>(() => ComboOfferRemoteRepositoriesImpl(
        comboOfferRemoteDataSource: getItInstance(),
      ));
  getItInstance.registerLazySingleton<MyCartRepository>(() => MyCartRepositoryImpl(
        myCartDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<OfferRemotRepositories>(() => OfferRemotRepositoriesImpl(
        offerDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<AddressRemoteRepository>(() => AddressRemoteRepositoriesImpl(
        addressRemoteDataSource: getItInstance(),
      ));
  getItInstance.registerLazySingleton<HomeDataRemortRepositories>(() => HomeDataRemortRepositoriesImpl(
        homeDataSources: getItInstance(),
      ));

  //Usecase Dependency
  getItInstance.registerLazySingleton<GetPolicyData>(() => GetPolicyData(settingRemoteRepository: getItInstance()));
  getItInstance
      .registerLazySingleton<GetAccountInfoData>(() => GetAccountInfoData(userRemoteRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetGenerateOtpData>(
      () => GetGenerateOtpData(authenticationRemoteRepository: getItInstance()));
  getItInstance
      .registerLazySingleton<GetVerifyOtpData>(() => GetVerifyOtpData(authenticationRemoteRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetReferralCodeData>(
      () => GetReferralCodeData(authenticationRemoteRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetUserData>(() => GetUserData(userRemoteRepository: getItInstance()));
  getItInstance.registerLazySingleton<UploadFile>(() => UploadFile(userRemoteRepository: getItInstance()));
  getItInstance.registerLazySingleton<UpdateUserDetail>(() => UpdateUserDetail(userRemoteRepository: getItInstance()));
  getItInstance
      .registerLazySingleton<DeleteFamilyDetail>(() => DeleteFamilyDetail(userRemoteRepository: getItInstance()));
  getItInstance
      .registerLazySingleton<UpdateLoginDetails>(() => UpdateLoginDetails(userRemoteRepository: getItInstance()));
  getItInstance.registerLazySingleton<UpdateLoginOtp>(() => UpdateLoginOtp(userRemoteRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetUserDataCubit>(
      () => GetUserDataCubit(getUserData: getItInstance(), loadingCubit: getItInstance()));
  getItInstance.registerLazySingleton<GetProductCategoryData>(
      () => GetProductCategoryData(productRemoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<GetProductData>(() => GetProductData(productRemoteDataSource: getItInstance()));
  getItInstance
      .registerLazySingleton<GetComboOfferData>(() => GetComboOfferData(comboOfferDataSource: getItInstance()));
  getItInstance
      .registerLazySingleton<GetManageAddressData>(() => GetManageAddressData(addressDataSource: getItInstance()));
  getItInstance.registerLazySingleton<DeleteAddress>(() => DeleteAddress(addressDataSource: getItInstance()));
  getItInstance.registerLazySingleton<AddAddressDetails>(() => AddAddressDetails(addressDataSource: getItInstance()));
  getItInstance.registerLazySingleton<SetDefaultAddressDetails>(
      () => SetDefaultAddressDetails(addressDataSource: getItInstance()));
  getItInstance.registerLazySingleton<GetMyCartProductUseCases>(() => GetMyCartProductUseCases(
        myCartDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<AddProductToCart>(() => AddProductToCart(
        myCartDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<UpdateProductQuntity>(() => UpdateProductQuntity(
        myCartDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<DeleteProductUseCase>(() => DeleteProductUseCase(
        myCartDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<GetCouponsData>(() => GetCouponsData(
        offerDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<ApplyCouponsData>(() => ApplyCouponsData(
        offerDataSources: getItInstance(),
      ));
  getItInstance.registerLazySingleton<GetHomeDatauseCases>(() => GetHomeDatauseCases(
        homeDataSources: getItInstance(),
      ));
  //Bloc Dependency
  // getItInstance.registerFactory(() => SettingPageBloc(loadingCubit: getItInstance()));

  //Cubit Dependency
  getItInstance.registerLazySingleton<BottomNavigationCubit>(() => BottomNavigationCubit());
  getItInstance.registerFactory<OfferCubit>(() => OfferCubit(
        getCouponsData: getItInstance(),
        loadingCubit: getItInstance(),
        applyCouponsData: getItInstance(),
      ));
  getItInstance.registerFactory<OrderHistoryCubit>(() => OrderHistoryCubit());
  getItInstance.registerFactory<SearchCubit>(() => SearchCubit());
  getItInstance.registerFactory<ToggleCubit>(() => ToggleCubit());
  getItInstance.registerFactory<SettingCubit>(() => SettingCubit(promotionalActivationCubit: getItInstance()));
  getItInstance.registerFactory<AppLanguageCubit>(() => AppLanguageCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<ReminderDateCubit>(() => ReminderDateCubit());
  getItInstance.registerFactory<AuthenticationCubit>(
      () => AuthenticationCubit(loadingCubit: getItInstance(), getGenerateOtp: getItInstance()));
  getItInstance.registerFactory<EditProfileCubit>(() => EditProfileCubit(
        relationListShowCubit: getItInstance(),
        loadingCubit: getItInstance(),
        uploadFile: getItInstance(),
        updateUserDetail: getItInstance(),
        deleteFamilyDetail: getItInstance(),
        updateLoginDetails: getItInstance(),
        userDataLoadCubit: getItInstance(),
      ));
  getItInstance.registerFactory<ComboOfferCubit>(() => ComboOfferCubit(
        getComboOfferData: getItInstance(),
        counterCubit: getItInstance(),
        loadingCubit: getItInstance(),
        getMyCartProductUseCases: getItInstance(),
      ));
  getItInstance.registerFactory<HomeCubit>(() => HomeCubit(
        loadingCubit: getItInstance(),
        getHomeDatauseCases: getItInstance(),
        productListCubit: getItInstance(),
        counterCubit: getItInstance(),
      ));
  getItInstance.registerFactory<ChatSuppportCubit>(
      () => ChatSuppportCubit(loadingCubit: getItInstance(), sendCubit: getItInstance()));
  getItInstance.registerFactory<HelpAndSupportCubit>(() => HelpAndSupportCubit());
  getItInstance.registerFactory<OrderTimeSlotCubit>(() => OrderTimeSlotCubit());
  getItInstance.registerFactory(() => ReviewAndFeedbackCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<ProductListCubit>(() => ProductListCubit(
        counterCubit: getItInstance(),
        quantityChangeCubit: getItInstance(),
        loadingCubit: getItInstance(),
        getProductData: getItInstance(),
        updateDataCubit: getItInstance(),
      ));
  getItInstance.registerFactory<LocationPickerCubit>(() => LocationPickerCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<AddressSearchCubit>(() => AddressSearchCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<AddAddressCubit>(() => AddAddressCubit(
      counterCubit: getItInstance(),
      locationPickerCubit: getItInstance(),
      loadingCubit: getItInstance(),
      deleteAddressDetail: getItInstance(),
      addAddressDetails: getItInstance(),
      setDefaultAddressDetails: getItInstance(),
      getManageAddressData: getItInstance(),
      getUserDataCubit: getItInstance()));
  getItInstance
      .registerFactory<FeedbackCubit>(() => FeedbackCubit(loadingCubit: getItInstance(), toggleCubit: getItInstance()));
  getItInstance.registerFactory<MyFavoriteCubit>(() => MyFavoriteCubit());
  getItInstance.registerFactory<CounterCubit>(() => CounterCubit());
  getItInstance
      .registerFactory<PolicyCubit>(() => PolicyCubit(getPolicyData: getItInstance(), loadingCubit: getItInstance()));
  getItInstance.registerFactory<AccountInfoCubit>(
      () => AccountInfoCubit(getAccountInfoData: getItInstance(), loadingCubit: getItInstance()));
  getItInstance.registerFactory<OtpVerificationCubit>(() => OtpVerificationCubit(
      getVerifyOtpData: getItInstance(),
      loadingCubit: getItInstance(),
      getGenerateOtp: getItInstance(),
      updateLoginOtp: getItInstance(),
      userDataLoadCubit: getItInstance()));
  getItInstance.registerFactory<ReferralRedeemCubit>(
      () => ReferralRedeemCubit(loadingCubit: getItInstance(), getReferralCodeData: getItInstance()));
  getItInstance.registerFactory<MyProfileCubit>(
      () => MyProfileCubit(getUserData: getItInstance(), loadingCubit: getItInstance()));
  getItInstance.registerFactory<NotificationCubit>(() => NotificationCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<ProductCategoryCubit>(
      () => ProductCategoryCubit(loadingCubit: getItInstance(), getProductCategoryData: getItInstance()));
  getItInstance.registerFactory<CartCubit>(() => CartCubit(
        loadingCubit: getItInstance(),
        getMyCartProductUseCases: getItInstance(),
        addProductToCart: getItInstance(),
        updateProductQuntity: getItInstance(),
        deleteProductUseCase: getItInstance(),
        applyCouponsData: getItInstance(),
      ));
  getItInstance.registerFactory<UpdateDataCubit>(() => UpdateDataCubit());

  //Theme Dependency
  getItInstance.registerLazySingleton<GetPreferredTheme>(() => GetPreferredTheme(appRepository: getItInstance()));
  getItInstance.registerLazySingleton<UpdateTheme>(() => UpdateTheme(appRepository: getItInstance()));
  getItInstance.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(languageLocalDataSource: getItInstance(), themeLocalDataSource: getItInstance()));
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSourceImpl());
  getItInstance.registerLazySingleton<GetPreferredLanguage>(() => GetPreferredLanguage(appRepository: getItInstance()));
  getItInstance.registerLazySingleton<UpdateLanguage>(() => UpdateLanguage(appRepository: getItInstance()));
  getItInstance.registerSingleton<LanguageCubit>(
      LanguageCubit(updateLanguage: getItInstance(), getPreferredLanguage: getItInstance()));
  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
  getItInstance
      .registerSingleton<ThemeCubit>(ThemeCubit(getPreferredTheme: getItInstance(), updateTheme: getItInstance()));
  getItInstance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}
