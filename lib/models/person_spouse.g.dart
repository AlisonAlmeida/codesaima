// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_spouse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonSpouseAdapter extends TypeAdapter<PersonSpouse> {
  @override
  final int typeId = 4;

  @override
  PersonSpouse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonSpouse(
      name: fields[0] as String,
      birthDate: fields[1] as String,
      sex: fields[2] as String,
      nacionality: fields[3] as String,
      originUF: fields[4] as String,
      originCity: fields[5] as String,
      mothersName: fields[6] as String,
      numberDocument: fields[7] as String,
      issueDocument: fields[8] as String,
      ufDocument: fields[9] as String,
      dateIssueDocument: fields[10] as String,
      pisNisPasep: fields[11] as String,
      cpf: fields[12] as String,
      profession: fields[13] as String,
      phoneNumber: fields[14] as String,
      educationLevel: fields[15] as String,
      individualCash: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonSpouse obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthDate)
      ..writeByte(2)
      ..write(obj.sex)
      ..writeByte(3)
      ..write(obj.nacionality)
      ..writeByte(4)
      ..write(obj.originUF)
      ..writeByte(5)
      ..write(obj.originCity)
      ..writeByte(6)
      ..write(obj.mothersName)
      ..writeByte(7)
      ..write(obj.numberDocument)
      ..writeByte(8)
      ..write(obj.issueDocument)
      ..writeByte(9)
      ..write(obj.ufDocument)
      ..writeByte(10)
      ..write(obj.dateIssueDocument)
      ..writeByte(11)
      ..write(obj.pisNisPasep)
      ..writeByte(12)
      ..write(obj.cpf)
      ..writeByte(13)
      ..write(obj.profession)
      ..writeByte(14)
      ..write(obj.phoneNumber)
      ..writeByte(15)
      ..write(obj.educationLevel)
      ..writeByte(16)
      ..write(obj.individualCash);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonSpouseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
