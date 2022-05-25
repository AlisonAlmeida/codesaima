// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/textfield_search.dart';
import 'package:codesaima/models/address_model.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:codesaima/models/complete_person_model.dart';
import 'package:codesaima/models/social_networks.dart';
import 'package:codesaima/screens/search_screens/qualitative_research_morar_melhor_screen.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/date_formatter.dart';

class CrudCompletePersonScreen extends StatefulWidget {
  CrudCompletePersonScreen(
      {Key? key,
      required this.hasPersonData,
      this.personIndex,
      required this.fromResearch})
      : super(key: key);

  final bool hasPersonData;
  final bool fromResearch;
  final int? personIndex;

  @override
  State<CrudCompletePersonScreen> createState() => _CrupPeopleScreen2State();
}

class _CrupPeopleScreen2State extends State<CrudCompletePersonScreen> {
  late final Box _completePersonListBox;
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _ufAddressController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _complementoController = TextEditingController();
  final _sexController = TextEditingController();
  final _nacionalityController = TextEditingController();
  final _ufNaturalityController = TextEditingController();
  final _cityNaturalityController = TextEditingController();
  final _mothersNameController = TextEditingController();
  final _fathersNameController = TextEditingController();
  final _tipeOfDocumentController = TextEditingController();
  final _numberDocumentController = TextEditingController();
  final _issueDocumentController = TextEditingController();
  final _ufDocumentController = TextEditingController();
  final _dateIssueDocumentController = TextEditingController();
  final _pisNisPasepController = TextEditingController();
  final _cpfController = TextEditingController();
  final _professionController = TextEditingController();
  final _maritalStatusController = TextEditingController();

  SocialNetworks _socialNetworks = SocialNetworks();
  Address _address = Address();
  CompletePerson _person = CompletePerson();
  int _currentStep = 0;

