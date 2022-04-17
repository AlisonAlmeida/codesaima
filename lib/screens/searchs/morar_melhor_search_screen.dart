// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:flutter/material.dart';

class MorarMelhorSearchScreen extends StatelessWidget {
  MorarMelhorSearchScreen({Key? key}) : super(key: key);
  final String name = 'Morar Melhor';
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();

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
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'CEP',
                    hintText: 'CEP',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.numbers),
                    )),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Rua',
                    hintText: 'Rua sem o número',
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
