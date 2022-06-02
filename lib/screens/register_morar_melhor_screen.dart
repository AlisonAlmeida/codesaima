// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/textfield_search.dart';
import 'package:codesaima/models/address_model.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:codesaima/models/person_spouse.dart';
import 'package:codesaima/models/register_person_morar_melhor_model.dart';
import 'package:codesaima/models/social_networks.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
//import 'package:pattern_formatter/date_formatter.dart';

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
  final _telefoneController = TextEditingController();
  final _tipeOfDocumentController = TextEditingController();
  final _numberDocumentController = TextEditingController();
  final _issueDocumentController = TextEditingController();
  final _ufDocumentController = TextEditingController();
  final _dateIssueDocumentController = TextEditingController();
  final _pisNisPasepController = TextEditingController();
  final _cpfController = TextEditingController();
  final _professionController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _ufAddressController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _complementoController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _educationLevelController = TextEditingController();
  final _individualCashController = TextEditingController();
  final _familiarCashController = TextEditingController();

  final _deficientNameController = TextEditingController();
  final _deficientCIDController = TextEditingController();

  SocialNetworks _socialNetworks = SocialNetworks();
  Address _address = Address();
  RegisterMorarMelhor _person = RegisterMorarMelhor();
  PersonSpouse _personSpouse = PersonSpouse();
  int _currentStep = 0;
  List<Step> _steps = [];
  int _groupValueSex = 0;
  bool _hasSpouse = false;

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

