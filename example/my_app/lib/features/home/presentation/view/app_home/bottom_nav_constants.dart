import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/features/home/data/models/nav_items.dart';

List<NavItems> bottomBarItems = const [
  NavItems(
    index: 0,
    title: TranslationConstants.home,
    activatedIcon: "assets/photos/svg/bottom_navigation_bar/selected_home_icon.svg",
    icon: "assets/photos/svg/bottom_navigation_bar/home_icon.svg",
  ),
  NavItems(
    index: 1,
    title: TranslationConstants.combo,
    activatedIcon: "assets/photos/svg/bottom_navigation_bar/selected_combo.svg",
    icon: "assets/photos/svg/bottom_navigation_bar/combo_icon.svg",
  ),
  NavItems(
    index: 2,
    title: TranslationConstants.offers,
    activatedIcon: "assets/photos/svg/bottom_navigation_bar/selected_offers.svg",
    icon: "assets/photos/svg/bottom_navigation_bar/offers_icon.svg",
  ),
  NavItems(
    index: 3,
    title: TranslationConstants.my_cart,
    activatedIcon: "assets/photos/svg/bottom_navigation_bar/selected_mycart.svg",
    icon: "assets/photos/svg/bottom_navigation_bar/mycart_icon.svg",
  ),
];
