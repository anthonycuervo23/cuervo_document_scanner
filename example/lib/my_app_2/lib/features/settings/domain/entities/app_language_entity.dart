import 'package:hive/hive.dart';
part 'app_language_entity.g.dart';

@HiveType(typeId: 0)
class AppLanguageEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String shortCode;

  @HiveField(3)
  final String? imageUrl;

  @HiveField(4)
  final int isDefault;

  // @HiveField(5)
  // final String language;

  AppLanguageEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.shortCode,
    required this.isDefault,
    // required this.language,
  });

  AppLanguageEntity copyWith({
    int? id,
    String? name,
    String? shortCode,
    int? isDefault,
    String? imageUrl,
  }) {
    return AppLanguageEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      shortCode: shortCode ?? this.shortCode,
      isDefault: isDefault ?? this.isDefault,
      imageUrl: imageUrl ?? this.imageUrl,
      // language: language,
    );
  }
}
