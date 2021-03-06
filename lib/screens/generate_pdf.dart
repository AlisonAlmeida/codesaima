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

    RegisterMorarMelhor _person = await _completePersonListBox.get(personIndex);

    final DateTime now = DateTime.now();

    final String dateFormattedForDocument =
        DateFormat.yMMMMEEEEd('pt').format(now);
    final pdf = Document();
    final imageGov =
        (await rootBundle.load(kPathLogoGovRoraimaPreta)).buffer.asUint8List();
    final imageMorarMelhor =
        (await rootBundle.load(kPathLogoMorarMelhor)).buffer.asUint8List();

    List<String> socialNetworks = [];
    if (_person.socialNetworks!.facebook!) {
      socialNetworks.add('FACEBOOK');
    }
    if (_person.socialNetworks!.instagram!) {
      socialNetworks.add('INSTAGRAM');
    }
    if (_person.socialNetworks!.whatsapp!) {
      socialNetworks.add('WHATSAPP');
    }
    if (_person.socialNetworks!.youtube!) {
      socialNetworks.add('YOUTUBE');
    }

    Widget _buildSocialNetworks() {
      List<Widget> list = [];
      for (var element in socialNetworks) {
        list.add(Text(element));
        list.add(SizedBox(width: 20));
      }

      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: list);
    }

    List<TableRow> _buildFamiliarResidentTableRow() {
      List<TableRow> list = [];
      for (var element in _person.residentFamiliar!) {
        list.add(
          TableRow(children: [
            Padding(
                padding: const EdgeInsets.all(5), child: Text(element.name)),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(element.birthDate),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(element.cpf),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(element.kinship),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(element.deficient!),
            )
          ]),
        );
      }
      return list;
    }

    pdf.addPage(MultiPage(
      footer: (context) {
        return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(children: [
            Text('___________________'),
            Text('Rubrica do Cadastrado'),
          ]),
        ]);
      },
      header: (context) {
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                child: Image(MemoryImage(imageGov)), width: 50, height: 50),
            SizedBox(
                width: 50,
                height: 50,
                child: Image(MemoryImage(imageMorarMelhor))),
          ]),
          Text('Ficha Cadastro - Programa Morar Melhor'),
          Text('Ficha n??'),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Grau de sigilo: #P??blico')]),
          Text('DECLARA????O:'),
        ]);
      },
      build: (context) {
        return [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                          Text(_person.originUF),
                          VerticalDivider(),
                          Text(_person.originCity)
                        ])
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome da M??e'),
                        Text(_person.mothersName)
                      ])
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome do Pai'),
                        Text(_person.fathersName)
                      ])
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipo de Documento'),
                        Text(_person.typeOfDocument)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('N?? / S??rie do documento'),
                        Text(_person.numberDocument)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('??rg??o emissor'),
                        Text(_person.issueDocument)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('UF'), Text(_person.ufDocument)]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data de expedi????o'),
                        Text(_person.dateIssueDocument)
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('N?? PIS/NIS/PASEP'),
                        Text(_person.pisNisPasep)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('CPF'), Text(_person.cpf)]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Profiss??o'), Text(_person.profession)]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Endere??o'),
                        Text(_person.address!.logradouro)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('N??mero'),
                        Text(_person.address!.numero)
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Complemento'),
                        Text(_person.address!.complemento)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bairro'),
                        Text(_person.address!.localidade)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Munic??pio'),
                        Text(_person.address!.localidade)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UF-CEP'),
                        Row(children: [
                          Text(_person.address!.uf),
                          VerticalDivider(),
                          Text(_person.address!.cep)
                        ])
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Telefones de contato'),
                        Row(children: [
                          Text(_person.phoneList!.first),
                          VerticalDivider(),
                          Text(_person.phoneList!.last),
                        ])
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Redes Sociais'),
                        _buildSocialNetworks()
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Estado Civil'),
                        Text(_person.maritalStatus)
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Grau de Instru????o'),
                        Text(_person.educationLevel)
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Renda Individual'),
                        Text(_person.individualCash)
                      ]),
                ]),
            SizedBox(height: 20),
            Text('Dados Pessoais do C??njuge'),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome completo do c??njuge'),
                        Text(_person.personSpouse!.name)
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Data de nascimento'),
                        Text(_person.personSpouse!.birthDate)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sexo'),
                        Text(_person.personSpouse!.sex)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nacionalidade'),
                        Text(_person.personSpouse!.nacionality)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Naturalidade'),
                        Row(children: [
                          Text(_person.personSpouse!.originUF),
                          VerticalDivider(),
                          Text(_person.personSpouse!.originCity)
                        ])
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome completo da m??e'),
                        Text(_person.personSpouse!.mothersName)
                      ]),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('N?? Carteira Identidade'),
                        Text(_person.personSpouse!.numberDocument)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sigla ??rgao Emissor'),
                        Text(_person.personSpouse!.issueDocument)
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UF - Data de Expedi????o'),
                        Row(children: [
                          Text(_person.personSpouse!.ufDocument),
                          VerticalDivider(),
                          Text(_person.personSpouse!.dateIssueDocument),
                        ])
                      ]),
                ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('N?? PIS/NIS/PASEP'),
                Text(_person.personSpouse!.pisNisPasep),
              ]),
              SizedBox(width: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('CPF'),
                Text(_person.personSpouse!.cpf),
              ]),
              SizedBox(width: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Profiss??o'),
                Text(_person.personSpouse!.profession),
              ]),
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Telefone de contato'),
                Text(_person.personSpouse!.phoneNumber),
              ]),
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Grau de Instru????o do C??njuge'),
                Text(_person.personSpouse!.educationLevel),
              ]),
            ]),
            SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Renda Individual do C??njuge'),
                Text(_person.personSpouse!.individualCash),
              ]),
            ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Renda Familiar'),
                        Text(_person.familiarCash),
                      ]),
                ]),
            SizedBox(width: 20),
            Text('Pessoa com Defici??ncia no Grupo Familiar'),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome'),
                        Text(_person.deficientPerson!.name),
                      ]),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CID'),
                        Text(_person.deficientPerson!.cid),
                      ]),
                ]),
            SizedBox(height: 20),
            Text('Informa????es Complementares'),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Dados dos Familiares Residentes no Domic??lio'),
                ]),
            Table(
                defaultColumnWidth: const FixedColumnWidth(120.0),
                border: TableBorder.all(),
                children: _buildFamiliarResidentTableRow()),
            SizedBox(height: 20),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Quanto Tempo Reside em Roraima'),
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      '${_person.timeLiveRoraimaYear} Anos e ${_person.timeLiveRoraimaMonth} Meses'),
                ]),
            SizedBox(height: 10),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Quanto Tempo Reside no Im??vel'),
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      '${_person.timeLiveHomeYear} Anos e ${_person.timeLiveHomeMonth} Meses'),
                ]),
            SizedBox(height: 20),
            Text('Observa????es'),
            Table(border: TableBorder.all(), children: [
              TableRow(children: [Text(_person.observations)])
            ]),
            SizedBox(height: 20),
            Text(
                'A propriet??ria do im??vel ?? m??e solteira com filhos menores de idade moradores no im??vel visitado?'),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text(_person.singleMother! ? 'SIM' : 'NAO')]),
            SizedBox(height: 20),
            Text('Informa????es do Im??vel'),
            Table(border: TableBorder.all(), children: [
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Tipo de Moradia')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.kindResidence)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Localiza????o')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                        _person.edificeInformation!.localizationResidence)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child:
                        Text('Situa????o da Moradia (USADO SOMENTE NA VISITA)')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child:
                        Text(_person.edificeInformation!.residenceSituation)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Qual Sistema de Abastecimento de ??gua?')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.supplyWaterSystem)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Tipo de Constru????o')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.kindConstruction)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Tipo do Piso da Resid??ncia')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.kindResidence)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Coleta de Lixo')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.garbageCollection)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Rede El??trica')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.electricalNetwork)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Tipo do Im??vel')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.kindResidence)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Sistema de Esgoto')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person.edificeInformation!.sewerage)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Possui Banheiro Interno?')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child:
                        Text(_person.edificeInformation!.hasInternalBathroom)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('Quantas Fam??lias Residem no Im??vel?')),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(_person
                        .edificeInformation!.numberFamiliesLiveResidence)),
              ]),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('N??mero de Familiares no Domic??lio')),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(_person
                      .edificeInformation!.numberResidentFamiliarLiveResidence),
                ),
              ]),
            ]),
            SizedBox(height: 20),
            Text('Quais Necessidades de Reforma Precisa'),
            Table(border: TableBorder.all(), children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(_person.edificeInformation!.reformNeed),
                )
              ])
            ]),
            SizedBox(height: 20),
            Text(
                'Declaro sob as penas da lei (Art. 299 do C??digo Penal), que as declara????es contidas neste formul??rio corresponderm ?? verdade e comprometo-me a procurar a gest??o estadual para atualiz??-las sempre que houver mudan??as em rela????o ??s informa????es prestadas por mim nesta entrevista.',
                textAlign: TextAlign.justify),
            SizedBox(height: 20),
            Text('__________________________________'),
            Text('Cidade / Estado'),
            SizedBox(height: 10),
            Text(dateFormattedForDocument),
            SizedBox(height: 20),
            Text(
                'O agente respons??vel pelo preenchimento do cadastro assinar?? a ficha e assumir?? responsabilidade pelas informa????es colhidas. Est?? ciente de que em caso de altera????o ou a omiss??o de alguma informa????o, para favorecimento e terceiros responder?? civil e criminalmente por essas a????es.',
                textAlign: TextAlign.justify),
            SizedBox(height: 20),
            Text('__________________________________'),
            Text('Assinatura do(a) Entrevistador(a)'),
            SizedBox(height: 20),
            Text('__________________________________'),
            Text('Assinatura do(a) Assistente Social(a)'),
          ]),
        ];
      },
    ));

    return saveDocument(name: '${_person.name}-${_person.cpf}', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    Directory directory = await getApplicationSupportDirectory();
    final bytes = await pdf.save();
    final file = File('${directory.path}/$name.pdf');
    await file.writeAsBytes(bytes);
    Share.shareFiles(['${directory.path}/$name.pdf'],
        mimeTypes: ['application/pdf']);
    return file;
  }
}
