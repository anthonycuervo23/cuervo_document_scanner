// ignore_for_file: must_be_immutable

part of 'deep_link_cubit.dart';

abstract class DeepLinkState extends Equatable {
  const DeepLinkState();

  @override
  List<Object?> get props => [];
}

class DeepLinkLoadingState extends DeepLinkState {
  const DeepLinkLoadingState();

  @override
  List<Object> get props => [];
}

class DeepLinkLoadedState extends DeepLinkState {
  DeepLinkData? deepLinkData;

  DeepLinkLoadedState({this.deepLinkData});

  @override
  List<Object?> get props => [deepLinkData];
}