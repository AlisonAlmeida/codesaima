import 'package:flutter/material.dart';

const String kAppName = 'Codesaima';

const String kPathMainLogoCodesaima = 'lib/assets/images/logo_codesaima.png';
const String kPathMainLogoCodesaimaBranca =
    'lib/assets/images/logo_codesaima_branca.png';
const String kPathLogoMorarMelhor = 'lib/assets/images/logo_morar_melhor.png';
const String kPathLogoAquiTemDono = 'lib/assets/images/logo_aqui_tem_dono.png';
const String kPathLogoGovRoraimaPreta = 'lib/assets/images/logo_gov_preta.png';
const String kPathLogoFacebook =
    'lib/assets/images/logotipo-circular-do-facebook.png';
const String kPathLogoInstagram =
    'lib/assets/images/logotipo-circular-do-instagram.png';
const String kPathLogoYoutube =
    'lib/assets/images/logotipo-circular-do-youtube.png';
const String kPathLogoWhatsapp =
    'lib/assets/images/logotipo-circular-do-whatsapp.png';

final kTextFieldDecorationMorarMelhor = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  fillColor: Colors.brown[50],
  filled: true,
);

final kGeneralThemeData = ThemeData(primarySwatch: Colors.red);
final kMorarMelhorThemeData = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.orange[50],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      )),
  primarySwatch: Colors.orange,
);

const List<DropdownMenuItem<String>> dropdownCities = [
  DropdownMenuItem(child: Text('Amajari'), value: 'Amajari'),
  DropdownMenuItem(child: Text('Alto Alegre'), value: 'Alto Alegre'),
  DropdownMenuItem(child: Text('Boa Vista'), value: 'Boa Vista'),
  DropdownMenuItem(child: Text('Bonfim'), value: 'Bonfim'),
  DropdownMenuItem(child: Text('Cantá'), value: 'Cantá'),
  DropdownMenuItem(child: Text('Caracaraí'), value: 'Caracaraí'),
  DropdownMenuItem(child: Text('Caroebe'), value: 'Caroebe'),
  DropdownMenuItem(child: Text('Iracema'), value: 'Iracema'),
  DropdownMenuItem(child: Text('Mucajaí'), value: 'Mucajaí'),
  DropdownMenuItem(child: Text('Normandia'), value: 'Normandia'),
  DropdownMenuItem(child: Text('Pacaraima'), value: 'Pacaraima'),
  DropdownMenuItem(child: Text('Rorainópolis'), value: 'Rorainópolis'),
  DropdownMenuItem(
      child: Text('São João da Baliza'), value: 'São João da Baliza'),
  DropdownMenuItem(child: Text('São Luiz'), value: 'São Luiz'),
  DropdownMenuItem(child: Text('Uiramutã'), value: 'Uiramutã'),
];
