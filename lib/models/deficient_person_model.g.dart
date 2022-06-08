// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deficient_person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeficientPersonAdapter extends TypeAdapter<DeficientPerson> {
  @override
  final int typeId = 3;

  @override
  DeficientPerson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeficientPerson(
      name: fields[0] as String,
      cid: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeficientPerson obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeficientPersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
