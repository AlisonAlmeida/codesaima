// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/consts.dart';
import 'package:codesaima/models/register_person_morar_melhor_model.dart';
import 'package:codesaima/screens/register_morar_melhor_screen.dart';
import 'package:codesaima/screens/search_screens/qualitative_research_morar_melhor_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListOfCompletePeople extends StatefulWidget {
  const ListOfCompletePeople({Key? key, required this.fromResearch})
      : super(key: key);
  final bool fromResearch;

  @override
  State<ListOfCompletePeople> createState() => _ListOfPeopleState();
}

class _ListOfPeopleState extends State<ListOfCompletePeople> {
  late final Box _completePersonListBox;
  List<Widget> _listOfPeople = [];

  @override
  void initState() {
    _completePersonListBox = Hive.box<RegisterMorarMelhor>(kCompletePersonBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kMorarMelhorThemeData.backgroundColor,
          title: Text('Cadastro Morar Melhor'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        endDrawer: Drawer(
          child: Center(
              child: ElevatedButton(
                  onPressed: () => showAlertDeleteAllData(context),
                  child: Text('Deletar todos os cadastros'))),
        ),
        body: Center(
            child: Column(children: [
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: _completePersonListBox.listenable(),
                  builder: (context, Box box, widget) {
                    if (box.isEmpty) {
                      return Center(
                        child: Text(
                          'Vazio',
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    } else {
                      return ListView(
                        children: buildListOfPeople(),
                      );
                    }
                  })),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 70),
                primary: kMorarMelhorThemeData.backgroundColor),
            child: Icon(
              Icons.person_add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return RegisterMorarMelhorScreen(
                  hasPersonData: false,
                );
              }),
            ),
          ),
        ])));
  }

  List<Widget> buildListOfPeople() {
    List<Widget> _list = [];
    _completePersonListBox.toMap().forEach((key, _person) {
      _person as RegisterMorarMelhor;
      _list.add(
        Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(_person.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.phone), Text(_person.phone)]),
                Row(children: [
                  Icon(Icons.room),
                  Flexible(child: Text(_person.address!.logradouro))
                ])
              ],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => RegisterMorarMelhorScreen(
                                    hasPersonData: true,
                                    personIndex: key,
                                  ))),
                        ),
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      showAlertDialog(context, _person, key);
                    },
                    icon: Icon(Icons.delete)),
                if (widget.fromResearch)
                  IconButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    QualitativeResearchMorarMelhorScreen(
                                      personIndex: key,
                                    ))),
                          ),
                      icon: CircleAvatar(
                          backgroundColor:
                              kMorarMelhorThemeData.backgroundColor,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.print)))
              ],
            ),
          ),
        ),
      );
    });
    _listOfPeople = [];
    for (var element in _list.reversed) {
      _listOfPeople.add(element);
    }

    return _listOfPeople;
  }

  showAlertDialog(context, RegisterMorarMelhor RegisterMorarMelhor, int index) {
    // set up the buttons

    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirmar"),
      onPressed: () async {
        await _completePersonListBox.delete(index);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(RegisterMorarMelhor.name),
      content: Text("Confirma a exclusão do cadastro?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return alert;
      },
    );
  }

  showAlertDeleteAllData(BuildContext dialogContext) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(dialogContext).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirmar"),
      onPressed: () async {
        await _completePersonListBox.clear();
        Navigator.of(dialogContext).pop();
        Navigator.of(dialogContext).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
          'Isso vai deletar todos os cadastros do seu dispositivo com as pesquisas realizadas!'),
      content: Text('Confirma a exclusão?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return alert;
      },
    );
  }
}