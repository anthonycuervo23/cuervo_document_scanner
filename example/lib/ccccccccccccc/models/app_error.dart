import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType errorType;
  final String errorMessage;
  const AppError({required this.errorType, required this.errorMessage});

  @override
  List<Object> get props => [errorType];
}

enum AppErrorType { api, network, database, login, otp, data, unauthorised, app }
