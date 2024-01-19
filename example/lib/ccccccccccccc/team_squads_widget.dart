import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/features/home_screen/presentation/pages/live_score_screen/team_squads/team_squads_screen.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TeamSquadsWidget extends State<TeamSquadsScreen> {
  PreferredSizeWidget? appBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: CommonWidget.commonLinearGradient(),
      titleSpacing: 12.w,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: CommonWidget.commonText(
        text: TranslationConstants.team_squads.translate(context),
        color: appConstants.whiteBackgroundColor,
        fontSize: 20.sp,
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: CircleAvatar(
              radius: 15.r,
              backgroundColor: appConstants.circleColor,
              child: CommonWidget.commonIcon(
                icon: Icons.close,
                iconColor: appConstants.whiteBackgroundColor,
                iconSize: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget playerData() {
    return CommonWidget.container(
      borderRadius: 15.r,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      color: appConstants.whiteBackgroundColor,
      child: GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 0.8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: (index % 2 == 0) ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Visibility(
                visible: (index % 2 == 0) ? true : false,
                child: playerProfileImage(padding: EdgeInsets.only(right: 10.w)),
              ),
              Column(
                crossAxisAlignment: (index % 2 == 0) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonWidget.commonText(text: "David Warner", fontWeight: FontWeight.w500, fontSize: 14),
                  CommonWidget.commonText(text: "Batter", fontSize: 12, color: appConstants.greyTextColor),
                ],
              ),
              Visibility(
                visible: (index % 2 == 0) ? false : true,
                child: playerProfileImage(padding: EdgeInsets.only(left: 10.w)),
              ),
              Visibility(visible: (index % 2 == 0) ? true : false, child: const Spacer()),
              Visibility(
                visible: (index % 2 == 0) ? true : false,
                child: VerticalDivider(
                  color: appConstants.dividerColor,
                  thickness: 0.6,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget playerProfileImage({required EdgeInsetsGeometry padding}) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () => CommonRouter.pushNamed(RouteList.player_info_screen),
        child: CircleAvatar(
          backgroundColor: appConstants.primary1Color,
          backgroundImage: const NetworkImage(
            "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcSfyShtvHceBMCYv9guQd8236h5CzkUsNg4K1MoPvcrFw1DqBiISSyox3hj711QgLirrW06sUmoV-AV1h0",
          ),
        ),
      ),
    );
  }
}
