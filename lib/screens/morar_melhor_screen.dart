// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
          backgroundColor: Colors.orange,
        ),
        body: ListView(children: [
          CustomListTileMorarMelhor(
              icon: Icons.search,
              title: 'Pesquisas',
              onTap: () {
                _configurandoModalBottomSheet(context);
              }),
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

void _configurandoModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.query_stats_sharp),
                title: Text('Pesquisa Qualitativa'),
                onTap: () => {}),
          ],
        );
      });
}
