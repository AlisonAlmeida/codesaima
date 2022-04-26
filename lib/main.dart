// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/core/address_model.dart';
import 'package:codesaima/core/person_model.dart';
import 'package:codesaima/screens/home_page_screen.dart';
import 'package:codesaima/screens/search_pages/morar_melhor_search_screen.dart';
import 'package:codesaima/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();

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
      theme: ThemeData(
        primarySwatch: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.orange[50],
          filled: true,
        ),
      ),
      home: HomePage(title: 'Codesaima'),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
