// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chocolate_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChocolateTypeAdapter extends TypeAdapter<ChocolateType> {
  @override
  final int typeId = 2;

  @override
  ChocolateType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ChocolateType.BestFriend;
      case 1:
        return ChocolateType.BestSenior;
      case 2:
        return ChocolateType.Crush;
      case 3:
        return ChocolateType.DiscordGang;
      case 4:
        return ChocolateType.IplBuddies;
      case 5:
        return ChocolateType.Homie;
      case 6:
        return ChocolateType.Jugaadu;
      case 7:
        return ChocolateType.LockdownBuddy;
      case 8:
        return ChocolateType.Love;
      case 9:
        return ChocolateType.RightSwipe;
      case 10:
        return ChocolateType.SpecialDedication;
      case 11:
        return ChocolateType.Imposter;
      default:
        return ChocolateType.BestFriend;
    }
  }

  @override
  void write(BinaryWriter writer, ChocolateType obj) {
    switch (obj) {
      case ChocolateType.BestFriend:
        writer.writeByte(0);
        break;
      case ChocolateType.BestSenior:
        writer.writeByte(1);
        break;
      case ChocolateType.Crush:
        writer.writeByte(2);
        break;
      case ChocolateType.DiscordGang:
        writer.writeByte(3);
        break;
      case ChocolateType.IplBuddies:
        writer.writeByte(4);
        break;
      case ChocolateType.Homie:
        writer.writeByte(5);
        break;
      case ChocolateType.Jugaadu:
        writer.writeByte(6);
        break;
      case ChocolateType.LockdownBuddy:
        writer.writeByte(7);
        break;
      case ChocolateType.Love:
        writer.writeByte(8);
        break;
      case ChocolateType.RightSwipe:
        writer.writeByte(9);
        break;
      case ChocolateType.SpecialDedication:
        writer.writeByte(10);
        break;
      case ChocolateType.Imposter:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChocolateTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
