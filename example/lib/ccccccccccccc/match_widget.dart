import 'package:captain_score/features/match/presentation/pages/match_screen.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';

abstract class MatchesWidget extends State<MatchesScreen> {
  List matchesList = [
    'All',
    'T20',
    'ODI',
    'Test',
    'T10',
    'IPl',
    'All',
    'T20',
    'ODI',
    'Test',
    'T10',
    'IPl',
  ];

  AppBar appbar(BuildContext context) {
    return AppBar(
      flexibleSpace: CommonWidget.commonLinearGradient(),
      backgroundColor: appConstants.whiteBackgroundColor,
      automaticallyImplyLeading: false,
      title: CommonWidget.commonText(
        text: "Macthes",
        color: appConstants.whiteBackgroundColor,
        fontWeight: FontWeight.w600,
        fontSize: 23,
      ),
      bottom: TabBar(
        indicatorColor: appConstants.whiteBackgroundColor,
        indicatorSize: TabBarIndicatorSize.tab,
        splashFactory: NoSplash.splashFactory,
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        tabs: List.generate(
          matchesList.length,
          (i) => Tab(
            child: CommonWidget.commonText(
              text: matchesList[i],
              color: appConstants.whiteBackgroundColor,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