//_sexController    <=
      if (_person.sex == 'MASCULINO') {
        _groupValueSex = 1;
        _sexController.text = 'MASCULINO';
      } else if (_person.sex == 'FEMININO') {
        _groupValueSex = 2;
        _sexController.text = 'FEMININO';
      } else {
        _sexController.text = _person.sex;
        _groupValueSex = 3;
      }
      _nacionalityController.text = _person.nacionality;
      _mothersNameController.text = _person.mothersName;
      _fathersNameController.text = _person.fathersName;
      _telefoneController.text = _person.phone;
      _socialNetworks = _person.socialNetworks!;
      _tipeOfDocumentController.text = _person.typeOfDocument;
      _numberDocumentController.text = _person.numberDocument;
      _issueDocumentController.text = _person.issueDocument;
      _ufDocumentController.text = _person.ufDocument;
      _dateIssueDocumentController.text = _person.dateIssueDocument;
      _pisNisPasepController.text = _person.pisNisPasep;
      _cpfController.text = _person.cpf;
      _professionController.text = _person.profession;

      _cepController.text = _person.address!.cep;
      _bairroController.text = _person.address!.bairro;
      _numeroController.text = _person.address!.numero;
      _ufAddressController.text = _person.address!.uf;
      _cidadeController.text = _person.address!.localidade;
      _ruaController.text = _person.address!.logradouro;
      _complementoController.text = _person.address!.complemento;
      _maritalStatusController.text = _person.maritalStatus;
      _educationLevelController.text = _person.educationLevel;
      _individualCashController.text = _person.individualCash;
      _familiarCashController.text = _person.familiarCash;

      if (_hasSpouse) {
        _personSpouse.birthDate = _person.personSpouse!.birthDate;
      }
    }
    super.initState();
  }

  addPerson() async {
    _address = Address(
        cep: _cepController.text,
        uf: _ufAddressController.text.toUpperCase(),
        localidade: _cidadeController.text.toUpperCase(),
        logradouro: _ruaController.text.toUpperCase(),
        bairro: _bairroController.text.toUpperCase(),
        numero: _numeroController.text,
        complemento: _complementoController.text.toUpperCase());

    _person = RegisterMorarMelhor(
      address: _address,
      birthDate: _birthDateController.text.toUpperCase(),
      sex: _sexController.text.toUpperCase(),
      name: _nameController.text.toUpperCase(),
      nacionality: _nacionalityController.text.toUpperCase(),
      mothersName: _mothersNameController.text.toUpperCase(),
      fathersName: _fathersNameController.text.toUpperCase(),
      phone: _telefoneController.text,
      socialNetworks: _socialNetworks,
      typeOfDocument: _tipeOfDocumentController.text.toUpperCase(),
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
    );

    clearFields();

    await _completePersonListBox.add(_person);

    Navigator.pop(context, _person);
  }

  updatePerson() async {
    _address = Address(
        cep: _cepController.text,
        uf: _ufAddressController.text.toUpperCase(),
        localidade: _cidadeController.text.toUpperCase(),
        logradouro: _ruaController.text.toUpperCase(),
        bairro: _bairroController.text.toUpperCase(),
        numero: _numeroController.text,
        complemento: _complementoController.text.toUpperCase());

    _person = RegisterMorarMelhor(
      address: _address,
      birthDate: _birthDateController.text.toUpperCase(),
      sex: _sexController.text.toUpperCase(),
      name: _nameController.text.toUpperCase(),
      nacionality: _nacionalityController.text.toUpperCase(),
      mothersName: _mothersNameController.text.toUpperCase(),
      fathersName: _fathersNameController.text.toUpperCase(),
      phone: _telefoneController.text,
      socialNetworks: _socialNetworks,
      typeOfDocument: _tipeOfDocumentController.text.toUpperCase(),
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
    );

    await _completePersonListBox.put(widget.personIndex, _person);

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
          _cidadeController.text = _address.localidade.toUpperCase();
          _bairroController.text = _address.bairro.toUpperCase();
          _ruaController.text = _address.logradouro.toUpperCase();
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

  clearFields() {
    setState(() {
      _nameController.clear();
      _groupValueSex = 0;
      _birthDateController.clear();
      _cepController.clear();
      _ruaController.clear();
      _bairroController.clear();
      _numeroController.clear();
      _telefoneController.clear();
      _cidadeController.clear();
      _complementoController.clear();
    });
  }

  _stepContinue() {
    setState(() =>
        !_hasSpouse && _currentStep == 0 ? _currentStep = 2 : _currentStep++);
  }

  _stepBack() {
    setState(() =>
        !_hasSpouse && _currentStep == 2 ? _currentStep = 0 : _currentStep--);
  }

  _stepTapped(int newStep) {
    setState(() {
      if (!_hasSpouse && newStep != 1) {
        //solteiro e newStep diferente de 1
        _currentStep = newStep;
      } else if (!_hasSpouse && newStep == 1) {
        //solteiro e newStep igual a 1
        var snackBar = SnackBar(
            content: Text(
                '${_nameController.text} Está solteiro. Mude o Estado Civil'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        _currentStep = newStep;
      }
    });
  }

  List<Step> _buildSteps() {
    _steps = [
      Step(
          isActive: true,
          title: Text('Dados Pessoais do Responsável Familiar'),
          content: Column(
            children: [
              Divider(height: 5),
              CompletNameWidget(nameController: _nameController),
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
                                      onPressed: () => Navigator.pop(context),
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
                                            ScaffoldMessenger.of(context)
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
                                      maximumYear: DateTime.now().year - 10,
                                      minimumYear: 1900,
                                      initialDateTime: DateTime(2000),
                                      mode: CupertinoDatePickerMode.date,
                                      dateOrder: DatePickerDateOrder.dmy,
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
              RadioListTile<int>(
                  secondary: Icon(Icons.male),
                  value: 1,
                  title: Text('Masculino'),
                  groupValue: _groupValueSex,
                  onChanged: (newValue) => setState(() {
                        _groupValueSex = newValue!;
                        _sexController.text = 'MASCULINO';
                      })),
              RadioListTile<int>(
                  secondary: Icon(Icons.female),
                  value: 2,
                  title: Text('Feminino'),
                  groupValue: _groupValueSex,
                  onChanged: (newValue) => setState(() {
                        _groupValueSex = newValue!;
                        _sexController.text = 'FEMININO';
                      })),
              RadioListTile<int>(
                  secondary: Icon(Icons.question_mark),
                  value: 3,
                  title: Text('Outro'),
                  groupValue: _groupValueSex,
                  onChanged: (newValue) =>
                      setState(() => _groupValueSex = newValue!)),
              Visibility(
                  visible: _groupValueSex == 3 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      controller: _sexController,
                      decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
                    hintText: 'País-Nacionalidade',
                    labelText: 'País-Nacionalidade'),
              ),
              Divider(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _ufNaturalityController,
                      decoration: kTextFieldGeneralDecoration.copyWith(
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
                        decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
                    labelText: 'Nome da Mãe',
                    hintText: 'Nome do Mãe',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.person),
                    )),
              ),
              Divider(height: 5),
              TextFormField(
                onEditingComplete: () => _stepContinue(),
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.characters,
                controller: _fathersNameController,
                keyboardType: TextInputType.name,
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                controller: _tipeOfDocumentController,
                keyboardType: TextInputType.name,
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                      decoration: kTextFieldGeneralDecoration.copyWith(
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
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        controller: _ufDocumentController,
                        decoration: kTextFieldGeneralDecoration.copyWith(
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
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancelar')),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          try {
                                            _dateIssueDocumentController.text =
                                                DateFormat('dd/MM/yy')
                                                    .format(_temp!)
                                                    .toString();
                                          } catch (e) {
                                            var snackBar = SnackBar(
                                                content: Text(
                                                    'Selecione uma data!'));
                                            ScaffoldMessenger.of(context)
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
                                      initialDateTime: DateTime(2000),
                                      mode: CupertinoDatePickerMode.date,
                                      dateOrder: DatePickerDateOrder.dmy,
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
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
                  labelText: 'CPF',
                  hintText: 'CPF',
                ),
              ),
              Divider(height: 5),
              TextField(
                onEditingComplete: () => _stepContinue(),
                textInputAction: TextInputAction.done,
                controller: _professionController,
                textCapitalization: TextCapitalization.characters,
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                      decoration: kTextFieldGeneralDecoration.copyWith(
                          labelText: 'CEP', hintText: 'CEP'),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(15)),
                          shape: MaterialStateProperty.all(CircleBorder()),
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
                      decoration: kTextFieldGeneralDecoration,
                      items: dropdownCities,
                      value: _cidadeController.text.isEmpty
                          ? 'BOA VISTA'
                          : _cidadeController.text,
                      onChanged: (String? newValue) {
                        setState(() {
                          _cidadeController.text = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Divider(height: 5),
              StreetWidget(ruaController: _ruaController),
              Divider(height: 5),
              Row(
                children: [
                  BairroWidget(bairroController: _bairroController),
                  Spacer(),
                  NumberWidget(numeroController: _numeroController),
                ],
              ),
              Divider(height: 5),
              TextField(
                  textCapitalization: TextCapitalization.characters,
                  onEditingComplete: () => _stepContinue(),
                  textInputAction: TextInputAction.done,
                  controller: _complementoController,
                  decoration: kTextFieldGeneralDecoration.copyWith(
                    labelText: 'Complemento',
                    hintText: 'Complemento',
                  )),
              Divider(height: 5),
              PhoneWidget(telefoneController: _telefoneController),
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
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
                    labelText: 'Renda Familiar', hintText: 'Renda Familiar'),
              ),
            ],
          )),
      Step(
          isActive: _hasSpouse,
          title: Text('Dados Pessoais do Cônjuge'),
          content: Column(
            children: [
              Divider(height: 5),
              CompletNameWidget(nameController: _nameController),
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
                                      onPressed: () => Navigator.pop(context),
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
                                            ScaffoldMessenger.of(context)
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
                                      maximumYear: DateTime.now().year - 10,
                                      minimumYear: 1900,
                                      initialDateTime: DateTime(2000),
                                      mode: CupertinoDatePickerMode.date,
                                      dateOrder: DatePickerDateOrder.dmy,
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
              RadioListTile<int>(
                  secondary: Icon(Icons.male),
                  value: 1,
                  title: Text('Masculino'),
                  groupValue: _groupValueSex,
                  onChanged: (newValue) => setState(() {
                        _groupValueSex = newValue!;
                        _sexController.text = 'MASCULINO';
                      })),
              RadioListTile<int>(
                  secondary: Icon(Icons.female),
                  value: 2,
                  title: Text('Feminino'),
                  groupValue: _groupValueSex,
                  onChanged: (newValue) => setState(() {
                        _groupValueSex = newValue!;
                        _sexController.text = 'FEMININO';
                      })),
              RadioListTile<int>(
                  secondary: Icon(Icons.question_mark),
                  value: 3,
                  title: Text('Outro'),
                  groupValue: _groupValueSex,
                  onChanged: (newValue) =>
                      setState(() => _groupValueSex = newValue!)),
              Visibility(
                  visible: _groupValueSex == 3 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      controller: _sexController,
                      decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
                    hintText: 'País-Nacionalidade',
                    labelText: 'País-Nacionalidade'),
              ),
              Divider(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _ufNaturalityController,
                      decoration: kTextFieldGeneralDecoration.copyWith(
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
                        decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
                    labelText: 'Nome da Mãe',
                    hintText: 'Nome do Mãe',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.person),
                    )),
              ),
              Divider(height: 5),
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.next,
                controller: _tipeOfDocumentController,
                keyboardType: TextInputType.name,
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                      decoration: kTextFieldGeneralDecoration.copyWith(
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
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        controller: _ufDocumentController,
                        decoration: kTextFieldGeneralDecoration.copyWith(
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
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancelar')),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          try {
                                            _dateIssueDocumentController.text =
                                                DateFormat('dd/MM/yy')
                                                    .format(_temp!)
                                                    .toString();
                                          } catch (e) {
                                            var snackBar = SnackBar(
                                                content: Text(
                                                    'Selecione uma data!'));
                                            ScaffoldMessenger.of(context)
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
                                      initialDateTime: DateTime(2000),
                                      mode: CupertinoDatePickerMode.date,
                                      dateOrder: DatePickerDateOrder.dmy,
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
                decoration: kTextFieldGeneralDecoration.copyWith(
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
                decoration: kTextFieldGeneralDecoration.copyWith(
                  labelText: 'CPF',
                  hintText: 'CPF',
                ),
              ),
              Divider(height: 5),
              TextField(
                onEditingComplete: () => _stepContinue(),
                textInputAction: TextInputAction.done,
                controller: _professionController,
                textCapitalization: TextCapitalization.characters,
                decoration: kTextFieldGeneralDecoration.copyWith(
                  labelText: 'Profissão',
                  hintText: 'Profissão',
                ),
              ),
              Divider(height: 5),
              PhoneWidget(telefoneController: _telefoneController),
            ],
          )),
      Step(
          isActive: true,
          title: Text('Pessoa com Deficiência no Grupo Familiar'),
          content: Column(
            children: [
              Divider(height: 5),
              TextField(
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next,
                  controller: _deficientNameController,
                  decoration: kTextFieldGeneralDecoration.copyWith(
                    labelText: 'Nome da pessoa com deficiência',
                    hintText: 'Nome da pessoa com deficiência',
                  )),
              Divider(height: 5),
              TextField(
                  textCapitalization: TextCapitalization.characters,
                  //onEditingComplete: () => _stepContinue(),
                  textInputAction: TextInputAction.done,
                  controller: _deficientCIDController,
                  decoration: kTextFieldGeneralDecoration.copyWith(
                    labelText: 'CID do Deficiente',
                    hintText: 'CID do Deficiente',
                  )),
            ],
          ))
    ];

    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    _ufAddressController.text = 'RR';

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showConfirmationDialog();
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Pessoa'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stepper(
                onStepTapped: (newStep) => _stepTapped(newStep),
                currentStep: _currentStep,
                physics: ScrollPhysics(),
                type: StepperType.vertical,
                controlsBuilder: (context, details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_currentStep != 0)
                        ElevatedButton(
                            onPressed: () => _stepBack(),
                            child: Icon(Icons.keyboard_arrow_left)),
                      if (_currentStep != _steps.length - 1)
                        ElevatedButton(
                            onPressed: () => _stepContinue(),
                            child: Icon(Icons.keyboard_arrow_right))
                    ],
                  );
                },
                steps: _buildSteps(),
              ),
              Row(
                children: buildOptionButtons(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog() async => showDialog(
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
              })),
      SocialNetworkCheck(
          text: 'Instagram',
          checkCallback: _socialNetworks.instagram!,
          toggleCallback: (newValue) => setState(() {
                _socialNetworks.instagram = newValue;
              })),
      SocialNetworkCheck(
          text: 'Whatsapp',
          checkCallback: _socialNetworks.whatsapp!,
          toggleCallback: (newValue) => setState(() {
                _socialNetworks.whatsapp = newValue;
              })),
      SocialNetworkCheck(
          text: 'Youtube',
          checkCallback: _socialNetworks.youtube!,
          toggleCallback: (newValue) => setState(() {
                _socialNetworks.youtube = newValue;
              })),
    ]);

    return list;
  }

  List<Widget> buildOptionButtons() {
    final List<Widget> list = [];
    if (widget.hasPersonData) {
      //build button updateButton
      list.addAll([
        Expanded(
          child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel),
              label: Text('Cancelar')),
        ),
        VerticalDivider(),
        Expanded(
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.green[700]),
              onPressed: () {
                updatePerson();
              },
              icon: Icon(Icons.save, color: Colors.white),
              label: Text('Atualizar', style: TextStyle(color: Colors.white))),
        )
      ]);
    } else {
      //build button saveButton
      list.addAll([
        Expanded(
          child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel),
              label: Text('Cancelar')),
        ),
        VerticalDivider(),
        Expanded(
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.green[700]),
              onPressed: () {
                addPerson();
              },
              icon: Icon(Icons.save, color: Colors.white),
              label: Text('Salvar', style: TextStyle(color: Colors.white))),
        )
      ]);
    }
    return list;
  }

  _displayMaritalStatusDialog() {
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
}

