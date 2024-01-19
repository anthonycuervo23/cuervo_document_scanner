import 'package:captain_score/shared/models/model_reponse_extend.dart';
import 'package:hive/hive.dart';
part 'app_language_model.g.dart';

class AppLanModel extends ModelResponseExtend {
  final int? status;
  final bool? success;
  final String? message;
  final List<AppLanguageListModel> data;

  AppLanModel({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory AppLanModel.fromJson(Map<String, dynamic> json) {
    return AppLanModel(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: (json['data'] != null && json['status'] == 200)
          ? List<AppLanguageListModel>.from(json['data'].map((v) => AppLanguageListModel.fromJson(v)).toList())
          : [],
    );
  }
}

@HiveType(typeId: 0)
class AppLanguageListModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String shortCode;

  @HiveField(4)
  final int isDefault;

  AppLanguageListModel({required this.id, required this.name, required this.shortCode, required this.isDefault});

  factory AppLanguageListModel.fromJson(Map<String, dynamic> json) {
    return AppLanguageListModel(
      id: json['id'],
      name: json['name'],
      shortCode: json['short_code'] == 'hn' ? 'hi' : json['short_code'],
      isDefault: json['is_default'],
    );
  }

  AppLanguageListModel copyWith({
    int? id,
    String? name,
    String? shortCode,
    int? isDefault,
  }) {
    return AppLanguageListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortCode: shortCode ?? this.shortCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
