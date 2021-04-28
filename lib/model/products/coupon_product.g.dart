// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CouponProductAdapter extends TypeAdapter<CouponProduct> {
  @override
  final int typeId = 3;

  @override
  CouponProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CouponProduct(
      name: fields[0] as String,
      studentClass: fields[1] as Class,
      address: fields[2] as String,
      city: fields[3] as String,
      state: fields[4] as IndiaState,
      pinCode: fields[5] as String,
      phoneNumber: fields[6] as String,
      email: fields[7] as String,
      rollNo: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CouponProduct obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.studentClass)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.pinCode)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.rollNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
