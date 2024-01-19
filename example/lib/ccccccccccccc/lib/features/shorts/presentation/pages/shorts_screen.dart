import 'package:captain_score/features/shorts/presentation/cubit/shorts_cubit.dart';
import 'package:captain_score/features/shorts/presentation/widget/heart_animation_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: reelsUrl.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SinglePage(url: reelsUrl[index]);
      },
    );
  }
}

class SinglePage extends StatefulWidget {
  final String url;
  const SinglePage({Key? key, required this.url}) : super(key: key);

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  @override
  void initState() {
    shortsCubit.initialisedController(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShortsCubit, ShortsState>(
        bloc: shortsCubit,
        builder: (context, state) {
          if (state is ShortsLoadedState) {
            if (shortsCubit.controller.value.hasError) {
              // print('VideoPlayerController error: ${shortsCubit.controller.value.errorDescription}');
            }
            return GestureDetector(
              onTap: () => shortsCubit.playPause(state: state),
              onDoubleTap: () => shortsCubit.like(state: state),
              child: Stack(
                children: [
                  VideoPlayer(shortsCubit.controller),
                  Opacity(
                    opacity: (state.isHeartAnimating == true) ? 1 : 0,
                    child: HeartAnimationWidget(
                      isAnimating: state.isHeartAnimating,
                      onEnd: () => shortsCubit.onLikeAnimationEnd(state: state),
                      duration: const Duration(milliseconds: 700),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.favorite,
                          size: 50.r,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.thumb_up,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.thumb_down,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        });
  }
}
