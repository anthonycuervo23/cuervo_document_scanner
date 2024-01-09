import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
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
        color: appConstants.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.imageBuilder(
              imageUrl: iconPath,
              color: isSelected ? appConstants.themeColor : appConstants.theme4Color,
              width: 22.r,
              height: 22.r,
            ),
            SizedBox(height: 6.h),
            Text(title,
                style: TextStyle(
                  color: isSelected ? appConstants.themeColor : appConstants.theme4Color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                )),
          ],
        ),
      ),
    );
  }
}
