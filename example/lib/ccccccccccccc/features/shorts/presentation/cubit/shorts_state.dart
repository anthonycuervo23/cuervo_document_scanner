part of 'shorts_cubit.dart';

abstract class ShortsState extends Equatable {
  const ShortsState();

  @override
  List<Object?> get props => [];
}

class ShortsInitial extends ShortsState {}

class ShortsLoadingState extends ShortsState {
  @override
  List<Object> get props => [];
}

class ShortsLoadedState extends ShortsState {
  final bool isPlaying;
  final bool isHeartAnimating;
  final double? random;

  const ShortsLoadedState({
    required this.isPlaying,
    required this.isHeartAnimating,
    this.random,
  });

  ShortsLoadedState copyWith({
    bool? isPlaying,
    bool? isHeartAnimating,
    double? random,
  }) {
    return ShortsLoadedState(
      isPlaying: isPlaying ?? this.isPlaying,
      isHeartAnimating: isHeartAnimating ?? this.isHeartAnimating,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [
        isPlaying,
        isHeartAnimating,
        random,
      ];
}

class ShortsErrorState extends ShortsState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ShortsErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object> get props => [appErrorType, errorMessage];
}
