import 'dart:io';
import 'package:codesaima/consts.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../models/register_person_morar_melhor_model.dart';

class GeneratePDFMorarMelhor {
  GeneratePDFMorarMelhor({
    required this.personIndex,
  });
  final int personIndex;

  Future<File> generateDocument() async {
    Box _completePersonListBox =
        Hive.box<RegisterMorarMelhor>(kCompletePersonBox);

    RegisterMorarMelhor _person = _completePersonListBox.get(personIndex);

    final DateTime now = DateTime.now();
    final String dateFormatted = DateFormat('yyyy-MM-dd').format(now);
    final pdf = Document();
    final imageGov =
        (await rootBundle.load(kPathLogoGovRoraimaPreta)).buffer.asUint8List();
    final imageMorarMelhor =
        (await rootBundle.load(kPathLogoMorarMelhor)).buffer.asUint8List();

    pdf.addPage(MultiPage(
      build: (context) {
        return [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                  child: Image(MemoryImage(imageGov)), width: 50, height: 50),
              SizedBox(
                  width: 50,
                  height: 50,
                  child: Image(MemoryImage(imageMorarMelhor))),
            ]),
            Text('Ficha Cadastro - Programa Morar Melhor'),
            Text('Ficha nº'),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text('Grau de sigilo: #Público')]),
            Text('DECLARAÇÃO:'),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Nome completo')]),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text(_person.name)]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data de nascimento'),
                        Text(_person.birthDate)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Sexo'), Text(_person.sex)]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nacionalidade'),
                        Text(_person.nacionality)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Naturalidade'),
                        Row(children: [
                          Text(_person
                              .originUF), //TODO esses dados nao estao indo
                          VerticalDivider(),
                          Text(_person.originCity)
                        ])
                      ]),
                ]),
          ]),
        ];
      },
    ));

    return saveDocument(name: '${_person.name}-$dateFormatted', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(bytes);
    Share.shareFiles(['${dir.path}/$name.pdf'], mimeTypes: ['application/pdf']);
    return file;
  }
}
