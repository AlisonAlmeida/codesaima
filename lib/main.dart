// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:codesaima/models/address_model.dart';
import 'package:codesaima/models/person_model.dart';
import 'package:codesaima/core/social_networks.dart';
import 'package:codesaima/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(AddressAdapter());
  await Hive.openBox<Address>('address');
  Hive.registerAdapter(SocialNetworksAdapter());
  await Hive.openBox<SocialNetworks>('social_Networks');
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox<Person>('personList');

  //await Hive.deleteFromDisk(); //DELETE DATABASE

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
