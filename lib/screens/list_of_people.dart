// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/models/person_model.dart';
import 'package:codesaima/screens/crud_person_screen.dart';
import 'package:codesaima/screens/search_screens/qualitative_research_morar_melhor_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListOfPeople extends StatefulWidget {
  const ListOfPeople({Key? key, required this.fromResearch}) : super(key: key);
  final bool fromResearch;

  @override
  State<ListOfPeople> createState() => _ListOfPeopleState();
}

class _ListOfPeopleState extends State<ListOfPeople> {
  late final Box _personListBox;
  late int personIndex;

  @override
  void initState() {
    _personListBox = Hive.box<Person>('personList');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffold = GlobalKey();
    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          title: Text('Moradores'),
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
                  valueListenable: _personListBox.listenable(),
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
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 70),
                primary: Colors.green[700]),
            icon: Icon(
              Icons.person_add,
              size: 30,
            ),
            label: Text('Cadastrar Morador'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                Person person = Person();
                return CrudPersonScreen(
                  fromResearch: false,
                  hasPersonData: false,
                  person: person,
                );
              }),
            ),
          ),
        ])));
  }

  List<Widget> buildListOfPeople() {
    List<Widget> _list = [];
    _personListBox.toMap().forEach((key, person) {
      person as Person;
      _list.add(
        GestureDetector(
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(person.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [Icon(Icons.phone), Text(person.phone)]),
                    Row(children: [
                      Icon(Icons.room),
                      Flexible(child: Text(person.address!.logradouro))
                    ])
                  ],
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => CrudPersonScreen(
                                        fromResearch: false,
                                        person: person,
                                        hasPersonData: true,
                                        personIndex: key,
                                      ))),
                            ),
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          showAlertDialog(context, person, key);
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        QualitativeResearchMorarMelhorScreen())),
              );
            }),
      );
    });

    return _list;
  }

  showAlertDialog(context, Person person, int index) {
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
        await _personListBox.delete(index);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(person.name),
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
        await _personListBox.clear();
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
