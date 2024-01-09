// ignore_for_file: overridden_fields, annotate_overrides
import 'package:bakery_shop_admin_flutter/features/authentication/domain/entities/login_entity.dart';
import 'package:bakery_shop_admin_flutter/features/shared/data/models/model_response_extends.dart';

class LoginModel extends ModelResponseExtend {
  final bool status;
  final String message;
  final LoginData data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: LoginData.fromJson(json["data"]),
      );
}

class LoginData extends LoginEntity {
  final String? token;

  const LoginData({
    this.token,
  }) : super(token: token);
  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
      );
}
