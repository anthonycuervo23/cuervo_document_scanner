// import 'package:bakery_shop_admin_flutter/global.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// Future<dynamic> openBottomBar({
//   required BuildContext context,
//   required Widget child,
//   double? heightFactor,
//   Color? backgroundColor,
// }) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     isDismissible: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(12.r),
//         topRight: Radius.circular(12.r),
//       ),
//     ),
//     barrierColor: appConstants.barriarColor,
//     backgroundColor: appConstants.white,
//     useSafeArea: true,
//     enableDrag: true,
//     builder: (context) {
//       return Padding(
//         padding: MediaQuery.of(context).viewInsets,
//         child: FractionallySizedBox(
//           heightFactor: heightFactor ?? 0.60.h,
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(26.r), topRight: Radius.circular(26.r)),
//             child: child,
//           ),
//         ),
//       );
//     },
//   );
// }

import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> openBottomBar({
  required BuildContext context,
  required Widget child,
  double? heightFactor,
  Color? backgroundColor,
  bool? isTitleBar,
  String? title,
  TextStyle? titleTextStye,
  bool isTitleBold = false,
  double? titleFontSize,
  Color? dividerColor,
  double? dividerThickness,
  EdgeInsetsGeometry? padding,
}) {
  return showModalBottomSheet(
    elevation: 0,
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.r),
        topRight: Radius.circular(12.r),
      ),
    ),
    barrierColor: appConstants.neutral1Color.withOpacity(0.7),
    backgroundColor: backgroundColor ?? Colors.white,
    useSafeArea: true,
    enableDrag: true,
    builder: (context) {
      return Padding(
        padding: padding ?? MediaQuery.of(context).viewInsets,
        child: FractionallySizedBox(
          heightFactor: heightFactor,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(26.r), topRight: Radius.circular(26.r)),
            child: isTitleBar == true
                ? CommonWidget.container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 10.w),
                          child: Row(
                            children: [
                              Text(
                                title ?? "",
                                style: titleTextStye ??
                                    TextStyle(
                                      color: const Color(0xff084277),
                                      fontWeight: isTitleBold ? FontWeight.w800 : FontWeight.w400,
                                      fontSize: titleFontSize ?? 13.sp,
                                    ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => CommonRouter.pop(),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 25.r,
                                  color: const Color(0xff084277),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: dividerColor ?? appConstants.dividerColor,
                          thickness: dividerThickness ?? 1.h,
                        ),
                        CommonWidget.container(
                          color: appConstants.white,
                          child: child,
                        )
                      ],
                    ),
                  )
                : child,
          ),
        ),
      );
    },
  );
}
