// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables, must_be_immutable

import 'dart:async';

import 'package:codesaima/components/radio_sex_choice.dart';
import 'package:codesaima/consts.dart';
import 'package:codesaima/core/textfield_search.dart';
import 'package:codesaima/models/address_model.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:codesaima/models/deficient_person_model.dart';
import 'package:codesaima/models/person_spouse.dart';
import 'package:codesaima/models/register_person_morar_melhor_model.dart';
import 'package:codesaima/models/resident_familiar.dart';
import 'package:codesaima/models/social_networks.dart';
import 'package:codesaima/screens/crud_simple_person_screen.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class RegisterMorarMelhorScreen extends StatefulWidget {
  RegisterMorarMelhorScreen({
    Key? key,
    required this.hasPersonData,
    this.personIndex,
  }) : super(key: key);

  final bool hasPersonData;

  final int? personIndex;

  @override
  State<RegisterMorarMelhorScreen> createState() =>
      _RegisterMorarMelhorScreen();
}

class _RegisterMorarMelhorScreen extends State<RegisterMorarMelhorScreen> {
  late final Box _completePersonListBox;
  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _sexController = TextEditingController();
  final _nacionalityController = TextEditingController();
  final _ufNaturalityController = TextEditingController();
  final _cityNaturalityController = TextEditingController();
  final _mothersNameController = TextEditingController();
  final _fathersNameController = TextEditingController();
  final _tipeDocumentController = TextEditingController();
  final _numberDocumentController = TextEditingController();
  final _issueDocumentController = TextEditingController();
  final _ufDocumentController = TextEditingController();
  final _dateIssueDocumentController = TextEditingController();
  final _pisNisPasepController = TextEditingController();
  final _cpfController = TextEditingController();
  final _professionController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _numberHouseController = TextEditingController();
  final _ufAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _complementAdressController = TextEditingController();
  final _phoneController0 = TextEditingController();
  final _phoneController1 = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _educationLevelController = TextEditingController();
  final _timeLiveRoraimaYearController = TextEditingController();
  final _timeLiveRoraimaMonthController = TextEditingController();
  final _timeLiveHomeYearController = TextEditingController();
  final _timeLiveHomeMonthController = TextEditingController();
  final _individualCashController = TextEditingController();
  final _familiarCashController = TextEditingController();
  final _spouseNameController = TextEditingController();
  final _spouseBirthDateController = TextEditingController();
  final _spouseSexController = TextEditingController();
  final _spouseNacionalityController = TextEditingController();
  final _spouseUfNaturalityController = TextEditingController();
  final _spouseCityNaturalityController = TextEditingController();
  final _spouseMothersNameController = TextEditingController();
  final _spouseNumberDocumentController = TextEditingController();
  final _spouseIssueDocumentController = TextEditingController();
  final _spouseUfDocumentController = TextEditingController();
  final _spouseDateIssueDocumentController = TextEditingController();
  final _spousePisNisPasepController = TextEditingController();
  final _spouseCpfController = TextEditingController();
  final _spouseProfessionController = TextEditingController();
  final _spousePhoneController = TextEditingController();
  final _spouseEducationLevelController = TextEditingController();
  final _spouseIndividualCashController = TextEditingController();
  final _deficientNameController = TextEditingController();
  final _deficientCIDController = TextEditingController();
  final List<ResidentFamiliar> _residentFamiliarList = [];
  final List<TextEditingController> _residentFamiliarName = [];
  final List<TextEditingController> _residentFamiliarBirthDate = [];
  final List<TextEditingController> _residentFamiliarCPF = [];
  final List<TextEditingController> _residentFamiliarKinship = [];
  final List<bool> _residentFamiliarDeficient = [];

  SocialNetworks _socialNetworks = SocialNetworks();
  Address _address = Address();
  RegisterMorarMelhor _person = RegisterMorarMelhor();
  PersonSpouse _personSpouse = PersonSpouse();
  Gender _groupValueSex = Gender.male;
  Gender _spouseGroupValueSex = Gender.male;
  bool _hasSpouse = false;
  int _currentTabIndex = 0;
  bool? _singleMother = false;
  DeficientPerson _deficientPerson = DeficientPerson();

  final PageController _pageController =
      PageController(initialPage: 0, keepPage: false, viewportFraction: 1);

