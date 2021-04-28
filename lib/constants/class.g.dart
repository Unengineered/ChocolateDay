// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassAdapter extends TypeAdapter<Class> {
  @override
  final int typeId = 1;

  @override
  Class read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Class.D1E;
      case 1:
        return Class.D1AD;
      case 2:
        return Class.D2A;
      case 3:
        return Class.D2B;
      case 4:
        return Class.D2C;
      case 5:
        return Class.D3;
      case 6:
        return Class.D4A;
      case 7:
        return Class.D4B;
      case 8:
        return Class.D5A;
      case 9:
        return Class.D5B;
      case 10:
        return Class.D6;
      case 11:
        return Class.D7A;
      case 12:
        return Class.D7B;
      case 13:
        return Class.D7C;
      case 14:
        return Class.D8;
      case 15:
        return Class.D9A;
      case 16:
        return Class.D9B;
      case 17:
        return Class.D10A;
      case 18:
        return Class.D10B;
      case 19:
        return Class.MCA2A;
      case 20:
        return Class.MCA2B;
      case 21:
        return Class.D11A;
      case 22:
        return Class.D11B;
      case 23:
        return Class.D12A;
      case 24:
        return Class.D12B;
      case 25:
        return Class.D12C;
      case 26:
        return Class.D13;
      case 27:
        return Class.D14A;
      case 28:
        return Class.D14B;
      case 29:
        return Class.D15;
      case 30:
        return Class.MCA3A;
      case 31:
        return Class.MCA3B;
      case 32:
        return Class.D16A;
      case 33:
        return Class.D16B;
      case 34:
        return Class.D17A;
      case 35:
        return Class.D17B;
      case 36:
        return Class.D17C;
      case 37:
        return Class.D18;
      case 38:
        return Class.D19A;
      case 39:
        return Class.D19B;
      case 40:
        return Class.D19C;
      case 41:
        return Class.D20;
      case 42:
        return Class.Division;
      default:
        return Class.D1E;
    }
  }

  @override
  void write(BinaryWriter writer, Class obj) {
    switch (obj) {
      case Class.D1E:
        writer.writeByte(0);
        break;
      case Class.D1AD:
        writer.writeByte(1);
        break;
      case Class.D2A:
        writer.writeByte(2);
        break;
      case Class.D2B:
        writer.writeByte(3);
        break;
      case Class.D2C:
        writer.writeByte(4);
        break;
      case Class.D3:
        writer.writeByte(5);
        break;
      case Class.D4A:
        writer.writeByte(6);
        break;
      case Class.D4B:
        writer.writeByte(7);
        break;
      case Class.D5A:
        writer.writeByte(8);
        break;
      case Class.D5B:
        writer.writeByte(9);
        break;
      case Class.D6:
        writer.writeByte(10);
        break;
      case Class.D7A:
        writer.writeByte(11);
        break;
      case Class.D7B:
        writer.writeByte(12);
        break;
      case Class.D7C:
        writer.writeByte(13);
        break;
      case Class.D8:
        writer.writeByte(14);
        break;
      case Class.D9A:
        writer.writeByte(15);
        break;
      case Class.D9B:
        writer.writeByte(16);
        break;
      case Class.D10A:
        writer.writeByte(17);
        break;
      case Class.D10B:
        writer.writeByte(18);
        break;
      case Class.MCA2A:
        writer.writeByte(19);
        break;
      case Class.MCA2B:
        writer.writeByte(20);
        break;
      case Class.D11A:
        writer.writeByte(21);
        break;
      case Class.D11B:
        writer.writeByte(22);
        break;
      case Class.D12A:
        writer.writeByte(23);
        break;
      case Class.D12B:
        writer.writeByte(24);
        break;
      case Class.D12C:
        writer.writeByte(25);
        break;
      case Class.D13:
        writer.writeByte(26);
        break;
      case Class.D14A:
        writer.writeByte(27);
        break;
      case Class.D14B:
        writer.writeByte(28);
        break;
      case Class.D15:
        writer.writeByte(29);
        break;
      case Class.MCA3A:
        writer.writeByte(30);
        break;
      case Class.MCA3B:
        writer.writeByte(31);
        break;
      case Class.D16A:
        writer.writeByte(32);
        break;
      case Class.D16B:
        writer.writeByte(33);
        break;
      case Class.D17A:
        writer.writeByte(34);
        break;
      case Class.D17B:
        writer.writeByte(35);
        break;
      case Class.D17C:
        writer.writeByte(36);
        break;
      case Class.D18:
        writer.writeByte(37);
        break;
      case Class.D19A:
        writer.writeByte(38);
        break;
      case Class.D19B:
        writer.writeByte(39);
        break;
      case Class.D19C:
        writer.writeByte(40);
        break;
      case Class.D20:
        writer.writeByte(41);
        break;
      case Class.Division:
        writer.writeByte(42);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
