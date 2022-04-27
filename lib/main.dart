// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/address_model.dart';
import 'package:codesaima/core/person_model.dart';
import 'package:codesaima/screens/home_page_screen.dart';
import 'package:codesaima/screens/crup_person.dart';
import 'package:codesaima/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  await Hive.initFlutter();

  await Hive.openBox('address');
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(AddressAdapter());
  await Hive.openBox<Person>('personList');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kGeneralThemeData,
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
