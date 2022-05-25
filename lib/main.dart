// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:codesaima/models/address_model.dart';
import 'package:codesaima/models/complete_person_model.dart';
import 'package:codesaima/models/simple_person_model.dart';
import 'package:codesaima/models/social_networks.dart';
import 'package:codesaima/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(AddressAdapter());
  await Hive.openBox<Address>(kAddressBox);
  Hive.registerAdapter(SocialNetworksAdapter());
  await Hive.openBox<SocialNetworks>(kSocialNetworksBox);
  Hive.registerAdapter(SimplePersonAdapter());
  await Hive.openBox<SimplePerson>(kSimplePersonBox);
  Hive.registerAdapter(CompletePersonAdapter());
  await Hive.openBox<CompletePerson>(kCompletePersonBox);

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
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('pt')],
    );
  }
}
