// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:flutter/material.dart';

class MorarMelhorSearchScreen extends StatelessWidget {
  MorarMelhorSearchScreen({Key? key}) : super(key: key);
  final String name = 'Morar Melhor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
