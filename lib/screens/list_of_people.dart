// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/core/person_model.dart';
import 'package:codesaima/screens/crup_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListOfPeople extends StatefulWidget {
  const ListOfPeople({Key? key}) : super(key: key);

  @override
  State<ListOfPeople> createState() => _ListOfPeopleState();
}

class _ListOfPeopleState extends State<ListOfPeople> {
  late final Box personListBox;

  @override
  void initState() {
    personListBox = Hive.box<Person>('personList');
    super.initState();
  }

  addPerson(Person person) {
    personListBox.add(person);
  }

  removePerson(int index) {
    personListBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pessoas'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
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
                valueListenable: personListBox.listenable(),
                builder: (context, Box box, widget) {
                  if (box.isEmpty) {
                    return Center(
                      child: Text('Vazio'),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          var currentBox = box;
                          var personData = currentBox.getAt(index)!;
                          final person = personData as Person;
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CrudPersonScreen(
                                                  person: person,
                                                  hasPersonData: true,
                                                  personIndex: personListBox
                                                      .keys
                                                      .toList()[index])));
                                },
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(person.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          Icon(Icons.phone),
                                          Text(person.phone)
                                        ]),
                                        Row(children: [
                                          Icon(Icons.room),
                                          Flexible(
                                              child: Text(
                                                  person.address!.logradouro))
                                        ])
                                      ],
                                    ),
                                    trailing: IconButton(
                                        //delete button
                                        onPressed: () => showAlertDialog(
                                            context, person, index),
                                        icon: Icon(Icons.delete)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  }
                }),
          ),
          Row(children: [
            Expanded(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: Colors.green[700]),
                    icon: Icon(
                      Icons.person_add,
                      size: 30,
                    ),
                    label: Text('Cadastrar Pessoa'),
                    onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          Person person = Person();
                          return CrudPersonScreen(
                            hasPersonData: false,
                            person: person,
                          );
                        })) //                  await Hive.box<Person>('personlist').clear();
                    ))
          ])
        ])));
  }

  showAlertDialog(BuildContext context, Person person, int index) {
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
        await personListBox.deleteAt(index);
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
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDeleteAllData(BuildContext context) {
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
        await personListBox.clear();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
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
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
