import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/features/home/data/models/nav_items.dart';

List<NavItems> bottomBarItems = const [
  NavItems(
    index: 0,
    title: TranslationConstants.dashboard,
    icon: "assets/photos/svg/bottom_navigation_bar/dashboard.svg",
  ),
  NavItems(
    index: 1,
    title: TranslationConstants.order,
    icon: "assets/photos/svg/bottom_navigation_bar/order_bottomBar.svg",
  ),
  NavItems(
    index: 2,
    title: TranslationConstants.chat,
    icon: "assets/photos/svg/bottom_navigation_bar/chat_bottomBar.svg",
  ),
  NavItems(
    index: 3,
    title: TranslationConstants.settings,
    icon: "assets/photos/svg/bottom_navigation_bar/setting_bottomBar.svg",
  ),
];
