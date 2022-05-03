// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/address_model.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:codesaima/core/person_model.dart';
import 'package:codesaima/core/social_networks.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CrudPersonScreen extends StatefulWidget {
  CrudPersonScreen(
      {Key? key,
      required this.person,
      required this.hasPersonData,
      this.personIndex})
      : super(key: key);
  final Person person;
  final bool hasPersonData;
  final int? personIndex;

  @override
  State<CrudPersonScreen> createState() => _CrupPeopleScreen2State();
}

class _CrupPeopleScreen2State extends State<CrudPersonScreen> {
  final personListBox = Hive.box<Person>('personList');

  final String name = 'Morar Melhor';
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _ufController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _complementoController = TextEditingController();
  final _estadoController = TextEditingController();

  SocialNetworks socialNetworks = SocialNetworks();

  Address address = Address();
  Person person = Person();

  @override
  void initState() {
    socialNetworks.clear();
    if (widget.hasPersonData) {
      person = widget.person;
      _nameController.text = person.name;
      _telefoneController.text = person.phone;
      _cepController.text = person.address!.cep;
      _bairroController.text = person.address!.bairro;
      _numeroController.text = person.address!.numero;
      _ufController.text = person.address!.uf;
      _cidadeController.text = person.address!.localidade;
      _ruaController.text = person.address!.logradouro;
      _complementoController.text = person.address!.complemento;
      socialNetworks = person.socialNetworks!;
    }
    super.initState();
  }

  void getCep() async {
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard

    NetworkHelper networkHelper =
        NetworkHelper('https://viacep.com.br/ws/${_cepController.text}/json/');
    try {
      address = await networkHelper.getData();
      setState(() {
        if (address.uf == 'RR') {
          _ufController.text = 'RR';
          _cidadeController.text = address.localidade.toUpperCase();
          _bairroController.text = address.bairro.toUpperCase();
          _ruaController.text = address.logradouro.toUpperCase();
        }
      });
    } catch (e) {
      var snackBar = SnackBar(content: Text('Erro'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    EasyLoading.dismiss();
  }

  addPerson() {
    EasyLoading.show();
    final address = Address(
        cep: _cepController.text,
        uf: _ufController.text.toUpperCase(),
        localidade: _cidadeController.text.toUpperCase(),
        logradouro: _ruaController.text.toUpperCase(),
        bairro: _bairroController.text.toUpperCase(),
        numero: _numeroController.text,
        complemento: _complementoController.text.toUpperCase());

    final person = Person(
        address: address,
        name: _nameController.text,
        phone: _telefoneController.text,
        socialNetworks: socialNetworks);
    _ufController.text = 'RR';
    clearFields();

    personListBox.add(person);
    EasyLoading.dismiss();
    Navigator.pop(context);
  }

  updatePerson() {
    EasyLoading.show();

    final address = Address(
        cep: _cepController.text,
        uf: _ufController.text.toUpperCase(),
        localidade: _cidadeController.text.toUpperCase(),
        logradouro: _ruaController.text.toUpperCase(),
        bairro: _bairroController.text.toUpperCase(),
        numero: _numeroController.text,
        complemento: _complementoController.text.toUpperCase());

    final person = Person(
        address: address,
        name: _nameController.text.toUpperCase(),
        phone: _telefoneController.text,
        socialNetworks: socialNetworks);

    personListBox.put(widget.personIndex!, person);
    EasyLoading.dismiss();
    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    _estadoController.text = 'RR';
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoa'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(height: 5),
                CompletNameWidget(nameController: _nameController),
                Divider(height: 5),
                PhoneWidget(telefoneController: _telefoneController),
                Divider(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.room,
                            color: Colors.blueGrey[300],
                          ),
                          Text(
                            'Endereço:',
                            style: TextStyle(color: Colors.blueGrey[300]),
                          ),
                        ],
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
                          UfWidget(ufController: _ufController),
                          Spacer(),
                          Flexible(
                            flex: 10,
                            child: DropdownButtonFormField(
                              decoration: kTextFieldDecorationMorarMelhor,
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
                    ],
                  ),
                ),
                Divider(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
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
                  ),
                ),
                Divider(height: 5),
                Row(
                  children: buildOptionButtons(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildSocialMediaNetworks() {
    List<Widget> list = [];

    list.addAll([
      SocialNetworkCheck(
          text: 'Facebook',
          checkCallback: socialNetworks.facebook!,
          toggleCallback: (newValue) => setState(() {
                socialNetworks.facebook = newValue;
              })),
      SocialNetworkCheck(
          text: 'Instagram',
          checkCallback: socialNetworks.instagram!,
          toggleCallback: (newValue) => setState(() {
                socialNetworks.instagram = newValue;
              })),
      SocialNetworkCheck(
          text: 'Whatsapp',
          checkCallback: socialNetworks.whatsapp!,
          toggleCallback: (newValue) => setState(() {
                socialNetworks.whatsapp = newValue;
              })),
      SocialNetworkCheck(
          text: 'Youtube',
          checkCallback: socialNetworks.youtube!,
          toggleCallback: (newValue) => setState(() {
                socialNetworks.youtube = newValue;
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
              onPressed: () {},
              icon: Icon(Icons.cancel),
              label: Text('Cancelar')),
        ),
        VerticalDivider(),
        Expanded(
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              onPressed: () {
                updatePerson();
              },
              icon: Icon(Icons.save),
              label: Text('Atualizar')),
        )
      ]);
    } else {
      //build button saveButton
      list.addAll([
        Expanded(
          child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.cancel),
              label: Text('Cancelar')),
        ),
        VerticalDivider(),
        Expanded(
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                addPerson();
              },
              icon: Icon(Icons.save),
              label: Text('Salvar')),
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
        decoration: kTextFieldDecorationMorarMelhor.copyWith(
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
      decoration: kTextFieldDecorationMorarMelhor.copyWith(
        labelText: 'Rua',
        hintText: 'Rua, avenida,',
      ),
    );
  }
}

class CityWidget extends StatelessWidget {
  const CityWidget({
    Key? key,
    required TextEditingController cidadeController,
  })  : _cidadeController = cidadeController,
        super(key: key);

  final TextEditingController _cidadeController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 25,
      child: TextField(
        enabled: false,
        textCapitalization: TextCapitalization.characters,
        textInputAction: TextInputAction.next,
        controller: _cidadeController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: kTextFieldDecorationMorarMelhor.copyWith(
          labelText: 'Cidade',
          hintText: 'Cidade',
        ),
      ),
    );
  }
}

class UfWidget extends StatelessWidget {
  const UfWidget({
    Key? key,
    required TextEditingController ufController,
  })  : _ufController = ufController,
        super(key: key);

  final TextEditingController _ufController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: TextField(
        enabled: false,
        textCapitalization: TextCapitalization.characters,
        textInputAction: TextInputAction.next,
        controller: _ufController,
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
      decoration: kTextFieldDecorationMorarMelhor.copyWith(
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
      decoration: kTextFieldDecorationMorarMelhor.copyWith(
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