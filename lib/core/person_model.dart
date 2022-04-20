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
    required this.address,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  List<String> socialNetworks;

  @HiveField(4)
  Address address;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      socialNetworks: json['socialNetworks'],
      address: json['address']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'socialNetworks': socialNetworks,
      'address': address
    };
  }

  @override
  String toString() {
    return 'Nome: $name, Telefone: $phone, Social Media: $socialNetworks, Endereço: ${address.toString()}';
  }
}
