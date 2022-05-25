import 'package:codesaima/models/resident_familiar.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'deficient_person_model.g.dart';

@HiveType(typeId: 3)
class DeficientPerson extends ResidentFamiliar {
  DeficientPerson({required this.deficientPersonCID});

  @HiveField(5)
  final String deficientPersonCID;
}
