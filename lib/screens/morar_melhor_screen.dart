// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:codesaima/consts.dart';
import 'package:codesaima/screens/information_morar_melhor_screen.dart';
import 'package:codesaima/screens/list_morar_melhor_register.dart';
import 'package:codesaima/screens/list_of_simple_people.dart';
import 'package:flutter/material.dart';

class MorarMelhorScreen extends StatefulWidget {
  const MorarMelhorScreen({Key? key}) : super(key: key);

  @override
  State<MorarMelhorScreen> createState() => _MorarMelhorScreenState();
}

class _MorarMelhorScreenState extends State<MorarMelhorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Morar Melhor'),
          backgroundColor: kMorarMelhorThemeData.backgroundColor,
        ),
        body: ListView(children: [
          CustomListTileMorarMelhor(
              icon: Icons.add,
              title: 'Cadastro',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListOfCompletePeople(
                            fromResearch: true,
                          )))),

          /*
          CustomListTileMorarMelhor(
              icon: Icons.search,
              title: 'Pequisa Qualitativa',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListOfPeople(
                            fromResearch: true,
                          )))),

                          */
          CustomListTileMorarMelhor(
              icon: Icons.info, title: 'Informações', onTap: () {}),
        ]));
  }
}

class CustomListTileMorarMelhor extends StatelessWidget {
  const CustomListTileMorarMelhor(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          child: ListTile(
        leading: CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
          child: Icon(icon),
        ),
        title: Text(title),
      )),
    );
  }
}
