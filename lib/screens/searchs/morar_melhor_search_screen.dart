// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/cep_model.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MorarMelhorSearchScreen extends StatelessWidget {
  MorarMelhorSearchScreen({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    void getCep() async {
      EasyLoading.show();
      FocusManager.instance.primaryFocus?.unfocus(); //dismiss Keyboard
      CepModel cepModel = CepModel();
      NetworkHelper networkHelper = NetworkHelper(
          'https://viacep.com.br/ws/${_cepController.text}/json/');

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
                TextField(
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
                ),
                Divider(),
                TextField(
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
                ),
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
                          Expanded(
                            flex: 5,
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                              controller: _ufController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                labelText: 'UF',
                                hintText: 'UF',
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 25,
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              textInputAction: TextInputAction.next,
                              controller: _cidadeController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                labelText: 'Cidade',
                                hintText: 'Cidade',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      TextField(
                        textCapitalization: TextCapitalization.characters,
                        textInputAction: TextInputAction.next,
                        controller: _ruaController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: kTextFieldDecorationMorarMelhor.copyWith(
                          labelText: 'Rua',
                          hintText: 'Rua, avenida,',
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: TextField(
                                textCapitalization:
                                    TextCapitalization.characters,
                                textInputAction: TextInputAction.next,
                                controller: _bairroController,
                                decoration:
                                    kTextFieldDecorationMorarMelhor.copyWith(
                                  labelText: 'Bairro',
                                  hintText: 'Bairro',
                                )),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 6,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: _numeroController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  kTextFieldDecorationMorarMelhor.copyWith(
                                      labelText: 'Número', hintText: 'Número'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
