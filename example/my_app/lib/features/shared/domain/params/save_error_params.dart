// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

enum ErrorLogType { app, api }

class ErrorParams extends Equatable {
  String url;
  String errMsg;
  ErrorLogType errType;

  ErrorParams({
    required this.url,
    required this.errMsg,
    required this.errType,
  });

  @override
  List<Object?> get props => [url, errMsg, errType];
}
