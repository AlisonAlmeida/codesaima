// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/address_model.dart';
import 'package:codesaima/core/boxes.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:codesaima/core/person_model.dart';

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MorarMelhorSearchScreen extends StatefulWidget {
  const MorarMelhorSearchScreen({Key? key}) : super(key: key);

  @override
  State<MorarMelhorSearchScreen> createState() =>
      _MorarMelhorSearchScreen2State();
}

class _MorarMelhorSearchScreen2State extends State<MorarMelhorSearchScreen> {
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
  List<Person> listOfpeople = [];

  void getCep() async {
    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard
    Address cepModel = Address();
    NetworkHelper networkHelper =
        NetworkHelper('https://viacep.com.br/ws/${_cepController.text}/json/');
    try {
      cepModel = await networkHelper.getData();
      _bairroController.text = cepModel.bairro;
      _ruaController.text = cepModel.logradouro;
      _ufController.text = cepModel.uf;
      _cidadeController.text = cepModel.localidade;
    } catch (e) {
      var snackBar = SnackBar(content: Text('Erro'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    EasyLoading.dismiss();
  }

  addPerson(Person person) {
    listOfpeople.add(person);
    final box = Boxes.getPeople();
    box.add(person);
  }

  @override
  Widget build(BuildContext context) {
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
            reverse: true,
            child: Column(
              children: [
                Divider(),
                CompletNameWidget(nameController: _nameController),
                Divider(),
                PhoneWidget(telefoneController: _telefoneController),
                Divider(),
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
                      Divider(),
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
                      Divider(),
                      Row(
                        children: [
                          UfWidget(ufController: _ufController),
                          Spacer(),
                          CityWidget(cidadeController: _cidadeController),
                        ],
                      ),
                      Divider(),
                      StreetWidget(ruaController: _ruaController),
                      Divider(),
                      Row(
                        children: [
                          BairroWidget(bairroController: _bairroController),
                          Spacer(),
                          NumberWidget(numeroController: _numeroController),
                        ],
                      ),
                      Divider(),
                      ComplementWidget(
                          complementoController: _complementoController),
                    ],
                  ),
                ),
                Divider(),
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
                      Divider(),
                      Row(children: checkBoxSocialNetworkMorarMelhor()),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.cancel),
                          label: Text('Cancelar')),
                    ),
                    Spacer(),
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
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> checkBoxSocialNetworkMorarMelhor() {
    return [
      Expanded(
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.orange,
            title: Text('Facebook'),
            value: _facebookSocialMedia,
            onChanged: (value) {
              setState(() {
                _facebookSocialMedia = value!;
                if (_facebookSocialMedia) {
                  socialMedia.add('Facebook');
                } else {
                  socialMedia.remove('Facebook');
                }
              });
            }),
      ),
      Expanded(
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.orange,
            title: Text('Instagram'),
            value: _instagramSocialMedia,
            onChanged: (value) {
              setState(() {
                _instagramSocialMedia = value!;
                if (_instagramSocialMedia) {
                  socialMedia.add('Instagram');
                } else {
                  socialMedia.remove('Instagram');
                }
              });
            }),
      ),
      Expanded(
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.orange,
            title: Text('Whatsapp'),
            value: _whatsappSocialMedia,
            onChanged: (value) {
              setState(() {
                _whatsappSocialMedia = value!;
                if (_whatsappSocialMedia) {
                  socialMedia.add('Whatsapp');
                } else {
                  socialMedia.remove('Whatsapp');
                }
              });
            }),
      ),
      Expanded(
        child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.orange,
            title: Text('Youtube'),
            value: _youtubeSocialMedia,
            onChanged: (value) {
              setState(() {
                _youtubeSocialMedia = value!;
                if (_youtubeSocialMedia) {
                  socialMedia.add('Youtube');
                } else {
                  socialMedia.remove('Youtube');
                }
              });
            }),
      ),
    ];
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
      flex: 5,
      child: TextField(
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
    return TextField(
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
