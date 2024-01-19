import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/features/player_info/presentation/pages/player_info_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerInfoScreen extends StatefulWidget {
  const PlayerInfoScreen({super.key});

  @override
  State<PlayerInfoScreen> createState() => _PlayerInfoScreenState();
}

class _PlayerInfoScreenState extends PlayerInfoWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: appConstants.whiteBackgroundColor,
        backgroundColor: appConstants.whiteBackgroundColor,
        leading: GestureDetector(onTap: () => CommonRouter.pop(), child: const Icon(Icons.arrow_back)),
        elevation: 0,
      ),
      body: Column(
        children: [
          profileImage(),
          SizedBox(
            height: ScreenUtil().screenHeight * 0.68,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    titleText(text: TranslationConstants.personal_information.translate(context)),
                    personalInformation(),
                    titleText(text: TranslationConstants.team_played_for.translate(context)),
                    teamPlayedFor(),
                    titleText(text: TranslationConstants.batting_career.translate(context)),
                    battingCareerStatics(),
                    titleText(text: TranslationConstants.bowling_career.translate(context)),
                    bowlingStaticsStats(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
