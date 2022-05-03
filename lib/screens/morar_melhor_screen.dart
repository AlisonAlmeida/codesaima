// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/screens/search_screens/qualitative_research_screen.dart';
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
              icon: Icons.last_page, title: 'Inscrições', onTap: () {}),
          CustomListTileMorarMelhor(
              icon: Icons.search,
              title: 'Pesquisas',
              onTap: () {
                _showModalBottomSheetSearchs(context);
              }),
          CustomListTileMorarMelhor(
              icon: Icons.info, title: 'Informações', onTap: () {}),
        ]));
  }

  void _showModalBottomSheetSearchs(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.orange[50],
        builder: (BuildContext context) {
          return Container(
            color: Colors.orange[50],
            child: Column(
              children: [
                Flexible(
                    child: Text(
                  'Pesquisas',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
                Expanded(
                    child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QualitativeResearchScreen(),
                            ));
                      },
                      child: Card(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text('Pequisa Qualitativa'),
                            trailing: Icon(Icons.forward),
                          )),
                    )
                  ],
                )),
              ],
            ),
          );
        });
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
