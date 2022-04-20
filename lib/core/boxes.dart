import 'package:hive/hive.dart';
import 'person_model.dart';

class Boxes {
  static Box<Person> getPeople() => Hive.box<Person>('people');
  static Box<Person> getAddress() => Hive.box<Person>('address');
}