  @override
  void initState() {
    _completePersonListBox = Hive.box<RegisterMorarMelhor>(kCompletePersonBox);
    _nacionalityController.text = 'BRASIL';
    _ufNaturalityController.text = 'RR';
    _cityNaturalityController.text = 'BOA VISTA';
    _socialNetworks.clear();

    if (widget.hasPersonData) {
      _person = _completePersonListBox.get(widget.personIndex);

      for (var i = 3; i < civilStateList.length; i++) {
        //verify the marital Status
        _person.maritalStatus == civilStateList[i] ? _hasSpouse = true : null;
      }

      _nameController.text = _person.name;
      _birthDateController.text = _person.birthDate;
      _singleMother = _person.singleMother;

//_sexController    <=
      if (_person.sex == 'MASCULINO') {
        _groupValueSex = Gender.male;
        _sexController.text = 'MASCULINO';
      } else if (_person.sex == 'FEMININO') {
        _groupValueSex = Gender.female;
        _sexController.text = 'FEMININO';
      } else {
        _sexController.text = _person.sex;
        _groupValueSex = Gender.other;
      }
      _nacionalityController.text = _person.nacionality;
      _mothersNameController.text = _person.mothersName;
      _fathersNameController.text = _person.fathersName;
      _socialNetworks = _person.socialNetworks!;
      _phoneController0.text = _person.phoneList!.first;
      _phoneController1.text = _person.phoneList!.last;
      _tipeDocumentController.text = _person.typeOfDocument;
      _numberDocumentController.text = _person.numberDocument;
      _issueDocumentController.text = _person.issueDocument;
      _ufDocumentController.text = _person.ufDocument;
      _dateIssueDocumentController.text = _person.dateIssueDocument;
      _pisNisPasepController.text = _person.pisNisPasep;
      _cpfController.text = _person.cpf;
      _professionController.text = _person.profession;
      _cepController.text = _person.address!.cep;
      _districtController.text = _person.address!.bairro;
      _numberHouseController.text = _person.address!.numero;
      _ufAddressController.text = _person.address!.uf;
      _cityController.text = _person.address!.localidade;
      _streetController.text = _person.address!.logradouro;
      _complementAdressController.text = _person.address!.complemento;
      _maritalStatusController.text = _person.maritalStatus;
      _educationLevelController.text = _person.educationLevel;
      _timeLiveRoraimaYearController.text = _person.timeLiveRoraimaYear;
      _timeLiveRoraimaMonthController.text = _person.timeLiveRoraimaMonth;
      _timeLiveHomeYearController.text = _person.timeLiveHomeYear;
      _timeLiveHomeMonthController.text = _person.timeLiveHomeMonth;
      _individualCashController.text = _person.individualCash;
      _familiarCashController.text = _person.familiarCash;
      _deficientNameController.text = _person.deficientPerson!.name;
      _deficientCIDController.text = _person.deficientPerson!.cid;

      if (_hasSpouse) {
        //_sexController    <=
        if (_person.personSpouse!.sex == 'MASCULINO') {
          _spouseGroupValueSex = Gender.male;
          _spouseSexController.text = 'MASCULINO';
        } else if (_person.personSpouse!.sex == 'FEMININO') {
          _spouseGroupValueSex = Gender.female;
          _spouseSexController.text = 'FEMININO';
        } else {
          _spouseSexController.text = _person.personSpouse!.sex;
          _spouseGroupValueSex = Gender.other;
        }

        _spouseNameController.text = _person.personSpouse!.name;
        _spouseSexController.text = _person.personSpouse!.sex;
        _spouseBirthDateController.text = _person.personSpouse!.birthDate;
        _spouseNacionalityController.text = _person.personSpouse!.nacionality;
        _spouseUfNaturalityController.text = _person.personSpouse!.originUF;
        _spouseCityNaturalityController.text = _person.personSpouse!.originCity;
        _spouseMothersNameController.text = _person.personSpouse!.mothersName;
        _spouseNumberDocumentController.text =
            _person.personSpouse!.numberDocument;
        _spouseIssueDocumentController.text =
            _person.personSpouse!.issueDocument;
        _spouseUfDocumentController.text = _person.personSpouse!.ufDocument;
        _spouseDateIssueDocumentController.text =
            _person.personSpouse!.dateIssueDocument;
        _spousePisNisPasepController.text = _person.personSpouse!.pisNisPasep;
        _spouseCpfController.text = _person.personSpouse!.cpf;
        _spouseProfessionController.text = _person.personSpouse!.profession;
        _spousePhoneController.text = _person.personSpouse!.phoneNumber;
        _spouseEducationLevelController.text =
            _person.personSpouse!.educationLevel;
        _spouseIndividualCashController.text =
            _person.personSpouse!.individualCash;
      }
    }
    super.initState();
  }

