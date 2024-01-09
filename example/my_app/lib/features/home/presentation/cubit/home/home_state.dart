// ignore_for_file: must_be_immutable

part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final HomeEntity homeDataEntity;
  double? random;
  HomeLoadedState({this.random, required this.homeDataEntity});

  HomeLoadedState copywith({
    double? random,
    HomeEntity? homeDataEntity,
  }) {
    return HomeLoadedState(
      homeDataEntity: homeDataEntity ?? this.homeDataEntity,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [random,homeDataEntity];
}

final class HomeErrorState extends HomeState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const HomeErrorState({required this.appErrorType, required this.errorMessage});
  @override
  List<Object?> get props => [appErrorType, errorMessage];
}
