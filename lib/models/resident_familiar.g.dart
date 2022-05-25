// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resident_familiar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResidentFamiliarAdapter extends TypeAdapter<ResidentFamiliar> {
  @override
  final int typeId = 5;

  @override
  ResidentFamiliar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResidentFamiliar(
      name: fields[0] as String,
      birthDate: fields[1] as DateTime?,
      cpf: fields[2] as String,
      kinship: fields[3] as String,
      deficient: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ResidentFamiliar obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthDate)
      ..writeByte(2)
      ..write(obj.cpf)
      ..writeByte(3)
      ..write(obj.kinship)
      ..writeByte(4)
      ..write(obj.deficient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResidentFamiliarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
