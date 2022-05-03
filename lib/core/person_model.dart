import 'package:codesaima/core/social_networks.dart';

import 'address_model.dart';
import 'package:hive/hive.dart';

part 'person_model.g.dart';

// to generate model.g.dart run> flutter pub run build_runner build

//to delete conflict run> flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 0)
class Person {
  Person({
    this.name = '',
    this.phone = '',
    this.socialNetworks,
    this.address,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final SocialNetworks? socialNetworks;

  @HiveField(3)
  final Address? address;

  factory Person.fromMap(Map<String, dynamic> json) => Person(
      name: json['name'],
      phone: json['phone'],
      socialNetworks: json['socialNetworks'],
      address: json['address']);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'socialNetworks': SocialNetworks,
      'address': address
    };
  }

  @override
  String toString() {
    return 'Nome: $name, Telefone: $phone, Social Media: $socialNetworks, Endereço: ${address.toString()}';
  }
}
