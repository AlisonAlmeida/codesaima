// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:codesaima/core/cep_model.dart';
import 'package:codesaima/core/cep_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MorarMelhorSearchScreen extends StatelessWidget {
  MorarMelhorSearchScreen({Key? key}) : super(key: key);
  final String name = 'Morar Melhor';
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Nome Completo',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.person),
                    )),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _cepController,
                      decoration: InputDecoration(
                          labelText: 'CEP',
                          hintText: 'CEP',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.numbers),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () async {
                          CepModel cepModel = CepModel();
                          NetworkHelper networkHelper = NetworkHelper(
                              'https://viacep.com.br/ws/${_cepController.text}/json/');

                          try {
                            cepModel = await networkHelper.getData();
                            _bairroController.text = cepModel.bairro;
                            _ruaController.text = cepModel.logradouro;
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Buscar')),
                  )
                ],
              ),
              TextField(
                controller: _ruaController,
                decoration: InputDecoration(
                    labelText: 'Rua',
                    hintText: 'Rua sem o número',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.add_road),
                    )),
              ),
              TextField(
                controller: _bairroController,
                decoration: InputDecoration(
                    labelText: 'Bairro',
                    hintText: 'Bairro',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.add_road),
                    )),
              ),
              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _numeroController,
                decoration: InputDecoration(
                    labelText: 'Número',
                    hintText: 'Número',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.add_road),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
