// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/consts.dart';
import 'package:flutter/material.dart';

class MorarMelhorSearchScreen extends StatelessWidget {
  MorarMelhorSearchScreen({Key? key}) : super(key: key);
  final String name = 'Morar Melhor';
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.orange,
      ),
      body: Form(
        key: _form,
        child: TextField(controller: _valor),
      ),
    );
  }
}