  void _onTabTapped(int newIndex) => setState(() {
        if (newIndex == 1 && _hasSpouse == false) {
          var snackBar = SnackBar(
              content: Text(
                  '${_nameController.text} Está solteiro. Mude o Estado Civil'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          _currentTabIndex = newIndex;
          _pageController.jumpToPage(_currentTabIndex);
        }
      });

  addOrUpdatePerson() async {
    List<String> _listPhoneNumber = [];
    _listPhoneNumber.addAll([_phoneController0.text, _phoneController1.text]);
    _deficientPerson = DeficientPerson(
      name: _deficientNameController.text.toUpperCase(),
      cid: _deficientCIDController.text.toUpperCase(),
    );

    _personSpouse = PersonSpouse(
      name: _spouseNameController.text.toUpperCase(),
      birthDate: _spouseBirthDateController.text,
      sex: _spouseSexController.text,
      nacionality: _spouseNacionalityController.text.toUpperCase(),
      originUF: _spouseUfNaturalityController.text.toUpperCase(),
      originCity: _spouseCityNaturalityController.text.toUpperCase(),
      mothersName: _spouseMothersNameController.text.toUpperCase(),
      numberDocument: _spouseNumberDocumentController.text,
      issueDocument: _spouseIssueDocumentController.text.toUpperCase(),
      ufDocument: _spouseUfDocumentController.text.toUpperCase(),
      dateIssueDocument: _spouseDateIssueDocumentController.text.toUpperCase(),
      pisNisPasep: _spousePisNisPasepController.text,
      cpf: _spouseCpfController.text,
      profession: _spouseProfessionController.text.toUpperCase(),
      phoneNumber: _spousePhoneController.text,
      educationLevel: _spouseEducationLevelController.text,
      individualCash: _spouseIndividualCashController.text,
    );

    _address = Address(
        cep: _cepController.text,
        uf: _ufAddressController.text.toUpperCase(),
        localidade: _cityController.text.toUpperCase(),
        logradouro: _streetController.text.toUpperCase(),
        bairro: _districtController.text.toUpperCase(),
        numero: _numberHouseController.text,
        complemento: _complementAdressController.text.toUpperCase());

    _person = RegisterMorarMelhor(
        address: _address,
        birthDate: _birthDateController.text.toUpperCase(),
        sex: _sexController.text.toUpperCase(),
        name: _nameController.text.toUpperCase(),
        nacionality: _nacionalityController.text.toUpperCase(),
        mothersName: _mothersNameController.text.toUpperCase(),
        fathersName: _fathersNameController.text.toUpperCase(),
        phoneList: _listPhoneNumber,
        socialNetworks: _socialNetworks,
        typeOfDocument: _tipeDocumentController.text.toUpperCase(),
        numberDocument: _numberDocumentController.text.toUpperCase(),
        issueDocument: _issueDocumentController.text.toUpperCase(),
        ufDocument: _ufDocumentController.text.toUpperCase(),
        dateIssueDocument: _dateIssueDocumentController.text.toUpperCase(),
        pisNisPasep: _pisNisPasepController.text.toUpperCase(),
        cpf: _cpfController.text.toUpperCase(),
        profession: _professionController.text.toUpperCase(),
        maritalStatus: _maritalStatusController.text.toUpperCase(),
        educationLevel: _educationLevelController.text.toUpperCase(),
        individualCash: _individualCashController.text.toUpperCase(),
        familiarCash: _familiarCashController.text.toUpperCase(),
        personSpouse: _personSpouse,
        timeLiveRoraimaYear: _timeLiveRoraimaYearController.text.toUpperCase(),
        timeLiveRoraimaMonth:
            _timeLiveRoraimaMonthController.text.toUpperCase(),
        timeLiveHomeYear: _timeLiveHomeYearController.text.toUpperCase(),
        timeLiveHomeMonth: _timeLiveHomeMonthController.text.toUpperCase(),
        singleMother: _singleMother,
        deficientPerson: _deficientPerson);
    widget.hasPersonData
        ? //update
        await _completePersonListBox.put(widget.personIndex, _person)
        : await _completePersonListBox.add(_person); //add

    Navigator.pop(context, widget.personIndex);
  }

  void getCep() async {
    FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard

    NetworkHelper networkHelper =
        NetworkHelper('https://viacep.com.br/ws/${_cepController.text}/json/');
    showGeneralProgressIndicator(context, 'Buscando CEP');
    try {
      _address = await networkHelper.getData();

      setState(() {
        if (_address.uf == 'RR') {
          _ufAddressController.text = 'RR';
          _cityController.text = _address.localidade.toUpperCase();
          _districtController.text = _address.bairro.toUpperCase();
          _streetController.text = _address.logradouro.toUpperCase();
        } else {
          var snackBar = SnackBar(
              content:
                  Text('Erro: (${_address.uf}) Fora do Estado de Roraima'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (e) {
      var snackBar = SnackBar(
          content:
              Text('Erro ${e.toString().replaceAll(RegExp(r'[^0-9]'), '')}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _ufAddressController.text = 'RR';

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showConfirmationExitDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
          backgroundColor: kMorarMelhorThemeData.backgroundColor,
          appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: kMorarMelhorThemeData.backgroundColor,
              title: Text('Cadastro Morar Melhor')),
          body: Container(
            color: Colors.white,
            child: SafeArea(
                child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                SingleChildScrollView(
                  // Dados Pessoais do Responsável Familiar
                  child: Column(
                    children: [
                      Text('Dados Pessoais do Responsável Familiar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      Divider(height: 5),
                      CompletNameWidget(nameController: _nameController),
                      Text('Mãe solteira?'),
                      RadioListTile<bool>(
                          title: Text('SIM'),
                          value: true,
                          groupValue: _singleMother,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _singleMother = newValue;
                            });
                          }),
                      RadioListTile<bool>(
                          title: Text('NÃO'),
                          value: false,
                          groupValue: _singleMother,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _singleMother = newValue;
                            });
                          }),
                      Divider(height: 5),
                      Text('Data de nascimento:'),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? _temp;
                            _temp = await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancelar')),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  try {
                                                    _birthDateController.text =
                                                        DateFormat('dd/MM/yy')
                                                            .format(_temp!)
                                                            .toString();
                                                  } catch (e) {
                                                    var snackBar = SnackBar(
                                                        content: Text(
                                                            'Selecione uma data!'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'))
                                        ],
                                      ),
                                      Expanded(
                                          child: CupertinoDatePicker(
                                              maximumYear:
                                                  DateTime.now().year - 10,
                                              minimumYear: 1900,
                                              initialDateTime: DateTime(2000),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              dateOrder:
                                                  DatePickerDateOrder.dmy,
                                              onDateTimeChanged: (changed) {
                                                _temp = changed;
                                              })),
                                    ],
                                  );
                                });
                          },
                          child: _birthDateController.text == ''
                              ? Text('Selecione')
                              : Text(_birthDateController.text)),
                      Text('Orientação sexual:'),
                      RadioSexChoice(
                        gender: Gender.male,
                        groupValueSex: _groupValueSex,
                        function: (newValue) => setState(() {
                          _groupValueSex = newValue!;
                          _sexController.text = 'MASCULINO';
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); //dismiss Keyboard
                        }),
                      ),
                      RadioSexChoice(
                        gender: Gender.female,
                        groupValueSex: _groupValueSex,
                        function: (newValue) => setState(() {
                          _groupValueSex = newValue!;
                          _sexController.text = 'FEMININO';
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); //dismiss Keyboard
                        }),
                      ),
                      RadioSexChoice(
                        gender: Gender.other,
                        groupValueSex: _groupValueSex,
                        function: (newValue) => setState(() {
                          _groupValueSex = newValue!;
                          _sexController.text = 'OUTRO';
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); //dismiss Keyboard
                        }),
                      ),
                      Visibility(
                          visible:
                              _groupValueSex == Gender.other ? true : false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                              controller: _sexController,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                      hintText: 'Orientação Sexual',
                                      labelText: 'Orientação Sexual'),
                            ),
                          )),
                      Divider(height: 5),
                      TextFieldSearch(
                        noItemfoundMessage: 'Nenhum item encontrado',
                        minStringLength: 3,
                        label: 'País-Nacionalidade',
                        initialList: listCountries,
                        controller: _nacionalityController,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            hintText: 'País-Nacionalidade',
                            labelText: 'País-Nacionalidade'),
                      ),
                      Divider(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              controller: _ufNaturalityController,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                labelText: 'UF',
                                hintText: 'UF',
                              ),
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Spacer(),
                          Flexible(
                              flex: 10,
                              child: TextField(
                                controller: _cityNaturalityController,
                                decoration:
                                    kTextFieldDecorationMorarMelhor.copyWith(
                                  labelText: 'Cidade de Nascimento',
                                  hintText: 'Cidade de Nascimento',
                                ),
                              ))
                        ],
                      ),
                      Divider(height: 5),
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        controller: _mothersNameController,
                        keyboardType: TextInputType.name,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Nome da Mãe',
                            hintText: 'Nome do Mãe',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.person),
                            )),
                      ),
                      Divider(height: 5),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.characters,
                        controller: _fathersNameController,
                        keyboardType: TextInputType.name,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Nome do Pai',
                            hintText: 'Nome do Pai',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.person),
                            )),
                      ),
                      Divider(height: 5),
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        controller: _tipeDocumentController,
                        keyboardType: TextInputType.name,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Tipo de Documento',
                            hintText: 'RG, CNH, CTPS, RNM, etc'),
                      ),
                      Divider(height: 5),
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _numberDocumentController,
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Nº / Série do documento',
                            hintText: 'Nº / Série do documento'),
                      ),
                      Divider(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextField(
                              controller: _issueDocumentController,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                labelText: 'Órgão emissor',
                                hintText: 'Órgão emissor',
                              ),
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Flexible(
                              flex: 2,
                              child: TextField(
                                maxLength: 2,
                                textCapitalization:
                                    TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                                controller: _ufDocumentController,
                                decoration:
                                    kTextFieldDecorationMorarMelhor.copyWith(
                                  counterText: '',
                                  labelText: 'UF',
                                  hintText: 'UF',
                                ),
                              )),
                        ],
                      ),
                      Divider(height: 5),
                      Text('Data de expedição:'),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? _temp;
                            _temp = await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancelar')),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  try {
                                                    _dateIssueDocumentController
                                                            .text =
                                                        DateFormat('dd/MM/yy')
                                                            .format(_temp!)
                                                            .toString();
                                                  } catch (e) {
                                                    var snackBar = SnackBar(
                                                        content: Text(
                                                            'Selecione uma data!'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'))
                                        ],
                                      ),
                                      Expanded(
                                          child: CupertinoDatePicker(
                                              maximumYear: DateTime.now().year,
                                              minimumYear: 1900,
                                              initialDateTime: DateTime.now(),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              dateOrder:
                                                  DatePickerDateOrder.dmy,
                                              onDateTimeChanged: (changed) {
                                                _temp = changed;
                                              })),
                                    ],
                                  );
                                });
                          },
                          child: _dateIssueDocumentController.text == ''
                              ? Text('Selecione')
                              : Text(_dateIssueDocumentController.text)),
                      Divider(height: 5),
                      TextField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _pisNisPasepController,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                          labelText: 'Nº PIS/NIS/PASEP',
                          hintText: 'Nº PIS/NIS/PASEP',
                        ),
                      ),
                      Divider(height: 5),
                      TextField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TextInputMask(mask: '999.999.999-99')
                        ],
                        controller: _cpfController,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                          labelText: 'CPF',
                          hintText: 'CPF',
                        ),
                      ),
                      Divider(height: 5),
                      TextField(
                        textInputAction: TextInputAction.done,
                        controller: _professionController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                          labelText: 'Profissão',
                          hintText: 'Profissão',
                        ),
                      ),
                      Divider(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              onEditingComplete: () async => getCep(),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TextInputMask(mask: '99999-999')
                              ],
                              controller: _cepController,
                              decoration: kTextFieldDecorationMorarMelhor
                                  .copyWith(labelText: 'CEP', hintText: 'CEP'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(15)),
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
                                ),
                                onPressed: () async => getCep(),
                                child: Icon(Icons.cached)),
                          )
                        ],
                      ),
                      Divider(height: 5),
                      Row(
                        children: [
                          UfWidget(ufController: _ufAddressController),
                          SizedBox(height: 1, width: 1),
                          Expanded(
                            flex: 10,
                            child: DropdownButtonFormField(
                              decoration: kTextFieldDecorationMorarMelhor,
                              items: dropdownCities,
                              value: _cityController.text.isEmpty
                                  ? 'BOA VISTA'
                                  : _cityController.text,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _cityController.text = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 5),
                      StreetWidget(ruaController: _streetController),
                      Divider(height: 5),
                      Row(
                        children: [
                          BairroWidget(bairroController: _districtController),
                          Spacer(),
                          NumberWidget(
                              numeroController: _numberHouseController),
                        ],
                      ),
                      Divider(height: 5),
                      TextField(
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          controller: _complementAdressController,
                          decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Complemento',
                            hintText: 'Complemento',
                          )),
                      Divider(height: 5),
                      PhoneWidget(telefoneController: _phoneController0),
                      Divider(height: 5),
                      PhoneWidget(telefoneController: _phoneController1),
                      Divider(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.schema_rounded,
                            color: Colors.blueGrey[300],
                          ),
                          Text(
                            'Redes Sociais:',
                            style: TextStyle(color: Colors.blueGrey[300]),
                          ),
                        ],
                      ),
                      Divider(height: 5),
                      Wrap(children: buildSocialMediaNetworks()),
                      Divider(height: 5),
                      Text('Estado Civil:'),
                      ElevatedButton(
                          onPressed: _displayMaritalStatusDialog,
                          child: _maritalStatusController.text == ''
                              ? Text('Selecione')
                              : Text(_maritalStatusController.text)),
                      Text('Grau de Instrução:'),
                      ElevatedButton(
                          onPressed: _displayEducationLevelDialog,
                          child: _educationLevelController.text == ''
                              ? Text('Selecione')
                              : Text(_educationLevelController.text)),
                      Divider(height: 5),
                      Text('Quanto tempo reside em Roraima?'),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _timeLiveRoraimaYearController,
                              inputFormatters: [
                                TextInputMask(mask: '999'),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                      labelText: 'Anos', suffixText: 'Anos'),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              controller: _timeLiveRoraimaMonthController,
                              inputFormatters: [
                                TextInputMask(mask: '999'),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                      labelText: 'Meses', suffixText: 'Meses'),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 5),
                      Text('Quanto tempo reside no imóvel?'),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _timeLiveHomeYearController,
                              inputFormatters: [
                                TextInputMask(mask: '999'),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                      labelText: 'Anos', suffixText: 'Anos'),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              controller: _timeLiveHomeMonthController,
                              inputFormatters: [
                                TextInputMask(mask: '999'),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                      labelText: 'Meses', suffixText: 'Meses'),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 5),
                      TextField(
                        inputFormatters: [
                          TextInputMask(
                            mask: ['R!\$! !999,99', 'R!\$! 999.999,99'],
                            placeholder: '0',
                            maxPlaceHolders: 3,
                            reverse: true,
                          )
                        ],
                        controller: _individualCashController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Renda Individual',
                            hintText: 'Renda Individual'),
                      ),
                      Divider(height: 5),
                      TextField(
                        inputFormatters: [
                          TextInputMask(
                            mask: ['R!\$! !999,99', 'R!\$! 999.999,99'],
                            placeholder: '0',
                            maxPlaceHolders: 3,
                            reverse: true,
                          )
                        ],
                        controller: _familiarCashController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Renda Familiar',
                            hintText: 'Renda Familiar'),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  //Text('Dados Pessoais do Cônjuge'),
                  child: Column(
                    children: [
                      Text('Dados Pessoais do Cônjuge',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      Divider(height: 5),
                      TextField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        controller: _spouseNameController,
                        keyboardType: TextInputType.name,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Nome do cônjuge',
                            hintText: 'Nome completo do cônjuge',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.person),
                            )),
                      ),
                      Divider(height: 5),
                      Text('Data de nascimento do cônjuge:'),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? _temp;
                            _temp = await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus(); //dismiss Keyboard
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancelar')),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  try {
                                                    _spouseBirthDateController
                                                            .text =
                                                        DateFormat('dd/MM/yy')
                                                            .format(_temp!)
                                                            .toString();
                                                  } catch (e) {
                                                    var snackBar = SnackBar(
                                                        content: Text(
                                                            'Selecione uma data!'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'))
                                        ],
                                      ),
                                      Expanded(
                                          child: CupertinoDatePicker(
                                              maximumYear:
                                                  DateTime.now().year - 10,
                                              minimumYear: 1900,
                                              initialDateTime: DateTime(2000),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              dateOrder:
                                                  DatePickerDateOrder.dmy,
                                              onDateTimeChanged: (changed) {
                                                _temp = changed;
                                              })),
                                    ],
                                  );
                                });
                          },
                          child: _spouseBirthDateController.text == ''
                              ? Text('Selecione')
                              : Text(_spouseBirthDateController.text)),
                      Divider(height: 5),
                      Text('Orientação sexual:'),
                      RadioSexChoice(
                        gender: Gender.male,
                        groupValueSex: _spouseGroupValueSex,
                        function: (newValue) => setState(() {
                          _spouseGroupValueSex = newValue!;
                          _spouseSexController.text = 'MASCULINO';
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); //dismiss Keyboard
                        }),
                      ),
                      RadioSexChoice(
                        gender: Gender.female,
                        groupValueSex: _spouseGroupValueSex,
                        function: (newValue) => setState(() {
                          _spouseGroupValueSex = newValue!;
                          _spouseSexController.text = 'FEMININO';
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); //dismiss Keyboard
                        }),
                      ),
                      RadioSexChoice(
                        gender: Gender.other,
                        groupValueSex: _spouseGroupValueSex,
                        function: (newValue) => setState(() {
                          _spouseGroupValueSex = newValue!;
                          _spouseSexController.text = 'OUTRO';
                          FocusManager.instance.primaryFocus
                              ?.unfocus(); //dismiss Keyboard
                        }),
                      ),
                      Visibility(
                          visible: _spouseGroupValueSex == Gender.other
                              ? true
                              : false,
                          child: TextField(
                            textCapitalization: TextCapitalization.characters,
                            textInputAction: TextInputAction.next,
                            controller: _spouseSexController,
                            decoration:
                                kTextFieldDecorationMorarMelhor.copyWith(
                                    hintText: 'Orientação Sexual do cônjuge',
                                    labelText: 'Orientação Sexual do cônjuge'),
                          )),
                      Divider(height: 5),
                      TextFieldSearch(
                        noItemfoundMessage: 'Nenhum item encontrado',
                        minStringLength: 3,
                        label: 'País-Nacionalidade',
                        initialList: listCountries,
                        controller: _spouseNacionalityController,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            hintText: 'País-Nacionalidade',
                            labelText: 'País-Nacionalidade'),
                      ),
                      Divider(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              controller: _spouseUfNaturalityController,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                labelText: 'UF',
                                hintText: 'UF',
                              ),
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Spacer(),
                          Flexible(
                              flex: 10,
                              child: TextField(
                                controller: _spouseCityNaturalityController,
                                decoration:
                                    kTextFieldDecorationMorarMelhor.copyWith(
                                  labelText: 'Cidade de Nascimento do cônjuge',
                                  hintText: 'Cidade de Nascimento do cônjuge',
                                ),
                                textCapitalization:
                                    TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                              ))
                        ],
                      ),
                      Divider(height: 5),
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        controller: _spouseMothersNameController,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Nome da mãe do cônjuge',
                            hintText: 'Nome da mãe do cônjuge'),
                      ),
                      Divider(height: 5),
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _spouseNumberDocumentController,
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Nº / Série do documento',
                            hintText: 'Nº / Série do documento'),
                      ),
                      Divider(height: 5),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextField(
                              controller: _spouseIssueDocumentController,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                labelText: 'Órgão emissor',
                                hintText: 'Órgão emissor',
                              ),
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Flexible(
                              flex: 2,
                              child: TextField(
                                maxLength: 2,
                                textCapitalization:
                                    TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                                controller: _spouseUfDocumentController,
                                decoration:
                                    kTextFieldDecorationMorarMelhor.copyWith(
                                  counterText: '',
                                  labelText: 'UF',
                                  hintText: 'UF',
                                ),
                              )),
                        ],
                      ),
                      Divider(height: 5),
                      Text('Data de expedição:'),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? _temp;
                            _temp = await showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancelar')),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  try {
                                                    _spouseDateIssueDocumentController
                                                            .text =
                                                        DateFormat('dd/MM/yy')
                                                            .format(_temp!)
                                                            .toString();
                                                  } catch (e) {
                                                    var snackBar = SnackBar(
                                                        content: Text(
                                                            'Selecione uma data!'));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'))
                                        ],
                                      ),
                                      Expanded(
                                          child: CupertinoDatePicker(
                                              maximumYear: DateTime.now().year,
                                              minimumYear: 1900,
                                              initialDateTime: DateTime.now(),
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              dateOrder:
                                                  DatePickerDateOrder.dmy,
                                              onDateTimeChanged: (changed) {
                                                _temp = changed;
                                              })),
                                    ],
                                  );
                                });
                          },
                          child: _spouseDateIssueDocumentController.text == ''
                              ? Text('Selecione')
                              : Text(_spouseDateIssueDocumentController.text)),
                      Divider(height: 5),
                      TextField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _spousePisNisPasepController,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                          labelText: 'Nº PIS/NIS/PASEP do cônjuge',
                          hintText: 'Nº PIS/NIS/PASEP do cônjuge',
                        ),
                      ),
                      Divider(height: 5),
                      TextField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TextInputMask(mask: '999.999.999-99')
                        ],
                        controller: _spouseCpfController,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                          labelText: 'CPF do cônjuge',
                          hintText: 'CPF do cônjuge',
                        ),
                      ),
                      Divider(height: 5),
                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: _spouseProfessionController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                          labelText: 'Profissão do cônjuge',
                          hintText: 'Profissão do cônjuge',
                        ),
                      ),
                      Divider(height: 5),
                      PhoneWidget(telefoneController: _spousePhoneController),
                      Divider(height: 5),
                      Text('Grau de Instrução do cônjuge:'),
                      ElevatedButton(
                          onPressed: _displaySpouseEducationLevelDialog,
                          child: _spouseEducationLevelController.text == ''
                              ? Text('Selecione')
                              : Text(_spouseEducationLevelController.text)),
                      TextField(
                        inputFormatters: [
                          TextInputMask(
                            mask: ['R!\$! !999,99', 'R!\$! 999.999,99'],
                            placeholder: '0',
                            maxPlaceHolders: 3,
                            reverse: true,
                          )
                        ],
                        controller: _spouseIndividualCashController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Renda Individual do cônjuge',
                            hintText: 'Renda Individual do cônjuge'),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Pessoa com Deficiência no Grupo Familiar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      Divider(height: 5),
                      TextField(
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          controller: _deficientNameController,
                          decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'Nome da pessoa com deficiência',
                            hintText: 'Nome da pessoa com deficiência',
                          )),
                      Divider(height: 5),
                      TextField(
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.done,
                          controller: _deficientCIDController,
                          decoration: kTextFieldDecorationMorarMelhor.copyWith(
                            labelText: 'CID do Deficiente',
                            hintText: 'CID do Deficiente',
                          )),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildResidentFamiliarList(),
                    Flexible(
                        child: ElevatedButton(
                            child: Icon(Icons.add),
                            onPressed: () {
                              final TextEditingController name =
                                  TextEditingController();
                              final TextEditingController birthDate =
                                  TextEditingController();
                              final TextEditingController cpf =
                                  TextEditingController();
                              final TextEditingController kinship =
                                  TextEditingController();
                              _residentFamiliarName.add(name);
                              _residentFamiliarBirthDate.add(birthDate);
                              _residentFamiliarCPF.add(cpf);
                              _residentFamiliarKinship.add(kinship);
                              final ResidentFamiliar residentFamiliar =
                                  ResidentFamiliar(
                                      name: name.text,
                                      birthDate: birthDate.text,
                                      cpf: cpf.text,
                                      deficient: true,
                                      kinship: kinship.text);

                              _residentFamiliarList.add(residentFamiliar);
                              for (var element in _residentFamiliarList) {
                                print(element.name);
                              }
                            }))
                  ],
                ),
              ],
            )),
          ),
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: kMorarMelhorThemeData.backgroundColor,
              label: Text(widget.hasPersonData ? 'Atualizar' : 'Salvar'),
              onPressed: () {
                addOrUpdatePerson();
              }),
          bottomNavigationBar: BottomNavigationBar(
              enableFeedback: true,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: kMorarMelhorThemeData.backgroundColor,
              currentIndex: _currentTabIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              onTap: _onTabTapped,
              items: [
                BottomNavigationBarItem(
                    label: 'Pessoa', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Cônjuge', icon: Icon(Icons.group)),
                BottomNavigationBarItem(
                    label: 'Deficiênte', icon: Icon(Icons.accessible)),
                BottomNavigationBarItem(
                    label: 'Família', icon: Icon(Icons.family_restroom)),
                BottomNavigationBarItem(label: 'Infor', icon: Icon(Icons.info)),
                BottomNavigationBarItem(label: 'Casa', icon: Icon(Icons.house)),
              ])),
    );
  }

  Future<bool?> _showConfirmationExitDialog() async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('O cadastro não foi salvo. Deseja realmente sair?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('NÃO')),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('SIM'))
            ],
          ));

  List<Widget> buildSocialMediaNetworks() {
    List<Widget> list = [];

    list.addAll([
      SocialNetworkCheck(
          text: 'Facebook',
          checkCallback: _socialNetworks.facebook!,
          toggleCallback: (newValue) => setState(() {
                _socialNetworks.facebook = newValue;
                FocusManager.instance.primaryFocus
                    ?.unfocus(); //dismiss Keyboard
              })),
      SocialNetworkCheck(
          text: 'Instagram',
          checkCallback: _socialNetworks.instagram!,
          toggleCallback: (newValue) => setState(() {
                _socialNetworks.instagram = newValue;
                FocusManager.instance.primaryFocus
                    ?.unfocus(); //dismiss Keyboard
              })),
      SocialNetworkCheck(
          text: 'Whatsapp',
          checkCallback: _socialNetworks.whatsapp!,
          toggleCallback: (newValue) => setState(() {
                _socialNetworks.whatsapp = newValue;
                FocusManager.instance.primaryFocus
                    ?.unfocus(); //dismiss Keyboard
              })),
      SocialNetworkCheck(
          text: 'Youtube',
          checkCallback: _socialNetworks.youtube!,
          toggleCallback: (newValue) => setState(() {
                _socialNetworks.youtube = newValue;
                FocusManager.instance.primaryFocus
                    ?.unfocus(); //dismiss Keyboard
              })),
    ]);

    return list;
  }

  _displayMaritalStatusDialog() {
    FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemCount: civilStateList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  _maritalStatusController.text = civilStateList[index];
                  civilStateList[index] == 'SOLTEIRO(A)' ||
                          civilStateList[index] == 'DIVORCIADO(A)' ||
                          civilStateList[index] == 'VIÚVO(A)'
                      ? _hasSpouse = false
                      : _hasSpouse = true;
                });
                Navigator.pop(context);
              },
              child: Card(
                child: ListTile(
                  title: Text(civilStateList[index].toString()),
                ),
              ),
            ),
          );
        });
  }

  _displayEducationLevelDialog() {
    FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemCount: educationLevelList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() =>
                    _educationLevelController.text = educationLevelList[index]);
                Navigator.pop(context);
              },
              child: Card(
                child: ListTile(
                  title: Text(educationLevelList[index].toString()),
                ),
              ),
            ),
          );
        });
  }

  _displaySpouseEducationLevelDialog() {
    FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemCount: educationLevelList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() => _spouseEducationLevelController.text =
                    educationLevelList[index]);
                Navigator.pop(context);
              },
              child: Card(
                child: ListTile(
                  title: Text(educationLevelList[index].toString()),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildResidentFamiliarList() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            children: []

            /*
              [
              TextField(
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      hintText: 'Nome', labelText: 'Nome')),
              Divider(height: 5),
              Text('Data de nascimento:'),
              ElevatedButton(onPressed: () {}, child: Text('Selecione')),
              TextField(
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      hintText: 'CPF', labelText: 'CPF')),
              Divider(height: 5),
              TextField(
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      hintText: 'Parentesco', labelText: 'Parentesco')),
              Divider(height: 5),
              TextField(
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      hintText: 'PCD', labelText: 'PCD')),
]
                      */
            ,
          )),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    Key? key,
    required TextEditingController numeroController,
  })  : _numberHouseController = numeroController,
        super(key: key);

  final TextEditingController _numberHouseController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: _numberHouseController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: kTextFieldDecorationMorarMelhor.copyWith(
            labelText: 'Número', hintText: 'Número'),
      ),
    );
  }
}

