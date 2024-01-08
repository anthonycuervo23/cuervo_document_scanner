import 'package:bakery_shop_admin_flutter/core/api_client.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/address_search_cubit/address_search_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/app_layouts/presentation/cubit/app_layouts_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/data/datasources/login_remote_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/data/repositories/login_remote_repositories_impl.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/repositories/login_remote_repositories.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/domain/usecases/get_login_data.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/create_combo/create_combo_cubit.dart';
// import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/combo_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/orderCubit/order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/cubit/combo_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/paymentCubit/payment_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/productsCubit/products_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/cubit/timeSlotCubit/time_slot_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_cubit/customer_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/customer_view_cubit/customer_view_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/cubit/expenses_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/add_offers/add_offers_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/add_ads_cubit/add_details_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/offers/offers_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/order_cubit/order_history_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/presentation/cubit/sort_filter_for_order/sort_filter_for_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/add_inventory/add_inventory_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/cubit/product_inventory/product_inventory_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/add_new_product/add_product_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_detail/product_detail_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_list/product_list_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/profit_loss_sheet/presentation/cubit/profit_loss_sheet_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/cubit/purchase_list_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/data/data_source/reminder_remote_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/data/repositories/reminder_repositories_impl.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/repositories/reminder_repositories.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/usecases/get_anniversory_data.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/usecases/get_birthday_data.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/domain/usecases/get_events_data.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/return_order/presentation/cubit/add_return_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/role_management/presentation/cubit/role_management_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/cubit/routine_order_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/data/data_sources/language_local_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/settings/data/data_sources/theme_local_data_source.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/usecases/get_preferred_language.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/usecases/get_preferred_theme.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/usecases/update_language.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/usecases/update_theme.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/app_language/app_language_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/area_with_pincode/area_with_pincode_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/delivery_time_slot/delivery_time_slot_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/language/language_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/data/repositories/app_repository_impl.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/point_wise_color_btn/point_wise_color_btn_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/cubit/setting_cubit/setting_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/repositories/app_repository.dart';
import 'package:bakery_shop_admin_flutter/features/settings/domain/usecases/get_policy_data.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/drop_down/drop_down_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/theme/theme_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/cubit/suplier_details_cubit/supplierdetails_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/cubit/supplier_cubit/supplier_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/cubit/upcoming_events_cubit.dart';
import 'package:bakery_shop_admin_flutter/utils/analytics_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<http.Client>(() => http.Client());
  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  // Analytics Property
  // getItInstance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  //Data source Dependency
  getItInstance
      .registerLazySingleton<ReminderRemoteDataSource>(() => ReminderRemoteDataSourceimpl(client: getItInstance()));
  getItInstance.registerLazySingleton<LoginRemoteDataSource>(() => LoginDataSourceImpl(client: getItInstance()));

  //Data Repository Dependency
  getItInstance.registerLazySingleton<ReminderRepositories>(
      () => ReminderRepositoriesImpl(reminderRepositories: getItInstance()));
  getItInstance.registerLazySingleton<LoginRemoteRepository>(
      () => LoginRemoteRepositoryImpl(loginRemoteDataSource: getItInstance()));

  //Usecase Dependency
  getItInstance.registerLazySingleton<GetPolicyData>(() => GetPolicyData(settingRemoteRepository: getItInstance()));
  getItInstance
      .registerLazySingleton<GetBirthdayData>(() => GetBirthdayData(reminderRemoteDataSource: getItInstance()));
  getItInstance
      .registerLazySingleton<GetAnniversoryData>(() => GetAnniversoryData(reminderRemoteDataSource: getItInstance()));
  getItInstance.registerLazySingleton<GetEventsData>(() => GetEventsData(reminderRemoteDataSource: getItInstance()));
  getItInstance
      .registerLazySingleton<GetLoginData>(() => GetLoginData(authenticationRemoteRepository: getItInstance()));

  //Bloc Dependency
  // getItInstance.registerFactory(() => SettingPageBloc(loadingCubit: getItInstance()));

  //Cubit Dependency
  getItInstance.registerLazySingleton<BottomNavigationCubit>(() => BottomNavigationCubit());
  getItInstance.registerFactory<ToggleCubit>(() => ToggleCubit());
  getItInstance.registerFactory<SettingCubit>(() => SettingCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<AppLanguageCubit>(() => AppLanguageCubit(loadingCubit: getItInstance()));

  getItInstance.registerFactory<CounterCubit>(() => CounterCubit());

  getItInstance.registerFactory<CustomerCubit>(() => CustomerCubit(
        counterCubit: getItInstance(),
        sortFilterCubit: getItInstance(),
        searchFilterCubit: getItInstance(),
      ));
  getItInstance.registerFactory<CreateCustomerCubit>(() => CreateCustomerCubit(
        counterCubit: getItInstance(),
        toggleCubit: getItInstance(),
      ));
  // getItInstance.registerFactory<ComboCubit>(() => ComboCubit(appLiveStatus: getItInstance()));
  getItInstance.registerFactory<ProductsCubit>(() => ProductsCubit(
        orderCubit: getItInstance(),
        counterCubit: getItInstance(),
        timeSlotCubit: getItInstance(),
        paymentCubit: getItInstance(),
      ));
  getItInstance.registerFactory<TimeSLotCubit>(() => TimeSLotCubit());
  getItInstance.registerFactory<PaymentCubit>(() => PaymentCubit());
  getItInstance.registerFactory<OrderHistoryCubit>(() => OrderHistoryCubit(
        searchFilterCubit: getItInstance(),
        sortFilterForOrderCubit: getItInstance(),
        counterCubit: getItInstance(),
      ));
  getItInstance.registerFactory<SortFilterForOrderCubit>(() => SortFilterForOrderCubit());
  getItInstance.registerFactory<OrderCubit>(() => OrderCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<ProductListCubit>(() => ProductListCubit(
        productToggle: getItInstance(),
        searchFilterCubit: getItInstance(),
        counterCubit: getItInstance(),
        sortFilterForOrderCubit: getItInstance(),
      ));
  getItInstance.registerFactory<AddNewProductCubit>(
    () => AddNewProductCubit(
      appliveCubit: getItInstance(),
      customizetoggleCubit: getItInstance(),
      pinPriorityCubit: getItInstance(),
      showCatelogeCubit: getItInstance(),
      pickCatelogImagCubit: getItInstance(),
      pickUploadImagCubit: getItInstance(),
    ),
  );
  getItInstance.registerFactory<ReminderCubit>(() => ReminderCubit(
      getBirthdayData: getItInstance(),
      counterCubit: getItInstance(),
      searchFilterCubit: getItInstance(),
      getAnniversoryData: getItInstance(),
      getEventsData: getItInstance(),
      loadingCubit: getItInstance()));
  getItInstance.registerFactory<SortFilterCubit>(() => SortFilterCubit());
  getItInstance.registerFactory<SearchFilterCubit>(() => SearchFilterCubit());
  getItInstance.registerFactory<PickImageCubit>(() => PickImageCubit());
  getItInstance.registerFactory<DropDownCubit>(() => DropDownCubit());
  getItInstance.registerFactory<MarketingCubit>(
    () => MarketingCubit(
      addDeataisCubit: getItInstance(),
      searchFilterCubit: getItInstance(),
      loadingCubit: getItInstance(),
    ),
  );
  getItInstance.registerFactory<ComboCubit>(() =>
      ComboCubit(appLiveStatus: getItInstance(), counterCubit: getItInstance(), sortFilterCubit: getItInstance()));
  getItInstance.registerFactory<CreateComboCubit>(() => CreateComboCubit(
        loadingCubit: getItInstance(),
        pickImageCubitCubit: getItInstance(),
      ));

  getItInstance.registerFactory<AppLayoutsCubit>(
      () => AppLayoutsCubit(pickImageCubitCubit: getItInstance(), counterCubit: getItInstance()));

  // getItInstance.registerFactory<AddAddressCubit>(() => AddAddressCubit(
  //     counterCubit: getItInstance(), locationPickerCubit: getItInstance(), loadingCubit: getItInstance()));
  getItInstance.registerFactory<AddressSearchCubit>(() => AddressSearchCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<LocationPickerCubit>(
      () => LocationPickerCubit(loadingCubit: getItInstance(), counterCubit: getItInstance()));
  getItInstance.registerFactory<ProductDetailCubit>(() => ProductDetailCubit());

  getItInstance.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<AreaWithPincodeCubit>(() => AreaWithPincodeCubit(loadingCubit: getItInstance()));

  //Theme Dependency
  getItInstance.registerLazySingleton<GetPreferredTheme>(() => GetPreferredTheme(
        appRepository: getItInstance(),
      ));
  getItInstance.registerLazySingleton<UpdateTheme>(() => UpdateTheme(
        appRepository: getItInstance(),
      ));
  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
        languageLocalDataSource: getItInstance(),
        themeLocalDataSource: getItInstance(),
      ));
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(() => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSourceImpl());
  getItInstance.registerLazySingleton<GetPreferredLanguage>(() => GetPreferredLanguage(
        appRepository: getItInstance(),
      ));
  getItInstance.registerLazySingleton<UpdateLanguage>(() => UpdateLanguage(
        appRepository: getItInstance(),
      ));
  getItInstance.registerSingleton<LanguageCubit>(LanguageCubit(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));
  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
  getItInstance.registerSingleton<ThemeCubit>(ThemeCubit(
    getPreferredTheme: getItInstance(),
    updateTheme: getItInstance(),
  ));
  getItInstance.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  getItInstance.registerFactory<CustomerViewCubit>(() => CustomerViewCubit(customerCubit: getItInstance()));
  getItInstance.registerLazySingleton<ExpensesCubit>(() => ExpensesCubit(
      pickImageCubitCubit: getItInstance(), counterCubit: getItInstance(), loadingCubit: getItInstance()));
  getItInstance.registerLazySingleton<OffersCubit>(() => OffersCubit());
  getItInstance.registerLazySingleton<ProductInventoryCubit>(() => ProductInventoryCubit());
  getItInstance
      .registerLazySingleton<PurchaseListCubit>(() => PurchaseListCubit(deliverystatustoggle: getItInstance()));
  getItInstance.registerLazySingleton<RoleManagementCubit>(() => RoleManagementCubit());
  getItInstance.registerLazySingleton<RoutineOrderCubit>(() => RoutineOrderCubit(loadingCubit: getItInstance()));
  getItInstance.registerLazySingleton<SupplierCubit>(() => SupplierCubit(
        searchFilterCubit: getItInstance(),
        sortFilterCubit: getItInstance(),
        counterCubit: getItInstance(),
      ));
  getItInstance.registerFactory<UpcomingEventsCubit>(() => UpcomingEventsCubit());
  getItInstance.registerLazySingleton<ProfitLossSheetCubit>(() => ProfitLossSheetCubit());
  getItInstance.registerFactory<ChatCubit>(() => ChatCubit(toggleCubit: getItInstance()));
  getItInstance.registerFactory<AddDeataisCubit>(() => AddDeataisCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<SupplierdetailsCubit>(() => SupplierdetailsCubit(supplierCubit: getItInstance()));
  getItInstance.registerFactory<PointWiseColorBtnCubit>(
      () => PointWiseColorBtnCubit(loadingCubit: getItInstance(), counterCubit: getItInstance()));
  getItInstance.registerFactory<AddReturnOrderCubit>(() => AddReturnOrderCubit(
        loadingCubit: getItInstance(),
        counterCubit: getItInstance(),
      ));
  getItInstance.registerFactory<DeliveryTimeSlotCubit>(() => DeliveryTimeSlotCubit(loadingCubit: getItInstance()));
  getItInstance.registerFactory<AuthenticationCubit>(
      () => AuthenticationCubit(getLoginData: getItInstance(), loadingCubit: getItInstance()));
  getItInstance.registerLazySingleton<AddProductInventoryCubit>(() => AddProductInventoryCubit());
  getItInstance.registerFactory<AddOffersCubit>(() => AddOffersCubit());
}
