// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/consts.dart';
import 'package:flutter/material.dart';

class QualitativeResearchScreen extends StatefulWidget {
  const QualitativeResearchScreen({Key? key}) : super(key: key);

  @override
  State<QualitativeResearchScreen> createState() =>
      _QualitativeResearchScreenState();
}

class _QualitativeResearchScreenState extends State<QualitativeResearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisa Qualitativa'),
        backgroundColor: kMorarMelhorThemeData.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 7),
              TextFormField(
                decoration: kTextFieldDecorationMorarMelhor.copyWith(
                    labelText: 'Proprietário do Imóvel',
                    hintText: 'Proprietário do Imóvel'),
              )
            ],
          ),
        )),
      ),
    );
  }
}
