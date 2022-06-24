// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class InformationMorarMelhor extends StatelessWidget {
  const InformationMorarMelhor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: ListView(
        children: [
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '''Documentos necessários'''.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  '''X - Carteira de Identidade.''',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
