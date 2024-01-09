// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_language_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppLanguageEntityAdapter extends TypeAdapter<AppLanguageEntity> {
  @override
  final int typeId = 0;

  @override
  AppLanguageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppLanguageEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[3] as String?,
      shortCode: fields[2] as String,
      isDefault: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppLanguageEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.shortCode)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLanguageEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
