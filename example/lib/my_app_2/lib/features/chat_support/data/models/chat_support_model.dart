import 'package:equatable/equatable.dart';

class ChatSupportModel extends Equatable {
  final String id;
  final String userName;
  final String message;
  final String time;
  final String endValue;
  final bool isSendMessage;

  const ChatSupportModel({
    required this.id,
    required this.userName,
    required this.message,
    required this.time,
    required this.endValue,
    required this.isSendMessage,
  });

  @override
  List<Object?> get props => [id, userName, message, time, isSendMessage, endValue];
}
