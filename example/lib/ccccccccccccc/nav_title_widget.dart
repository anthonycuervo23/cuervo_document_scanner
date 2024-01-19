import 'package:captain_score/common/extention/theme_extension.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final String iconPath;

  const NavTitleWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.iconPath = '',
  })  : assert(iconPath != '', 'SvgPath should not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.01, 0.9],
            colors: <Color>[
              appConstants.gradiantColor1,
              appConstants.gradiantColor2,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.imageBuilder(
              imageUrl: iconPath,
              color: isSelected ? appConstants.whiteBackgroundColor : appConstants.unSelectedIconColor,
              width: 30.r,
              height: 30.r,
            ),
            CommonWidget.sizedBox(height: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.overLine1MediumHeading.copyWith(
                    color: isSelected ? appConstants.whiteBackgroundColor : appConstants.unSelectedIconColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
