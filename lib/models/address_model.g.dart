// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 1;

  @override
  Address read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Address(
      cep: fields[0] as String,
      logradouro: fields[1] as String,
      complemento: fields[2] as String,
      bairro: fields[3] as String,
      localidade: fields[4] as String,
      uf: fields[5] as String,
      ibge: fields[6] as String,
      gia: fields[7] as String,
      ddd: fields[8] as String,
      siafi: fields[9] as String,
      numero: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.cep)
      ..writeByte(1)
      ..write(obj.logradouro)
      ..writeByte(2)
      ..write(obj.complemento)
      ..writeByte(3)
      ..write(obj.bairro)
      ..writeByte(4)
      ..write(obj.localidade)
      ..writeByte(5)
      ..write(obj.uf)
      ..writeByte(6)
      ..write(obj.ibge)
      ..writeByte(7)
      ..write(obj.gia)
      ..writeByte(8)
      ..write(obj.ddd)
      ..writeByte(9)
      ..write(obj.siafi)
      ..writeByte(10)
      ..write(obj.numero);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
