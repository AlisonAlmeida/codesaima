// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_const_constructors_in_immutables

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/address_model.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:codesaima/core/person_model.dart';
import 'package:codesaima/screens/list_of_people.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MorarMelhorSearchScreen extends StatefulWidget {
  MorarMelhorSearchScreen({Key? key}) : super(key: key);

  @override
  State<MorarMelhorSearchScreen> createState() =>
      _MorarMelhorSearchScreen2State();
}

class _MorarMelhorSearchScreen2State extends State<MorarMelhorSearchScreen> {
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

  bool _facebookSocialMedia = false;
  bool _instagramSocialMedia = false;
  bool _youtubeSocialMedia = false;
  bool _whatsappSocialMedia = false;

  List<String> socialMedia = [];

  void getCep() async {
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard
    Address cepModel = Address();
    NetworkHelper networkHelper =
        NetworkHelper('https://viacep.com.br/ws/${_cepController.text}/json/');
    try {
      cepModel = await networkHelper.getData();
      setState(() {
        _bairroController.text = cepModel.bairro;
        _ruaController.text = cepModel.logradouro;
        _cidadeController.text = cepModel.localidade;
      });
    } catch (e) {
      var snackBar = SnackBar(content: Text('Erro'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    EasyLoading.dismiss();
  }

  addPerson(Person person) {
    clearFields();

    personListBox.add(person);
  }

  removeLastPerson() {
    personListBox.deleteAt(personListBox.length - 1);
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

      _facebookSocialMedia = false;
      _instagramSocialMedia = false;
      _youtubeSocialMedia = false;
      _whatsappSocialMedia = false;
      socialMedia = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    _ufController.text = 'RR';

    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisa Morar Melhor'),
        backgroundColor: Colors.orange,
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
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.orange),
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
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 5,
                            child: DropdownButtonFormField(
                              decoration: kTextFieldDecorationMorarMelhor,
                              items: dropdownCities,
                              value: _cidadeController.text.isEmpty
                                  ? 'Boa Vista'
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
                      Row(
                        children: [
                          SocialNetworkCheck(
                              text: 'Facebook',
                              checkCallback: _facebookSocialMedia,
                              toggleCallback: () => setState(() {
                                    _facebookSocialMedia =
                                        !_facebookSocialMedia;
                                    _facebookSocialMedia
                                        ? socialMedia.add('Facebook')
                                        : socialMedia.remove('Facebook');
                                  })),
                          SocialNetworkCheck(
                              text: 'Instagram',
                              checkCallback: _instagramSocialMedia,
                              toggleCallback: () => setState(() {
                                    _instagramSocialMedia =
                                        !_instagramSocialMedia;
                                    _instagramSocialMedia
                                        ? socialMedia.add('Instagram')
                                        : socialMedia.remove('Instagram');
                                  })),
                          SocialNetworkCheck(
                              text: 'Whatsapp',
                              checkCallback: _whatsappSocialMedia,
                              toggleCallback: () => setState(() {
                                    _whatsappSocialMedia =
                                        !_whatsappSocialMedia;
                                    _whatsappSocialMedia
                                        ? socialMedia.add('Whatsapp')
                                        : socialMedia.remove('Whatsapp');
                                  })),
                          SocialNetworkCheck(
                              text: 'Youtube',
                              checkCallback: _youtubeSocialMedia,
                              toggleCallback: () => setState(() {
                                    _youtubeSocialMedia = !_youtubeSocialMedia;
                                    _youtubeSocialMedia
                                        ? socialMedia.add('Youtube')
                                        : socialMedia.remove('Youtube');
                                  })),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.cancel),
                          label: Text('Cancelar')),
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            final address = Address(
                              cep: _cepController.text,
                              uf: _ufController.text,
                              localidade: _cidadeController.text,
                              logradouro: _ruaController.text,
                              bairro: _bairroController.text,
                              numero: _numeroController.text,
                              complemento: _complementoController.text,
                            );

                            final person = Person(
                                address: address,
                                name: _nameController.text,
                                phone: _telefoneController.text,
                                socialNetworks: socialMedia);

                            addPerson(person);
                          },
                          icon: Icon(Icons.save),
                          label: Text('Salvar')),
                    ),
                    Expanded(
                        child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      label: Text(
                        'Lista de Pessoas',
                      ),
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOfPeople()),
                        );
                      },
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
      keyboardType: TextInputType.phone,
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
  final void Function() toggleCallback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: toggleCallback,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: checkCallback ? Colors.amber : Colors.white,
              border: Border.all(),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight:
                    checkCallback ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
