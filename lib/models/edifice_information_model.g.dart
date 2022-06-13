// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edifice_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EdificeInformationAdapter extends TypeAdapter<EdificeInformation> {
  @override
  final int typeId = 7;

  @override
  EdificeInformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EdificeInformation(
      residenceSituation: fields[12] as String,
      localizationResidence: fields[1] as String,
      supplyWaterSystem: fields[2] as String,
      kindConstruction: fields[3] as String,
      kindFloor: fields[4] as String,
      garbageCollection: fields[5] as String,
      electricalNetwork: fields[6] as String,
      sewerage: fields[7] as String,
      hasInternalBathroom: fields[8] as String,
      numberFamiliesLiveResidence: fields[9] as String,
      numberResidentFamiliarLiveResidence: fields[10] as String,
      numberRoomResidence: fields[11] as String,
      kindResidence: fields[0] as String,
      reformNeed: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EdificeInformation obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.kindResidence)
      ..writeByte(1)
      ..write(obj.localizationResidence)
      ..writeByte(2)
      ..write(obj.supplyWaterSystem)
      ..writeByte(3)
      ..write(obj.kindConstruction)
      ..writeByte(4)
      ..write(obj.kindFloor)
      ..writeByte(5)
      ..write(obj.garbageCollection)
      ..writeByte(6)
      ..write(obj.electricalNetwork)
      ..writeByte(7)
      ..write(obj.sewerage)
      ..writeByte(8)
      ..write(obj.hasInternalBathroom)
      ..writeByte(9)
      ..write(obj.numberFamiliesLiveResidence)
      ..writeByte(10)
      ..write(obj.numberResidentFamiliarLiveResidence)
      ..writeByte(11)
      ..write(obj.numberRoomResidence)
      ..writeByte(12)
      ..write(obj.residenceSituation)
      ..writeByte(13)
      ..write(obj.reformNeed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EdificeInformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
