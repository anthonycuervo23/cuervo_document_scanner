import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:captain_score/shared/models/app_error.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'shorts_state.dart';

List reelsUrl = [
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
];

class ShortsCubit extends Cubit<ShortsState> {
  ShortsCubit()
      : super(
          const ShortsLoadedState(
            isPlaying: false,
            isHeartAnimating: false,
          ),
        );

  late VideoPlayerController controller;

  void initialisedController(String url) {
    controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then(
        (_) {
          controller.addListener(() => replyVideo());
        },
      );
  }

  void playPause({required ShortsLoadedState state}) {
    emit(
      state.copyWith(
        isPlaying: !state.isPlaying,
        random: Random().nextDouble(),
      ),
    );
    controller.value.isPlaying ? controller.pause() : controller.play();
  }

  void like({required ShortsLoadedState state}) {
    emit(
      state.copyWith(
        isHeartAnimating: true,
        random: Random().nextDouble(),
      ),
    );
  }

  void onLikeAnimationEnd({required ShortsLoadedState state}) {
    emit(
      state.copyWith(
        isHeartAnimating: false,
        random: Random().nextDouble(),
      ),
    );
  }

  void replyVideo() {
    if (controller.value.position == controller.value.duration) {
      controller.seekTo(Duration.zero);

      if (((state as ShortsLoadedState).isPlaying) == false) {
        controller.play();
      }
    }
  }
}
