import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final String iconPath;
  final String activatedIcon;

  const NavTitleWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.iconPath = '',
    required this.activatedIcon,
  })  : assert(iconPath != '', 'SvgPath should not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: appConstants.whiteBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.imageBuilder(
              imageUrl: isSelected ? activatedIcon : iconPath,
              color: isSelected ? appConstants.primary1Color : appConstants.default5Color,
              width: 22.r,
              height: 22.r,
            ),
            CommonWidget.sizedBox(height: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.overLineMediumHeading.copyWith(
                    color: isSelected ? appConstants.primary1Color : appConstants.default5Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
