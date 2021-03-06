import 'package:flutter/material.dart';

const String kAppName = 'Codesaima';
const String kAddressBox = 'Address';
const String kSocialNetworksBox = 'SocialNetworks';
const String kSimplePersonBox = 'BoxRegisterSearch';
const String kCompletePersonBox = 'BoxRegisterMorarMelhor';
const String kPersonSpouseBox = 'BoxPersonSpouse';
const String kDeficientPersonBox = 'BoxDeficientPerson';
const String kResidentFamiliarBox = 'BoxResidentFamiliar';
const String kEdificeInformationBox = 'BoxEdificeInformation';

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

const String kFontOpenSans = 'lib/assets/fonts/opensans/OpenSans-Regular.ttf';

final kTextFieldDecorationMorarMelhor = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  fillColor: Colors.orange[50],
  filled: true,
);
final kTextFieldGeneralDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  fillColor: Colors.blueGrey[50],
  filled: true,
);

final kGeneralThemeData =
    ThemeData(primarySwatch: Colors.red, useMaterial3: true);
final kMorarMelhorThemeData = ThemeData(
  backgroundColor: Colors.orange,
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.orange[50],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      )),
  primarySwatch: Colors.orange,
);

enum Gender { male, female, other }

const List<DropdownMenuItem<String>> dropdownCities = [
  DropdownMenuItem(child: Text('AMAJARI'), value: 'AMAJARI'),
  DropdownMenuItem(child: Text('ALTO ALEGRE'), value: 'ALTO ALEGRE'),
  DropdownMenuItem(child: Text('BOA VISTA'), value: 'BOA VISTA'),
  DropdownMenuItem(child: Text('BONFIM'), value: 'BONFIM'),
  DropdownMenuItem(child: Text('CANT??'), value: 'CANT??'),
  DropdownMenuItem(child: Text('CARACARA??'), value: 'CARACARA??'),
  DropdownMenuItem(child: Text('CAROEBE'), value: 'CAROEBE'),
  DropdownMenuItem(child: Text('IRACEMA'), value: 'IRACEMA'),
  DropdownMenuItem(child: Text('MUCAJA??'), value: 'MUCAJA??'),
  DropdownMenuItem(child: Text('NORMANDIA'), value: 'NORMANDIA'),
  DropdownMenuItem(child: Text('PACARAIMA'), value: 'PACARAIMA'),
  DropdownMenuItem(child: Text('RORAIN??POLIS'), value: 'RORAIN??POLIS'),
  DropdownMenuItem(
      child: Text('S??O JO??O DA BALIZA'), value: 'S??O JO??O DA BALIZA'),
  DropdownMenuItem(child: Text('S??O LUIZ'), value: 'S??O LUIZ'),
  DropdownMenuItem(child: Text('UIRAMUT??'), value: 'UIRAMUT??'),
];
const List<String> civilStateList = [
  'SOLTEIRO(A)',
  'DIVORCIADO(A)',
  'VI??VO(A)',
  'UNI??O EST??VEL/OUTROS',
  'CASADO(A) SEPARA????O TOTAL DE BENS',
  'CASADO(A) COMUNH??O PARCIAL DE BENS',
  'CASADO(A) COMUNH??O TOTAL DE BENS',
];

const List<String> educationLevelList = [
  'FUNDAMENTAL 1 COMPLETO',
  'FUNDAMENTAL 1 INCOMPLETO',
  'FUNDAMENTAL 2 COMPLETO',
  'FUNDAMENTAL 2 INCOMPLETO',
  'ENSINO M??DIO COMPLETO',
  'ENSINO M??DIO INCOMPLETO',
  'ENSINO SUPERIOR COMPLETO',
  'ENSINO SUPERIOR INCOMPLETO',
  'ANALFABETO'
];

