// ignore_for_file: overridden_fields, annotate_overrides

import 'package:captain_score/shared/models/model_reponse_extend.dart';

class BooleanModel extends ModelResponseExtend {
  final int? status;
  final bool? success;
  final String? message;
  final bool? data;

  BooleanModel({required this.status, required this.success, required this.message, required this.data});

  factory BooleanModel.fromJson(Map<String, dynamic> json) {
    return BooleanModel(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: json['success'] ?? false,
    );
  }
}
