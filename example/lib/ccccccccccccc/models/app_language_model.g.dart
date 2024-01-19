// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_language_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppLanguageListModelAdapter extends TypeAdapter<AppLanguageListModel> {
  @override
  final int typeId = 0;

  @override
  AppLanguageListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppLanguageListModel(
      id: fields[0] as int,
      name: fields[1] as String,
      shortCode: fields[2] as String,
      isDefault: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppLanguageListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.shortCode)
      ..writeByte(4)
      ..write(obj.isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppLanguageListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
