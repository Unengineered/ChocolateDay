// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'india_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndiaStateAdapter extends TypeAdapter<IndiaState> {
  @override
  final int typeId = 42;

  @override
  IndiaState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return IndiaState.AndhraPradesh;
      case 2:
        return IndiaState.ArunachalPradesh;
      case 3:
        return IndiaState.Assam;
      case 4:
        return IndiaState.Bihar;
      case 5:
        return IndiaState.Chhattisgarh;
      case 6:
        return IndiaState.Goa;
      case 7:
        return IndiaState.Gujrat;
      case 8:
        return IndiaState.Haryana;
      case 9:
        return IndiaState.HimachalPradesh;
      case 10:
        return IndiaState.Jharkhand;
      case 11:
        return IndiaState.Karnataka;
      case 12:
        return IndiaState.Kerla;
      case 13:
        return IndiaState.MadhyaPradesh;
      case 14:
        return IndiaState.Maharashtra;
      case 15:
        return IndiaState.Manipur;
      case 16:
        return IndiaState.Meghalaya;
      case 17:
        return IndiaState.Mizoram;
      case 18:
        return IndiaState.Nagaland;
      case 19:
        return IndiaState.Odisha;
      case 20:
        return IndiaState.Punjab;
      case 21:
        return IndiaState.Rajasthan;
      case 22:
        return IndiaState.Sikkim;
      case 23:
        return IndiaState.TamilNadu;
      case 24:
        return IndiaState.Telangana;
      case 25:
        return IndiaState.Tripura;
      case 26:
        return IndiaState.UttarPradesh;
      case 27:
        return IndiaState.Uttarakhand;
      case 28:
        return IndiaState.WestBengal;
      case 29:
        return IndiaState.AndamanAndNicobarIslands;
      case 30:
        return IndiaState.Chandigarh;
      case 31:
        return IndiaState.DadraAndNagarHaveliAndDamanAndDiu;
      case 32:
        return IndiaState.Delhi;
      case 33:
        return IndiaState.JammuAndKashmir;
      case 34:
        return IndiaState.Ladakh;
      case 35:
        return IndiaState.Lakshadweep;
      case 36:
        return IndiaState.Puducherry;
      case 37:
        return IndiaState.State;
      default:
        return IndiaState.AndhraPradesh;
    }
  }

  @override
  void write(BinaryWriter writer, IndiaState obj) {
    switch (obj) {
      case IndiaState.AndhraPradesh:
        writer.writeByte(1);
        break;
      case IndiaState.ArunachalPradesh:
        writer.writeByte(2);
        break;
      case IndiaState.Assam:
        writer.writeByte(3);
        break;
      case IndiaState.Bihar:
        writer.writeByte(4);
        break;
      case IndiaState.Chhattisgarh:
        writer.writeByte(5);
        break;
      case IndiaState.Goa:
        writer.writeByte(6);
        break;
      case IndiaState.Gujrat:
        writer.writeByte(7);
        break;
      case IndiaState.Haryana:
        writer.writeByte(8);
        break;
      case IndiaState.HimachalPradesh:
        writer.writeByte(9);
        break;
      case IndiaState.Jharkhand:
        writer.writeByte(10);
        break;
      case IndiaState.Karnataka:
        writer.writeByte(11);
        break;
      case IndiaState.Kerla:
        writer.writeByte(12);
        break;
      case IndiaState.MadhyaPradesh:
        writer.writeByte(13);
        break;
      case IndiaState.Maharashtra:
        writer.writeByte(14);
        break;
      case IndiaState.Manipur:
        writer.writeByte(15);
        break;
      case IndiaState.Meghalaya:
        writer.writeByte(16);
        break;
      case IndiaState.Mizoram:
        writer.writeByte(17);
        break;
      case IndiaState.Nagaland:
        writer.writeByte(18);
        break;
      case IndiaState.Odisha:
        writer.writeByte(19);
        break;
      case IndiaState.Punjab:
        writer.writeByte(20);
        break;
      case IndiaState.Rajasthan:
        writer.writeByte(21);
        break;
      case IndiaState.Sikkim:
        writer.writeByte(22);
        break;
      case IndiaState.TamilNadu:
        writer.writeByte(23);
        break;
      case IndiaState.Telangana:
        writer.writeByte(24);
        break;
      case IndiaState.Tripura:
        writer.writeByte(25);
        break;
      case IndiaState.UttarPradesh:
        writer.writeByte(26);
        break;
      case IndiaState.Uttarakhand:
        writer.writeByte(27);
        break;
      case IndiaState.WestBengal:
        writer.writeByte(28);
        break;
      case IndiaState.AndamanAndNicobarIslands:
        writer.writeByte(29);
        break;
      case IndiaState.Chandigarh:
        writer.writeByte(30);
        break;
      case IndiaState.DadraAndNagarHaveliAndDamanAndDiu:
        writer.writeByte(31);
        break;
      case IndiaState.Delhi:
        writer.writeByte(32);
        break;
      case IndiaState.JammuAndKashmir:
        writer.writeByte(33);
        break;
      case IndiaState.Ladakh:
        writer.writeByte(34);
        break;
      case IndiaState.Lakshadweep:
        writer.writeByte(35);
        break;
      case IndiaState.Puducherry:
        writer.writeByte(36);
        break;
      case IndiaState.State:
        writer.writeByte(37);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndiaStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
