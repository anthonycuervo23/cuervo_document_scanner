import 'package:captain_score/features/match/presentation/pages/all_match_score.dart';
import 'package:captain_score/features/match/presentation/pages/match_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends MatchesWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: matchesList.length,
      child: Scaffold(
          backgroundColor: appConstants.greyBackgroundColor,
          appBar: appbar(context),
          body: TabBarView(
            children: [
              allMatchDetails(context: context),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
            ],
          )),
    );
  }
}
