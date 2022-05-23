import 'package:hive/hive.dart';

class PersonSpouse {
  PersonSpouse({
    this.name = '',
    this.birthDate,
    this.sex = '',
    this.nacionality = '',
    this.origenUF = '',
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
    this.individualCash = 0.0,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime? birthDate;

  @HiveField(2)
  final String sex;

  @HiveField(3)
  final String nacionality;

  @HiveField(4)
  final String origenUF;

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
  final double individualCash;
}