showGeneralProgressIndicator(BuildContext context, String message) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: const EdgeInsets.only(left: 5), child: Text(message)),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showGeneralAlertMessage(BuildContext context, String message) {
  Widget okButton = ElevatedButton(
      onPressed: () => Navigator.pop(context), child: const Text('OK'));
  AlertDialog alert = AlertDialog(
    content: Text(message),
    actions: [okButton],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

const List<String> listCountries = [
  'AFEGANIST??O',
  '??FRICA DO SUL',
  'AKROTIRI',
  'ALB??NIA',
  'ALEMANHA',
  'ANDORRA',
  'ANGOLA',
  'ANGUILA',
  'ANT??RCTIDA',
  'ANT??GUA E BARBUDA',
  'AR??BIA SAUDITA',
  'ARCTIC OCEAN',
  'ARG??LIA',
  'ARGENTINA',
  'ARM??NIA',
  'ARUBA',
  'ASHMORE AND CARTIER ISLANDS',
  'ATLANTIC OCEAN',
  'AUSTR??LIA',
  '??USTRIA',
  'AZERBAIJ??O',
  'BAAMAS',
  'BANGLADECHE',
  'BARBADOS',
  'BAR??M',
  'B??LGICA',
  'BELIZE',
  'BENIM',
  'BERMUDAS',
  'BIELORR??SSIA',
  'BIRM??NIA',
  'BOL??VIA',
  'B??SNIA E HERZEGOVINA',
  'BOTSUANA',
  'BRASIL',
  'BRUNEI',
  'BULG??RIA',
  'BURQUINA FASO',
  'BUR??NDI',
  'BUT??O',
  'CABO VERDE',
  'CAMAR??ES',
  'CAMBOJA',
  'CANAD??',
  'CATAR',
  'CAZAQUIST??O',
  'CHADE',
  'CHILE',
  'CHINA',
  'CHIPRE',
  'CLIPPERTON ISLAND',
  'COL??MBIA',
  'COMORES',
  'CONGO-BRAZZAVILLE',
  'CONGO-KINSHASA',
  'CORAL SEA ISLANDS',
  'COREIA DO NORTE',
  'COREIA DO SUL',
  'COSTA DO MARFIM',
  'COSTA RICA',
  'CRO??CIA',
  'CUBA',
  'CURACAO',
  'DHEKELIA',
  'DINAMARCA',
  'DOM??NICA',
  'EGIPTO',
  'EMIRATOS ??RABES UNIDOS',
  'EQUADOR',
  'ERITREIA',
  'ESLOV??QUIA',
  'ESLOV??NIA',
  'ESPANHA',
  'ESTADOS UNIDOS',
  'EST??NIA',
  'ETI??PIA',
  'FARO??',
  'FIJI',
  'FILIPINAS',
  'FINL??NDIA',
  'FRAN??A',
  'GAB??O',
  'G??MBIA',
  'GANA',
  'GAZA STRIP',
  'GE??RGIA',
  'GE??RGIA DO SUL E SANDWICH DO SUL',
  'GIBRALTAR',
  'GRANADA',
  'GR??CIA',
  'GRONEL??NDIA',
  'GUAME',
  'GUATEMALA',
  'GUERNSEY',
  'GUIANA',
  'GUIN??',
  'GUIN?? EQUATORIAL',
  'GUIN??-BISSAU',
  'HAITI',
  'HONDURAS',
  'HONG KONG',
  'HUNGRIA',
  'I??MEN',
  'ILHA BOUVET',
  'ILHA DO NATAL',
  'ILHA NORFOLK',
  'ILHAS CAIM??O',
  'ILHAS COOK',
  'ILHAS DOS COCOS',
  'ILHAS FALKLAND',
  'ILHAS HEARD E MCDONALD',
  'ILHAS MARSHALL',
  'ILHAS SALOM??O',
  'ILHAS TURCAS E CAICOS',
  'ILHAS VIRGENS AMERICANAS',
  'ILHAS VIRGENS BRIT??NICAS',
  '??NDIA',
  'INDIAN OCEAN',
  'INDON??SIA',
  'IR??O',
  'IRAQUE',
  'IRLANDA',
  'ISL??NDIA',
  'ISRAEL',
  'IT??LIA',
  'JAMAICA',
  'JAN MAYEN',
  'JAP??O',
  'JERSEY',
  'JIBUTI',
  'JORD??NIA',
  'KOSOVO',
  'KUWAIT',
  'LAOS',
  'LESOTO',
  'LET??NIA',
  'L??BANO',
  'LIB??RIA',
  'L??BIA',
  'LISTENSTAINE',
  'LITU??NIA',
  'LUXEMBURGO',
  'MACAU',
  'MACED??NIA',
  'MADAG??SCAR',
  'MAL??SIA',
  'MAL??VI',
  'MALDIVAS',
  'MALI',
  'MALTA',
  'MAN, ISLE OF',
  'MARIANAS DO NORTE',
  'MARROCOS',
  'MAUR??CIA',
  'MAURIT??NIA',
  'M??XICO',
  'MICRON??SIA',
  'MO??AMBIQUE',
  'MOLD??VIA',
  'M??NACO',
  'MONG??LIA',
  'MONSERRATE',
  'MONTENEGRO',
  'MUNDO',
  'NAM??BIA',
  'NAURU',
  'NAVASSA ISLAND',
  'NEPAL',
  'NICAR??GUA',
  'N??GER',
  'NIG??RIA',
  'NIUE',
  'NORUEGA',
  'NOVA CALED??NIA',
  'NOVA ZEL??NDIA',
  'OM??',
  'PACIFIC OCEAN',
  'PA??SES BAIXOS',
  'PALAU',
  'PANAM??',
  'PAPUA-NOVA GUIN??',
  'PAQUIST??O',
  'PARACEL ISLANDS',
  'PARAGUAI',
  'PERU',
  'PITCAIRN',
  'POLIN??SIA FRANCESA',
  'POL??NIA',
  'PORTO RICO',
  'PORTUGAL',
  'QU??NIA',
  'QUIRGUIZIST??O',
  'QUIRIB??TI',
  'REINO UNIDO',
  'REP??BLICA CENTRO-AFRICANA',
  'REP??BLICA DOMINICANA',
  'ROM??NIA',
  'RUANDA',
  'R??SSIA',
  'SALVADOR',
  'SAMOA',
  'SAMOA AMERICANA',
  'SANTA HELENA',
  'SANTA L??CIA',
  'S??O BARTOLOMEU',
  'S??O CRIST??V??O E NEVES',
  'S??O MARINHO',
  'S??O MARTINHO',
  'S??O PEDRO E MIQUELON',
  'S??O TOM?? E PR??NCIPE',
  'S??O VICENTE E GRANADINAS',
  'SARA OCIDENTAL',
  'SEICHELES',
  'SENEGAL',
  'SERRA LEOA',
  'S??RVIA',
  'SINGAPURA',
  'SINT MAARTEN',
  'S??RIA',
  'SOM??LIA',
  'SOUTHERN OCEAN',
  'SPRATLY ISLANDS',
  'SRI LANCA',
  'SUAZIL??NDIA',
  'SUD??O',
  'SUD??O DO SUL',
  'SU??CIA',
  'SU????A',
  'SURINAME',
  'SVALBARD E JAN MAYEN',
  'TAIL??NDIA',
  'TAIWAN',
  'TAJIQUIST??O',
  'TANZ??NIA',
  'TERRIT??RIO BRIT??NICO DO OCEANO ??NDICO',
  'TERRIT??RIOS AUSTRAIS FRANCESES',
  'TIMOR LESTE',
  'TOGO',
  'TOKELAU',
  'TONGA',
  'TRINDADE E TOBAGO',
  'TUN??SIA',
  'TURQUEMENIST??O',
  'TURQUIA',
  'TUVALU',
  'UCR??NIA',
  'UGANDA',
  'UNI??O EUROPEIA',
  'URUGUAI',
  'USBEQUIST??O',
  'VANUATU',
  'VATICANO',
  'VENEZUELA',
  'VIETNAME',
  'WAKE ISLAND',
  'WALLIS E FUTUNA',
  'WEST BANK',
  'Z??MBIA',
  'ZIMBABU??',
];
