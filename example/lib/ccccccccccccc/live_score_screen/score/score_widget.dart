import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/di/get_it.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/score/info_score.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/score/live_score.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/score/score_screen.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/score/scorecard_details.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ScoreWidget extends State<ScoreScreen> {
  late ToggleCubit team1ToggleCubit;
  late ToggleCubit team2ToggleCubit;

  @override
  void initState() {
    team1ToggleCubit = getItInstance<ToggleCubit>();
    team2ToggleCubit = getItInstance<ToggleCubit>();
    super.initState();
  }

  @override
  void dispose() {
    team1ToggleCubit.close();
    team2ToggleCubit.close();
    super.dispose();
  }

  Widget scoreData(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CommonWidget.sizedBox(height: 15.h),
          tvLiveDetails(context: context),
          batterScore(context: context),
          bowlerScore(context: context),
          yetToBatplayerList(context: context),
          lastOverData(context: context),
        ],
      ),
    );
  }

  Widget infoData(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          matchTitleContainer(),
          timeSchedule(),
          commonTextAndBulletPoint(text: TranslationConstants.team_squads.translate(context)),
          teamSquads(context: context),
          commonTextAndBulletPoint(text: "Umpires"),
          umpiresDetails(context: context),
        ],
      ),
    );
  }

  Widget scorecard() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          matchTitleContainer(),
          SizedBox(height: 10.h),
          BlocBuilder<ToggleCubit, bool>(
            bloc: team1ToggleCubit,
            builder: (context, state) {
              return Column(
                children: [
                  CommonWidget.container(
                    margin: EdgeInsets.symmetric(horizontal: 15.h),
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    color: appConstants.whiteBackgroundColor,
                    borderRadius: 10.r,
                    child: scoreRow(
                      score: "313 - 10 (77.1)",
                      title: "India",
                      state: state,
                      index: 0,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Visibility(
                    visible: state,
                    child: scoreCard(context: context),
                  ),
                ],
              );
            },
          ),
          BlocBuilder<ToggleCubit, bool>(
            bloc: team2ToggleCubit,
            builder: (context, state) {
              return Column(
                children: [
                  CommonWidget.container(
                      margin: EdgeInsets.symmetric(horizontal: 15.h),
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      color: appConstants.whiteBackgroundColor,
                      borderRadius: 10.r,
                      child: scoreRow(
                        score: "313 - 10 (77.1)",
                        title: "Australia",
                        state: state,
                        index: 1,
                      )),
                  SizedBox(height: 10.h),
                  Visibility(
                    visible: state,
                    child: scoreCard(context: context),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget scoreRow({
    required String title,
    required String score,
    required bool state,
    required int index,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            state = !state;
            team1ToggleCubit.setValue(value: state);
          } else {
            state = !state;
            team2ToggleCubit.setValue(value: state);
          }
        },
        child: Row(
          children: [
            Expanded(
              child: CommonWidget.commonText(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            CommonWidget.commonText(
              text: score,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: 5.w),
            Icon(
              state == true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
              size: 20.h,
              color: appConstants.textColor,
            )
          ],
        ),
      ),
    );
  }
}
