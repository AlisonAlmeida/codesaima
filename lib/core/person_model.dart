import 'package:codesaima/core/address_model.dart';
import 'package:hive/hive.dart';
part 'person_model.g.dart';

// to generate model.g.dart run> flutter pub run build_runner build

@HiveType(typeId: 0)
class Person {
  Person({
    this.id,
    required this.name,
    required this.phone,
    required this.socialNetworks,
    required this.addressModel,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int phone;

  @HiveField(3)
  List<String> socialNetworks;

  @HiveField(4)
  AddressModel addressModel;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      socialNetworks: json['socialNetworks'],
      addressModel: json['addressModel']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'socialNetworks': socialNetworks
    };
  }
}