  @override
  void initState() {
    _completePersonListBox = Hive.box<CompletePerson>(kCompletePersonBox);
    _nacionalityController.text = 'BRASIL';
    _ufNaturalityController.text = 'RR';
    _cityNaturalityController.text = 'BOA VISTA';
    _socialNetworks.clear();
    if (widget.hasPersonData) {
      _person = _completePersonListBox.get(widget.personIndex);
      _nameController.text = _person.name;
      _telefoneController.text = _person.phone;
      _cepController.text = _person.address!.cep;
      _bairroController.text = _person.address!.bairro;
      _numeroController.text = _person.address!.numero;
      _ufAddressController.text = _person.address!.uf;
      _cidadeController.text = _person.address!.localidade;
      _ruaController.text = _person.address!.logradouro;
      _complementoController.text = _person.address!.complemento;
      _socialNetworks = _person.socialNetworks!;
    }
    super.initState();
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

  addPerson() async {
    _address = Address(
        cep: _cepController.text,
        uf: _ufAddressController.text.toUpperCase(),
        localidade: _cidadeController.text.toUpperCase(),
        logradouro: _ruaController.text.toUpperCase(),
        bairro: _bairroController.text.toUpperCase(),
        numero: _numeroController.text,
        complemento: _complementoController.text.toUpperCase());

    _person = CompletePerson(
        address: _address,
        name: _nameController.text,
        phone: _telefoneController.text,
        socialNetworks: _socialNetworks);
    _ufAddressController.text = 'RR';
    clearFields();

    await _completePersonListBox.add(_person);

    Navigator.pop(context, _person);
    if (widget.fromResearch) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QualitativeResearchMorarMelhorScreen(
                    personIndex: _completePersonListBox.keys.last,
                  )));
    }
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

    _person = CompletePerson(
        address: _address,
        name: _nameController.text.toUpperCase(),
        phone: _telefoneController.text,
        socialNetworks: _socialNetworks);

    await _completePersonListBox.put(widget.personIndex, _person);

    Navigator.pop(context, widget.personIndex);
    if (widget.fromResearch) {
      Navigator.pop(context, widget.personIndex);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QualitativeResearchMorarMelhorScreen(
                  personIndex: widget.personIndex!)));
    }
  }

  clearFields() {
    setState(() {
      _nameController.clear();
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
    setState(
        () => _currentStep >= 0 && _currentStep < 3 ? _currentStep++ : null);
  }

  _stepReturn() {
    setState(() => _currentStep > 0 ? _currentStep-- : null);
  }

  @override
  Widget build(BuildContext context) {
    _ufAddressController.text = 'RR';

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoa'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stepper(
              currentStep: _currentStep,
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    ElevatedButton(
                        onPressed: () => _stepContinue(),
                        child: Text('Continuar')),
                    ElevatedButton(
                        onPressed: () => _stepReturn(), child: Text('Voltar')),
                  ],
                );
              },
              elevation: 10,
              physics: ScrollPhysics(),
              steps: [
                Step(
                    isActive: _currentStep == 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text('Informações pessoais'),
                    content: Column(
                      children: [
                        CompletNameWidget(nameController: _nameController),
                        Divider(height: 5),
                        ElevatedButton.icon(
                            onPressed: () {}, //TODO
                            icon: Icon(Icons.calendar_month),
                            label: Text('Data de nascimento')),
                        ListTile(
                          leading: Text('Sexo:'),
                          title: DropdownButton(
                            items: sexOptions,
                            value: _sexController.text.isEmpty
                                ? 'MASCULINO'
                                : _sexController.text,
                            onChanged: (String? newValue) {
                              setState(() {
                                _sexController.text = newValue!;
                              });
                            },
                          ),
                        ),
                        Visibility(
                            visible:
                                _sexController.text == 'OUTRO' ? true : false,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                controller: _sexController,
                                decoration: kTextFieldGeneralDecoration
                                    .copyWith(hintText: 'Orientação Sexual'),
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
                                decoration:
                                    kTextFieldGeneralDecoration.copyWith(
                                  labelText: 'UF',
                                  hintText: 'UF',
                                ),
                                textCapitalization:
                                    TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Spacer(),
                            Flexible(
                                flex: 10,
                                child: TextField(
                                  controller: _cityNaturalityController,
                                  decoration:
                                      kTextFieldGeneralDecoration.copyWith(
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
                      ],
                    )),
                Step(
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text('Contato'),
                    content: Column(
                      children: [
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
                        Wrap(children: buildSocialMediaNetworks())
                      ],
                    )),
                Step(
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text('Documentação'),
                    content: Column(
                      children: [
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
                          controller: _numberDocumentController,
                          keyboardType: TextInputType.name,
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
                                decoration:
                                    kTextFieldGeneralDecoration.copyWith(
                                  labelText: 'Órgão emissor',
                                  hintText: 'Órgão emissor',
                                ),
                                textCapitalization:
                                    TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Flexible(
                                flex: 2,
                                child: TextField(
                                  controller: _ufDocumentController,
                                  decoration:
                                      kTextFieldGeneralDecoration.copyWith(
                                    labelText: 'UF',
                                    hintText: 'UF',
                                  ),
                                )),
                          ],
                        ),
                        Divider(height: 5),
                        TextField(
                          controller: _dateIssueDocumentController,
                          decoration: kTextFieldGeneralDecoration.copyWith(
                            labelText: 'Data de expedição',
                            hintText: 'Data de expedição',
                          ),
                        ),
                        Divider(height: 5),
                        TextField(
                          controller: _pisNisPasepController,
                          decoration: kTextFieldGeneralDecoration.copyWith(
                            labelText: 'Nº PIS/NIS/PASEP',
                            hintText: 'Nº PIS/NIS/PASEP',
                          ),
                        ),
                        Divider(height: 5),
                        TextField(
                          controller: _cpfController,
                          decoration: kTextFieldGeneralDecoration.copyWith(
                            labelText: 'CPF',
                            hintText: 'CPF',
                          ),
                        ),
                        TextField(
                          controller: _professionController,
                          decoration: kTextFieldGeneralDecoration.copyWith(
                            labelText: 'Profissão',
                            hintText: 'Profissão',
                          ),
                        ),
                      ],
                    )),
                Step(
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                    title: Text('Endereço'),
                    content: Column(
                      children: [
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
                                decoration:
                                    kTextFieldGeneralDecoration.copyWith(
                                        labelText: 'CEP', hintText: 'CEP'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(15)),
                                    shape: MaterialStateProperty.all(
                                        CircleBorder()),
                                  ),
                                  onPressed: () async => getCep(),
                                  child: Icon(Icons.cached)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            UfWidget(ufController: _ufAddressController),
                            Spacer(),
                            Flexible(
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
                        ComplementWidget(
                            complementoController: _complementoController),
                        TextField(
                          controller: _maritalStatusController,
                          decoration: kTextFieldGeneralDecoration.copyWith(
                            labelText: 'Estado Civil',
                            hintText: 'Estado Civil',
                          ),
                        ),
                        Row(
                          children: buildOptionButtons(),
                        )
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
REFERENCE OF DATETIME
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        initialDatePickerMode: DatePickerMode.year,
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }*/

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
}

class ComplementWidget extends StatelessWidget {
  const ComplementWidget({
    Key? key,
    required TextEditingController complementoController,
  })  : _complementoController = complementoController,
        super(key: key);

  final TextEditingController _complementoController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        textCapitalization: TextCapitalization.characters,
        textInputAction: TextInputAction.next,
        controller: _complementoController,
        decoration: kTextFieldGeneralDecoration.copyWith(
          labelText: 'Complemento',
          hintText: 'Complemento',
        ));
  }
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
      flex: 2,
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
    return TextFormField(
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
