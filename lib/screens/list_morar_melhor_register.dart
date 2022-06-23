// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:codesaima/consts.dart';
import 'package:codesaima/models/register_person_morar_melhor_model.dart';
import 'package:codesaima/screens/generate_pdf.dart';
import 'package:codesaima/screens/register_morar_melhor_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

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
          title: Text('Cadastro'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        endDrawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => exportAllRegistersExcel(),
                  child: Text('Exportar todos os cadastros para excel')),
              ElevatedButton(
                  onPressed: () => showAlertDeleteAllData(context),
                  child: Text('Deletar todos os cadastros')),
            ],
          ),
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
                fixedSize: Size(MediaQuery.of(context).size.width - 10, 70),
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
            subtitle: Text(_person.cpf),
            trailing: PopupMenuButton(
                onSelected: (value) async {
                  if (value == 1) {
                    //edit person
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => RegisterMorarMelhorScreen(
                                hasPersonData: true,
                                personIndex: key,
                              ))),
                    );
                  }
                  if (value == 2) {
                    //delete person
                    await _showDeleteAlertDialog(context, _person, key);
                  }

                  if (value == 3) {
                    _createPdf(key, _person);
                  }
                },
                shape: OutlineInputBorder(),
                color: Colors.orange[100],
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text('Editar'),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text('Deletar'),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Text('Imprimir'),
                      ),
                    ]),
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

  _createPdf(int personIndex, RegisterMorarMelhor person) async {
    showGeneralProgressIndicator(context, 'Gerando PDF');
    await Future.delayed(Duration(seconds: 1));
    GeneratePDFMorarMelhor(personIndex: personIndex).generateDocument();
    Navigator.pop(context);
  }

  _showDeleteAlertDialog(
      context, RegisterMorarMelhor registerMorarMelhor, int index) {
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
      title: Text(registerMorarMelhor.name),
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

  exportAllRegistersExcel() async {
    final DateTime now = DateTime.now();
    final String dateFormattedForFile = DateFormat('yyyy-MM-dd').format(now);
    var excel = Excel.createExcel();
    var sheet = excel[excel.getDefaultSheet()!];

    for (var i = 0; i < _completePersonListBox.values.length; i++) {
      int columnIndex = 1;
      RegisterMorarMelhor _person = _completePersonListBox.get(i);
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.name;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.birthDate;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.sex;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.nacionality;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.originUF;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.originCity;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.mothersName;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.fathersName;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.typeOfDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.numberDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.issueDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.ufDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.dateIssueDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.pisNisPasep;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.cpf;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.profession;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.address!.logradouro;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.address!.numero;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.address!.complemento;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.address!.bairro;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.address!.uf;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.address!.localidade;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.address!.cep;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.phoneList![0];
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.phoneList![1];
      columnIndex += 2;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.maritalStatus;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.educationLevel;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.individualCash;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.name;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.birthDate;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.sex;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.nacionality;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.originUF;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.originCity;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.mothersName;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.numberDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.issueDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.ufDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.dateIssueDocument;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.pisNisPasep;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.cpf;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.profession;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.phoneNumber;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.educationLevel;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.personSpouse!.individualCash;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.familiarCash;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.deficientPerson!.name;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.deficientPerson!.cid;

      for (var element in _person.residentFamiliar!) {
        columnIndex++;
        sheet
            .cell(CellIndex.indexByColumnRow(
                rowIndex: i, columnIndex: columnIndex))
            .value = element.name;
        columnIndex++;
        sheet
            .cell(CellIndex.indexByColumnRow(
                rowIndex: i, columnIndex: columnIndex))
            .value = element.birthDate;
        columnIndex++;
        sheet
            .cell(CellIndex.indexByColumnRow(
                rowIndex: i, columnIndex: columnIndex))
            .value = element.cpf;
        columnIndex++;
        sheet
            .cell(CellIndex.indexByColumnRow(
                rowIndex: i, columnIndex: columnIndex))
            .value = element.kinship;
      }
      while (columnIndex <= 97) {
        columnIndex++;
      }
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person
              .timeLiveRoraimaYear +
          ' Anos' +
          _person.timeLiveRoraimaMonth +
          ' Meses';
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person
              .timeLiveHomeYear +
          ' Anos' +
          _person.timeLiveHomeMonth +
          ' Meses';
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.singleMother! ? 'SIM' : 'NÃO';
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.kindResidence;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.localizationResidence;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.numberRoomResidence;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.residenceSituation;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.supplyWaterSystem;
      columnIndex++;
      sheet
              .cell(CellIndex.indexByColumnRow(
                  rowIndex: i, columnIndex: columnIndex))
              .value =
          _person.edificeInformation!.numberResidentFamiliarLiveResidence;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.kindConstruction;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.garbageCollection;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.electricalNetwork;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.numberFamiliesLiveResidence;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.kindFloor;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.sewerage;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.hasInternalBathroom;
      columnIndex++;
      sheet
          .cell(
              CellIndex.indexByColumnRow(rowIndex: i, columnIndex: columnIndex))
          .value = _person.edificeInformation!.reformNeed;
    }

    final bytes =
        excel.save(fileName: 'CadastrosCompilados-$dateFormattedForFile.xlsx');
    final dir = await getApplicationSupportDirectory();
    final file =
        File('${dir.path}/CadastrosCompilados-$dateFormattedForFile.xlsx');
    await file.writeAsBytes(bytes!);

    Share.shareFiles(
        ['${dir.path}/CadastrosCompilados-$dateFormattedForFile.xlsx'],
        mimeTypes: ['application/xlsx']);
    Navigator.pop(context);
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
