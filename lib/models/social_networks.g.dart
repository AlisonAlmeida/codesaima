// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_networks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SocialNetworksAdapter extends TypeAdapter<SocialNetworks> {
  @override
  final int typeId = 6;

  @override
  SocialNetworks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialNetworks(
      facebook: fields[0] as bool?,
      instagram: fields[1] as bool?,
      whatsapp: fields[2] as bool?,
      youtube: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, SocialNetworks obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.facebook)
      ..writeByte(1)
      ..write(obj.instagram)
      ..writeByte(2)
      ..write(obj.whatsapp)
      ..writeByte(3)
      ..write(obj.youtube);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialNetworksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
