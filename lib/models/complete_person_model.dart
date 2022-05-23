import 'package:codesaima/core/social_networks.dart';
import 'package:codesaima/models/person_spouse.dart';
import 'package:codesaima/models/resident_familiar.dart';
import 'address_model.dart';
import 'package:hive/hive.dart';

// to generate model.g.dart run> flutter pub run build_runner build

//to delete conflict run> flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 0)
class CompletePerson {
  CompletePerson(
      {this.howMuchTimeLiveRoraima = '',
      this.howMuchTimeLiveHome = '',
      this.observations = '',
      this.singleMother,
      this.familiarCash = 0,
      this.deficientPersonName = '',
      this.deficientPersonCID = '',
      this.origemUF = '',
      this.personSpouse,
      this.origenCity = '',
      this.maritalStatus = '',
      this.educationLevel = '',
      this.individualCash = 0.0,
      this.birthDate,
      this.sex = '',
      this.nacionality = '',
      this.mothersName = '',
      this.fathersName = '',
      this.tipeOfDocument = '',
      this.numberDocument = '',
      this.issueDocument = '',
      this.ufDocument = '',
      this.dateIssueDocument = '',
      this.pisNisPasep = '',
      this.cpf = '',
      this.profession = '',
      this.name = '',
      this.phone = '',
      this.socialNetworks,
      this.address,
      this.residentFamiliar});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final SocialNetworks? socialNetworks;

  @HiveField(3)
  final Address? address;

  @HiveField(4)
  final DateTime? birthDate;

  @HiveField(5)
  final String sex;

  @HiveField(6)
  final String nacionality;

  @HiveField(7)
  final String mothersName;

  @HiveField(8)
  final String fathersName;

  @HiveField(9)
  final String tipeOfDocument; //RG, CNH, CTPS, RNM, etc

  @HiveField(10)
  final String numberDocument;

  @HiveField(11)
  final String issueDocument;

  @HiveField(12)
  final String ufDocument;

  @HiveField(13)
  final String dateIssueDocument;

  @HiveField(14)
  final String pisNisPasep;

  @HiveField(15)
  final String cpf;

  @HiveField(16)
  final String profession;

  @HiveField(17)
  final String maritalStatus;

  @HiveField(18)
  final String educationLevel;

  @HiveField(19)
  final double individualCash;

  @HiveField(20)
  final PersonSpouse? personSpouse;

  @HiveField(21)
  final String origemUF;

  @HiveField(22)
  final String origenCity;

  @HiveField(23)
  final double familiarCash;

  @HiveField(24)
  final String deficientPersonName;

  @HiveField(25)
  final String deficientPersonCID;

  @HiveField(25)
  final List<ResidentFamiliar>? residentFamiliar;

  @HiveField(27)
  final String howMuchTimeLiveRoraima;

  @HiveField(28)
  final String howMuchTimeLiveHome;

  @HiveField(29)
  final String observations;

  @HiveField(30)
  final bool? singleMother;

  @HiveField(30)
  final bool? singleMother;

  factory CompletePerson.fromMap(Map<String, dynamic> json) => CompletePerson(
        name: json['name'],
        phone: json['phone'],
        socialNetworks: json['socialNetworks'],
        address: json['address'],
        birthDate: json['birthDate'],
        sex: json['sex'],
        nacionality: json['nacionality'],
        mothersName: json['mothersName'],
        fathersName: json['fathersName'],
        tipeOfDocument: json['tipeOfDocument'],
        numberDocument: json['numberDocument'],
        issueDocument: json['issueDocument'],
        ufDocument: json['ufDocument'],
        dateIssueDocument: json['dateIssueDocument'],
        pisNisPasep: json['pisNisPasep'],
        cpf: json['cpf'],
        profession: json['profession'],
        maritalStatus: json['maritalStatus'],
        educationLevel: json['educationLevel'],
        individualCash: json['individualCash'],
        personSpouse: json['personSpouse'],
        origemUF: json['origenUF'],
        origenCity: json['origenCity'],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'socialNetworks': SocialNetworks,
      'address': Address,
      'birthDate': birthDate,
      'sex': sex,
      'nacionality': nacionality,
      'mothersName': mothersName,
      'fathersName': fathersName,
      'tipeOfDocument': tipeOfDocument,
      'numberDocument': numberDocument,
      'issueDocument': issueDocument,
      'ufDocument': ufDocument,
      'dateIssueDocument': dateIssueDocument,
      'pisNisPasep': pisNisPasep,
      'cpf': cpf,
      'profession': profession,
      'maritalStatus': maritalStatus,
      'educationLevel': educationLevel,
      'individualCash': individualCash,
      'personSpouse': PersonSpouse,
      'origemUF': origemUF,
      'origenCity': origenCity,
    };
  }

  @override
  String toString() {
    return 'Nome: $name, Telefone: $phone, Social Media: $socialNetworks, Endereço: ${address.toString()}';
  }
}
