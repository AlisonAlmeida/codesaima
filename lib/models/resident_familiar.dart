import 'package:hive_flutter/hive_flutter.dart';
part 'resident_familiar.g.dart';

@HiveType(typeId: 5)
class ResidentFamiliar {
  ResidentFamiliar({
    this.name = '',
    this.birthDate = '',
    this.cpf = '',
    this.kinship = '', //parentesco
    this.deficient,
  });
  @HiveField(0)
  String name;

  @HiveField(1)
  String birthDate;
  @HiveField(2)
  String cpf;

  @HiveField(3)
  String kinship; //parentesco

  @HiveField(4)
  String? deficient;
}