Widget buildList() {
  return Text('data');
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    Key? key,
    required TextEditingController numeroController,
  })  : _numeroController = numeroController,
        super(key: key);

  final TextEditingController _numeroController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: _numeroController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: kTextFieldGeneralDecoration.copyWith(
            labelText: 'Número', hintText: 'Número'),
      ),
    );
  }
}

class BairroWidget extends StatelessWidget {
  const BairroWidget({
    Key? key,
    required TextEditingController bairroController,
  })  : _bairroController = bairroController,
        super(key: key);

  final TextEditingController _bairroController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: TextField(
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.next,
          controller: _bairroController,
          decoration: kTextFieldGeneralDecoration.copyWith(
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
  })  : _ruaController = ruaController,
        super(key: key);

  final TextEditingController _ruaController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      textInputAction: TextInputAction.next,
      controller: _ruaController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: kTextFieldGeneralDecoration.copyWith(
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
        decoration: kTextFieldGeneralDecoration.copyWith(
          labelText: 'UF',
          hintText: 'UF',
        ),
      ),
    );
  }
}

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    Key? key,
    required TextEditingController telefoneController,
  })  : _telefoneController = telefoneController,
        super(key: key);

  final TextEditingController _telefoneController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputMask(mask: '(99)9 9999-9999')
      ],
      keyboardType: TextInputType.number,
      controller: _telefoneController,
      decoration: kTextFieldGeneralDecoration.copyWith(
        labelText: 'Telefone',
        hintText: '(95)98765-4321',
        prefixIcon: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.phone),
        ),
      ),
    );
  }
}

class CompletNameWidget extends StatelessWidget {
  const CompletNameWidget({
    Key? key,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      textInputAction: TextInputAction.next,
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: kTextFieldGeneralDecoration.copyWith(
          labelText: 'Nome',
          hintText: 'Nome Completo',
          prefixIcon: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.person),
          )),
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