class BairroWidget extends StatelessWidget {
  const BairroWidget({
    Key? key,
    required TextEditingController bairroController,
  })  : _districtController = bairroController,
        super(key: key);

  final TextEditingController _districtController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: TextField(
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.next,
          controller: _districtController,
          decoration: kTextFieldDecorationMorarMelhor.copyWith(
            labelText: 'Bairro',
            hintText: 'Bairro',
          )),
    );
  }
}

class StreetWidget extends StatelessWidget {
  const StreetWidget({
    Key? key,
    required TextEditingController ruaController,
  })  : _streetController = ruaController,
        super(key: key);

  final TextEditingController _streetController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      textInputAction: TextInputAction.next,
      controller: _streetController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: kTextFieldDecorationMorarMelhor.copyWith(
        labelText: 'Rua',
        hintText: 'Rua, avenida,',
      ),
    );
  }
}

class UfWidget extends StatelessWidget {
  const UfWidget({
    Key? key,
    required TextEditingController ufController,
  })  : _ufAddressController = ufController,
        super(key: key);

  final TextEditingController _ufAddressController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: TextField(
        enabled: false,
        textCapitalization: TextCapitalization.characters,
        textInputAction: TextInputAction.next,
        controller: _ufAddressController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: kTextFieldDecorationMorarMelhor.copyWith(
          labelText: 'UF',
          hintText: 'UF',
        ),
      ),
    );
  }
}

class SocialNetworkCheck extends StatelessWidget {
  SocialNetworkCheck({
    Key? key,
    required this.text,
    required this.checkCallback,
    required this.toggleCallback,
  }) : super(key: key);
  final String text;
  final bool checkCallback;
  final void Function(bool) toggleCallback;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(text),
      labelStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.grey,
      onSelected: toggleCallback,
      selected: checkCallback,
      selectedColor: Colors.red,
    );
  }
}
