import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/loading/loading_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;

  const LoadingScreen({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: appConstants.background,
          child: 1 == 1 ? screen : SafeArea(top: false, left: true, right: true, bottom: false, child: screen),
        ),
        BlocBuilder<LoadingCubit, bool>(
          builder: (context, shouldShow) {
            if (shouldShow) {
              return Container(
                color: Colors.black.withOpacity(0.75),
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                child: 1 == 1
                    ? CommonWidget.loadingIos()
                    : 1 == 1
                        ? Center(
                            child: Lottie.asset(
                              "assets/animation/loading_indicator_white.json",
                              width: 80.r,
                              height: 80.r,
                            ),
                          )
                        : 1 != 1
                            ? Image.asset(
                                'assets/animation/loader.gif',
                                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                                width: 360.r,
                                height: 360.r,
                              )
                            : SizedBox(
                                width: 360.r,
                                height: 360.r,
                                // child: const FlareActor(
                                //   'assets/animation/loading_circle.flr',
                                //   animation: 'load',
                                //   snapToEnd: true,
                                // ),
                              ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
