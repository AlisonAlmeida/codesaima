// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimplePersonAdapter extends TypeAdapter<SimplePerson> {
  @override
  final int typeId = 0;

  @override
  SimplePerson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimplePerson(
      name: fields[0] as String,
      phone: fields[1] as String,
      socialNetworks: fields[2] as SocialNetworks?,
      address: fields[3] as Address?,
    );
  }

  @override
  void write(BinaryWriter writer, SimplePerson obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.socialNetworks)
      ..writeByte(3)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimplePersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
