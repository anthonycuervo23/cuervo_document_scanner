// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data_for_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDataForCartModelAdapter
    extends TypeAdapter<ProductDataForCartModel> {
  @override
  final int typeId = 13;

  @override
  ProductDataForCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDataForCartModel(
      productId: fields[0] as int,
      productName: fields[1] as String,
      productPrice: fields[2] as double,
      productAttributsId: fields[3] as int,
      slugs: (fields[4] as List).cast<String>(),
      productSlugPrice: fields[5] as double,
      totalProduct: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDataForCartModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.productPrice)
      ..writeByte(3)
      ..write(obj.productAttributsId)
      ..writeByte(4)
      ..write(obj.slugs)
      ..writeByte(5)
      ..write(obj.productSlugPrice)
      ..writeByte(6)
      ..write(obj.totalProduct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDataForCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
