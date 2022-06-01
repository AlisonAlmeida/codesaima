// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_person_morar_melhor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterMorarMelhorAdapter extends TypeAdapter<RegisterMorarMelhor> {
  @override
  final int typeId = 2;

  @override
  RegisterMorarMelhor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterMorarMelhor(
      howMuchTimeLiveRoraima: fields[25] as String,
      howMuchTimeLiveHome: fields[26] as String,
      observations: fields[27] as String,
      singleMother: fields[28] as bool?,
      familiarCash: fields[23] as double,
      origemUF: fields[21] as String,
      personSpouse: fields[20] as PersonSpouse?,
      origenCity: fields[22] as String,
      maritalStatus: fields[17] as String,
      educationLevel: fields[18] as String,
      individualCash: fields[19] as double,
      birthDate: fields[4] as String,
      sex: fields[5] as String,
      nacionality: fields[6] as String,
      mothersName: fields[7] as String,
      fathersName: fields[8] as String,
      typeOfDocument: fields[9] as String,
      numberDocument: fields[10] as String,
      issueDocument: fields[11] as String,
      ufDocument: fields[12] as String,
      dateIssueDocument: fields[13] as String,
      pisNisPasep: fields[14] as String,
      cpf: fields[15] as String,
      profession: fields[16] as String,
      name: fields[0] as String,
      phone: fields[1] as String,
      socialNetworks: fields[2] as SocialNetworks?,
      address: fields[3] as Address?,
      residentFamiliar: (fields[24] as List?)?.cast<ResidentFamiliar>(),
    );
  }

  @override
  void write(BinaryWriter writer, RegisterMorarMelhor obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.socialNetworks)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.birthDate)
      ..writeByte(5)
      ..write(obj.sex)
      ..writeByte(6)
      ..write(obj.nacionality)
      ..writeByte(7)
      ..write(obj.mothersName)
      ..writeByte(8)
      ..write(obj.fathersName)
      ..writeByte(9)
      ..write(obj.typeOfDocument)
      ..writeByte(10)
      ..write(obj.numberDocument)
      ..writeByte(11)
      ..write(obj.issueDocument)
      ..writeByte(12)
      ..write(obj.ufDocument)
      ..writeByte(13)
      ..write(obj.dateIssueDocument)
      ..writeByte(14)
      ..write(obj.pisNisPasep)
      ..writeByte(15)
      ..write(obj.cpf)
      ..writeByte(16)
      ..write(obj.profession)
      ..writeByte(17)
      ..write(obj.maritalStatus)
      ..writeByte(18)
      ..write(obj.educationLevel)
      ..writeByte(19)
      ..write(obj.individualCash)
      ..writeByte(20)
      ..write(obj.personSpouse)
      ..writeByte(21)
      ..write(obj.origemUF)
      ..writeByte(22)
      ..write(obj.origenCity)
      ..writeByte(23)
      ..write(obj.familiarCash)
      ..writeByte(24)
      ..write(obj.residentFamiliar)
      ..writeByte(25)
      ..write(obj.howMuchTimeLiveRoraima)
      ..writeByte(26)
      ..write(obj.howMuchTimeLiveHome)
      ..writeByte(27)
      ..write(obj.observations)
      ..writeByte(28)
      ..write(obj.singleMother);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterMorarMelhorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
