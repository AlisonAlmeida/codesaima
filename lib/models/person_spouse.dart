import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'person_spouse.g.dart';

@HiveType(typeId: 4)
class PersonSpouse {
  PersonSpouse({
    this.name = '',
    this.birthDate = '',
    this.sex = '',
    this.nacionality = '',
    this.originUF = '',
    this.origenCity = '',
    this.mothersName = '',
    this.numberDocument = '',
    this.issueDocument = '',
    this.ufDocument = '',
    this.dateIssueDocument = '',
    this.pisNisPasep = '',
    this.cpf = '',
    this.profession = '',
    this.phoneNumber = '',
    this.educationLevel = '',
    this.individualCash = '',
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  late final String birthDate;

  @HiveField(2)
  final String sex;

  @HiveField(3)
  final String nacionality;

  @HiveField(4)
  final String originUF;

  @HiveField(5)
  final String origenCity;

  @HiveField(6)
  final String mothersName;

  @HiveField(7)
  final String numberDocument;

  @HiveField(8)
  final String issueDocument;

  @HiveField(9)
  final String ufDocument;

  @HiveField(10)
  final String dateIssueDocument;

  @HiveField(11)
  final String pisNisPasep;

  @HiveField(12)
  final String cpf;

  @HiveField(13)
  final String profession;

  @HiveField(14)
  final String phoneNumber;

  @HiveField(15)
  final String educationLevel;

  @HiveField(16)
  final String individualCash;

  factory PersonSpouse.fromMap(Map<String, dynamic> json) => PersonSpouse(
        name: json['name'],
        birthDate: json['birthDate'],
        sex: json['sex'],
        nacionality: json['nacionality'],
        mothersName: json['mothersName'],
        numberDocument: json['numberDocument'],
        issueDocument: json['issueDocument'],
        ufDocument: json['ufDocument'],
        dateIssueDocument: json['dateIssueDocument'],
        pisNisPasep: json['pisNisPasep'],
        cpf: json['cpf'],
        profession: json['profession'],
        educationLevel: json['educationLevel'],
        individualCash: json['individualCash'],
        originUF: json['originUF'],
        origenCity: json['origenCity'],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthDate': birthDate,
      'sex': sex,
      'nacionality': nacionality,
      'mothersName': mothersName,
      'numberDocument': numberDocument,
      'issueDocument': issueDocument,
      'ufDocument': ufDocument,
      'dateIssueDocument': dateIssueDocument,
      'pisNisPasep': pisNisPasep,
      'cpf': cpf,
      'profession': profession,
      'educationLevel': educationLevel,
      'individualCash': individualCash,
      'personSpouse': PersonSpouse,
      'origemUF': originUF,
      'origenCity': origenCity,
    };
  }
}
