import 'package:captain_score/shared/cubit/loading/loading_cubit.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;

  const LoadingScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.transparent,
          child: SafeArea(top: false, left: true, right: true, bottom: false, child: screen),
        ),
        BlocBuilder<LoadingCubit, bool>(
          builder: (context, shouldShow) {
            if (shouldShow) {
              return Container(
                color: Colors.black.withOpacity(0.75),
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                child: 1 == 1
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
                            errorBuilder: (context, error, stackTrace) {
                              Catcher2.reportCheckedError(error, stackTrace);
                              return const SizedBox.shrink();
                            },
                            width: 360.r,
                            height: 360.r,
                          )
                        : SizedBox(
                            width: 360.r,
                            height: 360.r,
                            child: const FlareActor(
                              'assets/animation/loading_circle.flr',
                              animation: 'load',
                              snapToEnd: true,
                            ),
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
