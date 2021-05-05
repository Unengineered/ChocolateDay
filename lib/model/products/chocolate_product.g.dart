// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chocolate_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChocolateProductAdapter extends TypeAdapter<ChocolateProduct> {
  @override
  final int typeId = 0;

  @override
  ChocolateProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChocolateProduct(
      chocolateType: fields[0] as ChocolateType,
      toClass: fields[2] as Class,
      toName: fields[1] as String,
      senderName: fields[3] as String,
      message: fields[4] as String,
      cost: fields[5] as double,
      countPrice: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChocolateProduct obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.chocolateType)
      ..writeByte(1)
      ..write(obj.toName)
      ..writeByte(2)
      ..write(obj.toClass)
      ..writeByte(3)
      ..write(obj.senderName)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.countPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChocolateProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
