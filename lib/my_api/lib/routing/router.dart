import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/domain/entities/arguments/location_picker_arguments.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/view/address_search/address_search_screen.dart';
import 'package:bakery_shop_admin_flutter/features/address/presentation/view/location_picker/location_picker_screen.dart';
import 'package:bakery_shop_admin_flutter/features/app_layouts/presentation/pages/app_layout_screen.dart';
import 'package:bakery_shop_admin_flutter/features/authentication/presentation/view/login_screen/login_screen.dart';

import 'package:bakery_shop_admin_flutter/features/chat/presentation/pages/chat_list/chat_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/chat/presentation/pages/chat_screen/chat_screen.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/view/combo_screen.dart';
import 'package:bakery_shop_admin_flutter/features/combo/presentation/view/create_combo/create_combo_screen.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/cateloage/cateloge_screen.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/orderScreen/order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/data/models/order_products_model.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/domain/entities/args/order_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/create_customer_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/domain/entities/args/handle_location_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/create_customer/create_customer_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/customer_details_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_details_screen/handle_location_screen.dart';
import 'package:bakery_shop_admin_flutter/features/customer/presentation/view/customer_screen/customer_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/data/model/expanses_model.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/add_expense_screen_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/domain/entity/args/expense_category_item_args.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/add_expanses/add_expense_screen.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/expanses_category_item/expanses_category_item_screen.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/expanses_category_list/expanses_category_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/expenses/presentation/view/single_expenses/single_expense_screen.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/app_home/app_home_view.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/home_screen/home_screen_view.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/domain/entities/argumets/add_ads_argumets.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/add_details_screen/add_details_screen.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/marketing_screen/marketing_screen.dart';
import 'package:bakery_shop_admin_flutter/features/offers/data/models/offer_details_model.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/view/add_offers/add_offers_screen.dart';
import 'package:bakery_shop_admin_flutter/features/offers/presentation/view/offers/offers_screen.dart';
import 'package:bakery_shop_admin_flutter/features/onboarding/presentation/view/splash/splash_screen_view.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/data/models/product_inventory_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/view/add_inventory_screen/add_inventory_screen.dart';
import 'package:bakery_shop_admin_flutter/features/product_inventory/presentation/view/product_inventory/product_inventory_screen.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/data/models/product_list_model.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/domain/args/image_crop_args.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/add_product/add_product_screen.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/catalogue/catalogue_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/image_crop_screen.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/product_detail/product_detail_screen.dart';
import 'package:bakery_shop_admin_flutter/features/product_list/presentation/view/product_list/product_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/profit_loss_sheet/presentation/pages/profit_loss_sheet_screen.dart';
import 'package:bakery_shop_admin_flutter/features/purchase_list/presentation/screen/purchase_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/refer_list/presentation/view/refer_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/cubit/reminder_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/reminder/presentation/view/reminder_screen.dart';
import 'package:bakery_shop_admin_flutter/features/return_order/presentation/pages/add_return_order/add_return_order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/return_order/presentation/pages/return_order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/role_management/presentation/pages/role_management_screen.dart';
import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/pages/customer_all_details/routine_order_details_screen.dart';
import 'package:bakery_shop_admin_flutter/features/routine_order/presentation/pages/routine_order_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/app_language/app_language_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/area_with_pincode/area_with_pincode_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/change_password_screen/change_password_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/delivery_time_slot/delivery_time_slot_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/point_wise_color_button/add_new_point_wise_color_btn/add_new_point_wise_color_btn_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/point_wise_color_button/point_wise_color_btn_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/refer_point/refer_point_screen.dart';
import 'package:bakery_shop_admin_flutter/features/settings/presentation/view/setting_screen.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/pages/supplier_details.dart/supplier_details_screen.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/pages/supplier_view/supplier_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/pick_image_cubit/pick_image_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/data/models/upcoming_events_model.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/pages/add_upcoming_event/add_upcoming_event_screen.dart';
import 'package:bakery_shop_admin_flutter/features/upcoming_events/presentation/pages/upcoming_event_screen/upcoming_events_screen.dart';
import 'package:bakery_shop_admin_flutter/routing/route_list.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const SplashScreen(),
        //RouteList.initial: (context) => const AppHome(),
        RouteList.home_screen: (context) => const HomeScreen(),
        RouteList.app_home: (context) => const AppHome(),
        RouteList.setting_screen: (context) => const SettingScreen(),
        RouteList.app_language_screen: (context) => const AppLanguageScreen(),
        // RouteList.create_new_screen: (context) => CreateNewCustomerScreen(
        //       navigation: setting.arguments as Map,
        //     ),
        RouteList.product_list_screen: (context) => const ProductListScreen(),
        RouteList.product_detail_screen: (context) =>
            ProductDetailScreen(productModel: setting.arguments as ProductListModel),
        RouteList.add_product_screen: (context) => const AddProductScreen(),
        // RouteList.customer_all_details_screen: (context) =>
        //     CustomerAllDetailScreen(customerDetailModel: setting.arguments as CustomerDetailModel),
        RouteList.refer_list_screen: (context) =>
            ReferListScreen(referData: setting.arguments as List<ReferDetailModel>),
        RouteList.reminder_screen: (context) => ReminderScreen(reminderType: setting.arguments as ReminderType),
        RouteList.order_screen: (context) => OrderScreen(product: setting.arguments as OrderScreenArgs),
        RouteList.cateloge_screen: (context) => CatelogeScreen(productData: setting.arguments as ProductModel),
        RouteList.catalogue_screen: (context) => CatalogueScreen(cubitData: setting.arguments as PickImageCubit),
        RouteList.chat_list_screen: (context) => const ChatListScreen(),
        RouteList.chat_screen: (context) => ChatScreen(index: setting.arguments as int),
        RouteList.app_layouts_screen: (context) => const AppLayoutsScreen(),
        RouteList.offers_screen: (context) => const OffersScreen(),
        RouteList.add_offers_screen: (context) => AddOffersScreen(arguments: setting.arguments as OfferDetailsModel),
        RouteList.product_inventory_screen: (context) => const ProductInventoryScreen(),
        RouteList.purchse_list_screen: (context) => const PurchaseListScreen(),
        RouteList.return_order_screen: (context) => const ReturnOrderScreen(),
        RouteList.role_management_screen: (context) => const RoleManagementScreen(),
        RouteList.routine_order_screen: (context) => const RotineOrderScreen(),
        RouteList.supplier_screen: (context) => const SupplierScreen(),
        RouteList.upcoming_events_screen: (context) => const UpcomingEventsScreen(),
        RouteList.profit_loss_sheet_screen: (context) => const ProfitLossSheetScreen(),
        RouteList.marketing_screen: (context) => const MarketingScreen(),
        RouteList.add_ads_screen: (context) => AddAdsScreen(arguments: setting.arguments as AddAdsScreebArgs),
        RouteList.combo_screen: (context) => const ComboScreen(),
        RouteList.create_combo_screen: (context) => CreateComboScreen(
              comboType: setting.arguments as ComboType,
            ),
        RouteList.location_picker_screen: (context) => LocationPickerScreen(
              args: setting.arguments as LocationPickerScreenArguments,
            ),
        RouteList.address_search_screen: (context) =>
            AddressSearchScreen(args: setting.arguments as AddressScreenArguments),
        RouteList.add_upcoming_events_screen: (context) => AddUpcomingEventScreen(
              model: setting.arguments as UpcomingEventsModel,
            ),
        RouteList.supplier_details_screen: (context) =>
            SupplierDetailsScreen(supplierDetailModel: setting.arguments as SupplierDetailModel),
        RouteList.image_crop_screen: (context) => ImageCropScreen(cropArgs: setting.arguments as ImageCropArgs),
        RouteList.login_screen: (context) => const Loginscreen(),
        RouteList.refer_point_screen: (context) => const ReferPointScreen(),
        RouteList.change_paswword_screen: (context) => const ChangePasswordScreen(),
        RouteList.area_with_pincode_screen: (context) => const AreaWithPinCodeScreen(),
        RouteList.point_wise_color_btn_screen: (context) => const PointWiseColorBtnScreen(),
        RouteList.add_new_point_wise_color_btn_screen: (context) => const AddNewPointWiseColorBtnScreen(),
        RouteList.delivery_time_slot_screen: (context) => const DeliveryTimeSlotScreen(),
        RouteList.routine_order_detail_screen: (context) => const RoutineOrderDetailsScreen(),
        RouteList.add_return_order_screen: (context) => const AddReturnOrderScreen(),
        RouteList.add_expanses: (context) => AddExpansesScreen(args: setting.arguments as AddExpenseScreenArgs),
        RouteList.single_expenses_screen: (context) =>
            SingleExpensesScreen(args: setting.arguments as ExpenseCategoryItemArgs),
        RouteList.expenses_category_list_screen: (context) => const ExpensesCategoryListScreen(),
        RouteList.expanses_category_item_screen: (context) =>
            ExpansesCategoryItemScreen(selectCategoryModel: setting.arguments as SelectCategoryModel),
        RouteList.customer_list_screen: (context) => const CustomerListScreen(),
        RouteList.customer_details_screen: (context) =>
            CustomerDetailScreen(customerDetailModel: setting.arguments as CustomerDetailModel),
        RouteList.handle_location_screen: (context) =>
            HandleLocationScreen(args: setting.arguments as HandleLocationArgs),
        RouteList.create_customer_screen: (context) =>
            CreateCustomerScreen(navigation: setting.arguments as CreateCustomerArgs),
        RouteList.add_inventory_screen: (context) =>
            AddProductInventoryScreen(productInventoryModel: setting.arguments as ProductInventoryModel),
      };
}
