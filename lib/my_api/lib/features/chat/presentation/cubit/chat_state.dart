// ignore_for_file: must_be_immutable

part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<UserNameDetail> listOfMessage;
  double? random;

  ChatLoadedState({required this.listOfMessage, this.random});

  ChatLoadedState copyWith({List<UserNameDetail>? listOfMessage, double? random}) {
    return ChatLoadedState(
      listOfMessage: listOfMessage ?? this.listOfMessage,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [listOfMessage, random];
}

class ChatErrorState extends ChatState {
  final AppErrorType appErrorType;
  final String errorMessage;

  const ChatErrorState({required this.appErrorType, required this.errorMessage});

  @override
  List<Object> get props => [appErrorType, errorMessage];
}
