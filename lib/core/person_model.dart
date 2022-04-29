import 'package:codesaima/core/address_model.dart';
import 'package:hive/hive.dart';
part 'person_model.g.dart';

// to generate model.g.dart run> flutter pub run build_runner build

@HiveType(typeId: 0)
class Person {
  Person({
    this.name = '',
    this.phone = '',
    this.socialNetworks,
    this.address,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  List<String>? socialNetworks;

  @HiveField(3)
  Address? address;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
      name: json['name'],
      phone: json['phone'],
      socialNetworks: json['socialNetworks'],
      address: json['address']);

  Map<String, dynamic> toMap() {
    return {
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
