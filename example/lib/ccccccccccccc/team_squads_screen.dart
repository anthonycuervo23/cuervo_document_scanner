import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/score/info_score.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/team_squads/team_squads_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';

class TeamSquadsScreen extends StatefulWidget {
  const TeamSquadsScreen({super.key});

  @override
  State<TeamSquadsScreen> createState() => _TeamSquadsScreenState();
}

class _TeamSquadsScreenState extends TeamSquadsWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            matchTitleContainer(),
            playerData(),
            CommonWidget.commonText(text: "Bench Player", fontWeight: FontWeight.w500, fontSize: 18),
            playerData()
          ],
        ),
      ),
    );
  }
}
