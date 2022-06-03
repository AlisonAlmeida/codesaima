import 'package:codesaima/models/social_networks.dart';
import 'package:codesaima/models/person_spouse.dart';
import 'package:codesaima/models/resident_familiar.dart';
import 'address_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'register_person_morar_melhor_model.g.dart';

// to generate model.g.dart run> flutter pub run build_runner build

//to delete conflict run> flutter pub run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 2)
class RegisterMorarMelhor {
  RegisterMorarMelhor({
    this.name = '',
    this.birthDate = '',
    this.sex = '',
    this.nacionality = '',
    this.originUF = '',
    this.originCity = '',
    this.mothersName = '',
    this.fathersName = '',
    this.phoneList,
    this.socialNetworks,
    this.typeOfDocument = '',
    this.numberDocument = '',
    this.issueDocument = '',
    this.ufDocument = '',
    this.dateIssueDocument = '',
    this.pisNisPasep = '',
    this.cpf = '',
    this.profession = '',
    this.address,
    this.educationLevel = '',
    this.individualCash = '',
    this.familiarCash = '',
    this.residentFamiliar,
    this.howMuchTimeLiveRoraima = '',
    this.howMuchTimeLiveHome = '',
    this.observations = '',
    this.singleMother,
    this.personSpouse,
    this.maritalStatus = '',
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String>? phoneList;

  @HiveField(2)
  final SocialNetworks? socialNetworks;

  @HiveField(3)
  final Address? address;

  @HiveField(4)
  final String birthDate;

  @HiveField(5)
  final String sex;

  @HiveField(6)
  final String nacionality;

  @HiveField(7)
  final String mothersName;

  @HiveField(8)
  final String fathersName;

  @HiveField(9)
  final String typeOfDocument; //RG, CNH, CTPS, RNM, etc

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
  final String individualCash;

  @HiveField(20)
  final PersonSpouse? personSpouse;

  @HiveField(21)
  final String originUF;

  @HiveField(22)
  final String originCity;

  @HiveField(23)
  final String familiarCash;

  @HiveField(24)
  final List<ResidentFamiliar>? residentFamiliar;

  @HiveField(25)
  final String howMuchTimeLiveRoraima;

  @HiveField(26)
  final String howMuchTimeLiveHome;

  @HiveField(27)
  final String observations;

  @HiveField(28)
  final bool? singleMother;

  factory RegisterMorarMelhor.fromMap(Map<String, dynamic> json) =>
      RegisterMorarMelhor(
        name: json['name'],
        phoneList: json['phoneList'],
        socialNetworks: json['socialNetworks'],
        address: json['address'],
        birthDate: json['birthDate'],
        sex: json['sex'],
        nacionality: json['nacionality'],
        mothersName: json['mothersName'],
        fathersName: json['fathersName'],
        typeOfDocument: json['typeOfDocument'],
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
        originUF: json['origenUF'],
        originCity: json['originCity'],
        familiarCash: json['familiarCash'],
        residentFamiliar: json['residentFamiliar'],
        howMuchTimeLiveRoraima: json['howMuchTimeLiveRoraima'],
        howMuchTimeLiveHome: json['howMuchTimeLiveHome'],
        observations: json['observations'],
        singleMother: json['singleMother'],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneList': phoneList,
      'socialNetworks': SocialNetworks,
      'address': Address,
      'birthDate': birthDate,
      'sex': sex,
      'nacionality': nacionality,
      'mothersName': mothersName,
      'fathersName': fathersName,
      'typeOfDocument': typeOfDocument,
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
      'originUF': originUF,
      'originCity': originCity,
      'familiarCash': familiarCash,
      'residentFamiliar': ResidentFamiliar,
      'howMuchTimeLiveRoraima': howMuchTimeLiveRoraima,
      'howMuchTimeLiveHome': howMuchTimeLiveHome,
      'observations': observations,
      'singleMother': singleMother,
    };
  }
}
