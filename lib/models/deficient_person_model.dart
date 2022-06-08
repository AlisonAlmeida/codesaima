import 'package:hive_flutter/hive_flutter.dart';
part 'deficient_person_model.g.dart';

@HiveType(typeId: 3)
class DeficientPerson {
  DeficientPerson({
    this.name = '',
    this.cid = '',
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String cid;
}
