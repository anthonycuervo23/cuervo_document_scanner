import 'package:equatable/equatable.dart';

class GetLoginParams extends Equatable {
  final String? email;
  final String? password;

  const GetLoginParams({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
