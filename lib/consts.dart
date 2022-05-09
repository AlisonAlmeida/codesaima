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
const String kPathEdificeCodesaimaBackground =
    'lib/assets/images/edifice_codesaima_background.jpg';

final kTextFieldDecorationMorarMelhor = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  fillColor: Colors.orange[50],
  filled: true,
);

final kGeneralThemeData = ThemeData(primarySwatch: Colors.red);
final kMorarMelhorThemeData = ThemeData(
  backgroundColor: Colors.orange[700],
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
  DropdownMenuItem(child: Text('AMAJARI'), value: 'AMAJARI'),
  DropdownMenuItem(child: Text('ALTO ALEGRE'), value: 'ALTO ALEGRE'),
  DropdownMenuItem(child: Text('BOA VISTA'), value: 'BOA VISTA'),
  DropdownMenuItem(child: Text('BONFIM'), value: 'BONFIM'),
  DropdownMenuItem(child: Text('CANTÁ'), value: 'CANTÁ'),
  DropdownMenuItem(child: Text('CARACARAÍ'), value: 'CARACARAÍ'),
  DropdownMenuItem(child: Text('CAROEBE'), value: 'CAROEBE'),
  DropdownMenuItem(child: Text('IRACEMA'), value: 'IRACEMA'),
  DropdownMenuItem(child: Text('MUCAJAÍ'), value: 'MUCAJAÍ'),
  DropdownMenuItem(child: Text('NORMANDIA'), value: 'NORMANDIA'),
  DropdownMenuItem(child: Text('PACARAIMA'), value: 'PACARAIMA'),
  DropdownMenuItem(child: Text('RORAINÓPOLIS'), value: 'RORAINÓPOLIS'),
  DropdownMenuItem(
      child: Text('SÃO JOÃO DA BALIZA'), value: 'SÃO JOÃO DA BALIZA'),
  DropdownMenuItem(child: Text('SÃO LUIZ'), value: 'SÃO LUIZ'),
  DropdownMenuItem(child: Text('UIRAMUTÃ'), value: 'UIRAMUTÃ'),
];
