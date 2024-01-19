import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/score/score_screen.dart';
import 'package:captain_score/features/news/data/models/news_data_model.dart';
import 'package:captain_score/features/news/presentation/pages/single_news/single_news_screen.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/team_squads/team_squads_screen.dart';
import 'package:captain_score/features/player_info/presentation/pages/player_info_screen.dart';
import 'package:captain_score/shared/presentation/app_home/app_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:captain_score/shared/utils/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const SplashScreen(),
        RouteList.app_home: (context) => const AppHome(),
        RouteList.score_screen: (context) => const ScoreScreen(),
        RouteList.player_info_screen: (context) => const PlayerInfoScreen(),
        RouteList.single_news_screen: (context) => SingleNewsScreen(newsModel: setting.arguments as NewsModel),
        RouteList.team_squads_screen: (context) => const TeamSquadsScreen(),
      };
}
