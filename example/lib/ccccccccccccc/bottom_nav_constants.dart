import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/models/nav_items.dart';

List<NavItems> bottomBarItems = const [
  NavItems(
    index: 0,
    title: TranslationConstants.home,
    icon: "assets/svgs/bottom_icon/home.svg",
  ),
  NavItems(
    index: 1,
    title: TranslationConstants.shorts,
    icon: "assets/svgs/bottom_icon/shorts.svg",
  ),
  NavItems(
    index: 2,
    title: TranslationConstants.match,
    icon: "assets/svgs/bottom_icon/match.svg",
  ),
  NavItems(
    index: 3,
    title: TranslationConstants.news,
    icon: "assets/svgs/bottom_icon/news.svg",
  ),
  NavItems(
    index: 4,
    title: TranslationConstants.more,
    icon: "assets/svgs/bottom_icon/setting.svg",
  ),
];
