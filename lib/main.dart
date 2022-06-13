// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:codesaima/models/address_model.dart';
import 'package:codesaima/models/deficient_person_model.dart';
import 'package:codesaima/models/person_spouse.dart';
import 'package:codesaima/models/register_person_morar_melhor_model.dart';
import 'package:codesaima/models/resident_familiar.dart';
import 'package:codesaima/models/simple_person_model.dart';
import 'package:codesaima/models/social_networks.dart';
import 'package:codesaima/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/edifice_information_model.dart';

Future main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(AddressAdapter());
  await Hive.openBox<Address>(kAddressBox);
  Hive.registerAdapter(DeficientPersonAdapter());
  await Hive.openBox<DeficientPerson>(kDeficientPersonBox);
  Hive.registerAdapter(SocialNetworksAdapter());
  await Hive.openBox<SocialNetworks>(kSocialNetworksBox);
  Hive.registerAdapter(SimplePersonAdapter());
  await Hive.openBox<SimplePerson>(kSimplePersonBox);
  Hive.registerAdapter(PersonSpouseAdapter());
  await Hive.openBox<PersonSpouseAdapter>(kPersonSpouseBox);
  Hive.registerAdapter(ResidentFamiliarAdapter());
  await Hive.openBox<ResidentFamiliar>(kResidentFamiliarBox);
  Hive.registerAdapter(EdificeInformationAdapter());
  await Hive.openBox<EdificeInformation>(kEdificeInformationBox);

  Hive.registerAdapter(RegisterMorarMelhorAdapter());
  await Hive.openBox<RegisterMorarMelhor>(kCompletePersonBox);

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
