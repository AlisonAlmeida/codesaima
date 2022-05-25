import 'package:hive_flutter/hive_flutter.dart';
part 'resident_familiar.g.dart';

@HiveType(typeId: 5)
class ResidentFamiliar {
  ResidentFamiliar({
    this.name = '',
    this.birthDate,
    this.cpf = '',
    this.kinship = '',
    this.deficient,
  });
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime? birthDate;

  @HiveField(2)
  final String cpf;

  @HiveField(3)
  final String kinship;

  @HiveField(4)
  final bool? deficient;
}
