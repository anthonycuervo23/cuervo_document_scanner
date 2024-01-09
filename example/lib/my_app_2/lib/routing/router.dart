import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/address_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/domain/entities/arguments/loaction_screen_arguments.dart';
import 'package:bakery_shop_flutter/features/address/presentation/cubit/location_picker_cubit/location_picker_cubit.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/add_address/add_address_screen.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/address_search/address_search_screen.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/location_picker/location_picker_screen.dart';
import 'package:bakery_shop_flutter/features/address/presentation/view/manage_address/manage_address_screen.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/generate_otp_args.dart';
import 'package:bakery_shop_flutter/features/authentication/domain/args/image_crop_args.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/edit_profile/edit_profile_screen.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/image_crop/crop_image_screen.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/login_screen/login_screen.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/otp_screen/otp_verification_screen.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/my_profile_screen/my_profile_screen.dart';
import 'package:bakery_shop_flutter/features/chat_support/presentation/view/video_play_screen.dart';
import 'package:bakery_shop_flutter/features/my_cart/presentation/view/my_cart_screen.dart';
import 'package:bakery_shop_flutter/features/chat_support/presentation/view/chat_support_screen.dart';
import 'package:bakery_shop_flutter/features/combo_offers/presentation/view/combo_offers_screen.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/app_home/app_home_screen.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/home_screen/home_screen.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/search/search_screen.dart';
import 'package:bakery_shop_flutter/features/notification/presentation/view/notification_view.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:bakery_shop_flutter/features/offers/presentation/view/offers_screen_view.dart';
import 'package:bakery_shop_flutter/features/orders_history/presentation/view/order_history_screen.dart';
import 'package:bakery_shop_flutter/features/onboarding/presentation/view/splash/splash_screen.dart';
import 'package:bakery_shop_flutter/features/products/domain/args/product_category_args.dart';
import 'package:bakery_shop_flutter/features/products/domain/args/product_details.args.dart';
import 'package:bakery_shop_flutter/features/products/presentation/view/category_screens/product_category_screen.dart';
import 'package:bakery_shop_flutter/features/products/presentation/view/product_list/product_list_screen.dart';
import 'package:bakery_shop_flutter/features/products/presentation/widgets/bottombar/product_details_bar.dart';
import 'package:bakery_shop_flutter/features/rate_us/presentation/view/feedback_screen.dart';
import 'package:bakery_shop_flutter/features/reviews/presentation/view/review_and_feedback_screen.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/policy_cubit/policy_cubit.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/view/app_language/app_language_screen.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/view/setting_screen.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/view/terms_condition/policy_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/help_support/help_and_support_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_favorite/my_favorite_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/order_placed/order_placed_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/order_status/order_status_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/refer_and_earn/how_it_work_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/refer_and_earn/refer_and_earn_screen_view.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/my_reward_point_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/reward_coupon_details_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/my_reward_point/reward_coupon_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/routine_order/routine_order_screen.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/without_login_screen/without_login_screen.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/features/onboarding/presentation/view/introduction_screen/introduction_screen.dart';
import 'package:bakery_shop_flutter/features/authentication/presentation/view/referral_screen/referral_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const SplashScreen(),
        RouteList.introduction_screen: (context) => const IntroductionScreen(),
        RouteList.home_screen: (context) => const HomeScreen(),
        RouteList.login_screen: (context) => const Loginscreen(),
        RouteList.otp_verification_screen: (context) =>
            OtpVerificationScreen(authenticationOtpArgument: setting.arguments as GenerateOtpArgument),
        RouteList.referral_screen: (context) => const ReferralScreen(),
        RouteList.app_home: (context) => const AppHome(),
        RouteList.edit_profile_screen: (context) => EditProfileScreen(userNewOld: setting.arguments as UserNewOld),
        RouteList.setting_screen: (context) => const SettingScreen(),
        RouteList.my_profile_screen: (context) => const MyProfileScreen(),
        RouteList.app_language_screen: (context) => const AppLanguageScreen(),
        RouteList.policy_screen: (context) => PolicyScreen(typeOfPolicy: setting.arguments as TypeOfPolicy),
        RouteList.manage_address_screen: (context) => ManageAddressScreen(
              checkLoactionNavigation: setting.arguments as CheckLoactionNavigation,
            ),
        RouteList.add_address_screen: (context) => AddAddressScreen(
              addressData: setting.arguments as AddressScreenArguments,
            ),
        RouteList.order_history_screen: (context) => const OrderHistoryScreen(),
        RouteList.my_favorite_screen: (context) => const MyFavoriteScreen(),
        RouteList.combo_screen: (context) => const ComboOffersScreen(),
        RouteList.offer_screen: (context) =>
            OfferScreenView(offerScreenChange: setting.arguments as OfferScreenChangeEnum),
        RouteList.my_cart_screen: (context) => const MyCartScreen(),
        RouteList.product_category_screen: (context) => const ProductCategoryScreen(),
        RouteList.product_list_screen: (context) =>
            ProductListScreen(productCategoryArgs: setting.arguments as ProductCategoryArgs),
        RouteList.help_support_screen: (context) => const HelpAndSupportScreen(),
        RouteList.refer_earn_screen: (context) => const ReferAndEarnScreen(),
        RouteList.my_reward_point_screen: (context) => const MyRewardPointScreen(),
        RouteList.how_it_work_screen: (context) => const HowItWorkScreen(),
        RouteList.notification_screen: (context) => const NotificationView(),
        RouteList.routine_order_screen: (context) => const RoutineOrderScreen(),
        RouteList.order_status_screen: (context) => const OrderStatusScreen(),
        RouteList.feedback_screen: (context) => const FeedbackScreen(),
        RouteList.search_screen: (context) => const SearchScreen(),
        RouteList.reward_coupon_screen: (context) => const RewardCouponScreen(),
        RouteList.reward_coupon_details_screen: (context) => const RewardCouponDetailsScreen(),
        RouteList.image_crop_screen: (context) => CropImageScreen(cropArgs: setting.arguments as ImageCropArgs),
        RouteList.chat_support_screen: (context) => const ChatSupportScreen(),
        RouteList.order_placed_screen: (context) => const OrderPlacedScreen(),
        RouteList.review_and_feedback_screen: (context) => const ReviewAndFeedbackScreen(),
        RouteList.location_picker_screen: (context) =>
            LocationPickerScreen(checkLoactionNavigation: setting.arguments as LoactionArguments),
        RouteList.address_search_screen: (context) =>
            AddressSearchScreen(args: setting.arguments as AddressScreenArguments),
        RouteList.without_login_screen: (context) => WithoutLoginScreen(
              isApplyAppbar: setting.arguments as bool,
            ),
        RouteList.product_details_bar: (context) => ProductDetailsBar(
              productDetailsArgs: setting.arguments as ProductDetailsArgs,
            ),
        RouteList.video_play_screen: (context) => VideoPlayScreen(
              url: setting.arguments as String,
            ),
      };
}
