// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/consts.dart';
import 'package:codesaima/models/person_model.dart';
import 'package:codesaima/screens/crud_person_screen.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class QualitativeResearchMorarMelhorScreen extends StatefulWidget {
  QualitativeResearchMorarMelhorScreen({Key? key, required this.personIndex})
      : super(key: key);
  int personIndex;

  @override
  State<QualitativeResearchMorarMelhorScreen> createState() =>
      _QualitativeResearchScreenState();
}

final _personListBox = Hive.box<Person>('personList');
Person? _person = Person();

int _groupPlaceRegister = 0;
int _groupSocialProfile = 0;
int _groupNumberVisits = 0;
int _groupValue4 = 0;
int _groupValue5 = 0;
double _currentSliderValue = 0;
double _currentSliderValue2 = 0;

int _numberOfVisits = 0;
TextEditingController _ownerHouse = TextEditingController();
TextEditingController _howMuchTimeLiveHome = TextEditingController();
TextEditingController _numberPeopleLiveHome = TextEditingController();
TextEditingController _numberOfFamilies = TextEditingController();
/*
TextEditingController = TextEditingController();
TextEditingController = TextEditingController();
TextEditingController = TextEditingController();
TextEditingController = TextEditingController();
TextEditingController = TextEditingController();
TextEditingController = TextEditingController();
TextEditingController = TextEditingController();
TextEditingController = TextEditingController();
*/

bool _checkBoxOwnerHouse = false;

class _QualitativeResearchScreenState
    extends State<QualitativeResearchMorarMelhorScreen> {
  @override
  void initState() {
    if (widget.personIndex >= 0) {
      _person = _personListBox.get(widget.personIndex);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisa Qualitativa'),
        backgroundColor: kMorarMelhorThemeData.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kPathLogoMorarMelhor,
                    height: MediaQuery.of(context).size.width / 3,
                  )
                ],
              ),
              Divider(height: 7),
              _person! != null
                  ? Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Text(
                            _person!.name,
                            style: TextStyle(
                                fontSize: 25, color: Colors.orange[700]),
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => CrudPersonScreen(
                                            fromResearch: true,
                                            personIndex: widget.personIndex,
                                            hasPersonData: true))));
                              },
                              icon: Icon(Icons.edit)),
                        )
                      ],
                    )
                  : Text(''),
              Divider(),
              Text(
                'Quem é o proprietário do imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text('O proprietário é o mesmo da pesquisa?'),
                  ),
                  Checkbox(
                      value: _checkBoxOwnerHouse,
                      onChanged: (newValue) => setState(() {
                            _checkBoxOwnerHouse = newValue!;
                            _checkBoxOwnerHouse
                                ? _ownerHouse.text = _person!.name
                                : _ownerHouse.text = '';
                          })),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                    enabled: !_checkBoxOwnerHouse,
                    controller: _ownerHouse,
                    decoration: kTextFieldDecorationMorarMelhor.copyWith(
                        hintText: 'Quem é o proprietário do imóvel?',
                        labelText: 'Quem é o proprietário do imóvel?')),
              ),
              Divider(),
              Text(
                'Quanto tempo reside no imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              ReusabledIntWidget(
                  controller: _howMuchTimeLiveHome, text: 'Anos'),
              Divider(),
              Text(
                'Quantas famílias residem no imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              ReusabledIntWidget(
                  controller: _numberPeopleLiveHome, text: 'Pessoas'),
              Divider(),
              Text(
                'Quantas famílias vivem no imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              ReusabledIntWidget(
                  controller: _numberOfFamilies, text: 'Famílias'),
              Divider(),
              Text(
                'Local onde foi realizado o cadastro do Morar Melhor?',
                style: TextStyle(fontSize: 25),
              ),
              ReusabledRadioListItem(
                  text: 'Codesaima',
                  value: 1,
                  groupValue: _groupPlaceRegister,
                  function: (newValue) => setState(() {
                        _groupPlaceRegister = newValue!;
                      })),
              ReusabledRadioListItem(
                  text: 'No evento Governo Sem Parar',
                  value: 2,
                  groupValue: _groupPlaceRegister,
                  function: (newValue) => setState(() {
                        _groupPlaceRegister = newValue!;
                      })),
              ReusabledRadioListItem(
                  text: 'Outros',
                  value: 3,
                  groupValue: _groupPlaceRegister,
                  function: (newValue) => setState(() {
                        _groupPlaceRegister = newValue!;
                      })),
              Visibility(
                visible: _groupPlaceRegister == 3 ? true : false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    decoration: kTextFieldDecorationMorarMelhor.copyWith(
                        hintText: 'Outros'),
                  ),
                ),
              ),
              Divider(),
              Text(
                'Perfil social para o benefício? (obrigatório)',
                style: TextStyle(fontSize: 25),
              ),
              ReusabledRadioListItem(
                  value: 1,
                  groupValue: _groupSocialProfile,
                  function: (newValue) => setState(() {
                        _groupSocialProfile = newValue!;
                      }),
                  text: 'PCD'),
              ReusabledRadioListItem(
                  value: 2,
                  groupValue: _groupSocialProfile,
                  function: (newValue) => setState(() {
                        _groupSocialProfile = newValue!;
                      }),
                  text: 'Idoso'),
              ReusabledRadioListItem(
                  value: 3,
                  groupValue: _groupSocialProfile,
                  function: (newValue) => setState(() {
                        _groupSocialProfile = newValue!;
                      }),
                  text: 'Mãe chefe de família'),
              ReusabledRadioListItem(
                  value: 4,
                  groupValue: _groupSocialProfile,
                  function: (newValue) => setState(() {
                        _groupSocialProfile = newValue!;
                      }),
                  text: 'Outros'),
              Visibility(
                visible: _groupSocialProfile == 4 ? true : false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    decoration: kTextFieldDecorationMorarMelhor.copyWith(
                        hintText: 'Outros'),
                  ),
                ),
              ),
              Divider(),
              Text(
                'Data da assinatura da ordem de serviço:',
                style: TextStyle(fontSize: 25),
              ),
              Divider(),
              Text(
                'Já recebeu a visita técnica dos engenheiros?',
                style: TextStyle(fontSize: 25),
              ),
              RadioListTile<int>(
                  title: Text('Não'),
                  activeColor: Colors.orange,
                  value: 2,
                  groupValue: _groupNumberVisits,
                  onChanged: (value) => setState(() {
                        _groupNumberVisits = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Sim'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupNumberVisits,
                  onChanged: (value) => setState(() {
                        _groupNumberVisits = value!;
                      })),
              Visibility(
                visible: _groupNumberVisits == 1 ? true : false,
                child: NumberPicker(
                  value: _numberOfVisits,
                  minValue: 0,
                  maxValue: 10,
                  step: 1,
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() => _numberOfVisits = value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
              ),
              Divider(),
              Text(
                'Que tipo de melhoria foi contemplada?',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      labelText: 'Ex.: Reforma do banheiro'),
                ),
              ),
              Divider(),
              Text(
                'Qual o grau de satisfação com os serviços que estão sendo realizados?',
                style: TextStyle(fontSize: 25),
              ),
              RadioListTile<int>(
                  title: Text('Ótimo'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupValue4,
                  onChanged: (value) => setState(() {
                        _groupValue4 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Bom'),
                  activeColor: Colors.orange,
                  value: 2,
                  groupValue: _groupValue4,
                  onChanged: (value) => setState(() {
                        _groupValue4 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Regular'),
                  activeColor: Colors.orange,
                  value: 3,
                  groupValue: _groupValue4,
                  onChanged: (value) => setState(() {
                        _groupValue4 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Péssimo'),
                  activeColor: Colors.orange,
                  value: 4,
                  groupValue: _groupValue4,
                  onChanged: (value) => setState(() {
                        _groupValue4 = value!;
                      })),
              Divider(),
              Text(
                'Você conhece os responsáveis pela empresa que está realizando os serviços?',
                style: TextStyle(fontSize: 25),
              ),
              RadioListTile<int>(
                  title: Text('Não'),
                  activeColor: Colors.orange,
                  value: 2,
                  groupValue: _groupValue5,
                  onChanged: (value) => setState(() {
                        _groupValue5 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Sim'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupValue5,
                  onChanged: (value) => setState(() {
                        _groupValue5 = value!;
                      })),
              Divider(),
              Text(
                'Qual nota você avalia o Morar Melhor? (0 a 10)',
                style: TextStyle(fontSize: 25),
              ),
              Slider(
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: Colors.orange,
                value: _currentSliderValue,
                label: _currentSliderValue.round().toString(),
                onChanged: (newValue) => setState(() {
                  _currentSliderValue = newValue;
                }),
              ),
              Divider(),
              Text(
                'Qual nota de 0 a 10 você daria para a atual gestão do Governo de Roraima que está sob o comando do Governador Antonio Denarium?',
                style: TextStyle(fontSize: 25),
              ),
              Slider(
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: Colors.orange,
                value: _currentSliderValue2,
                label: _currentSliderValue2.round().toString(),
                onChanged: (newValue) => setState(() {
                  _currentSliderValue2 = newValue;
                }),
              ),
              Divider(),
              Text(
                'Sugestões, críticas ou observações sobre os serviços executados no seu imóvel:',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      hintText: 'Sugestões, críticas ou observações'),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {},
                        icon: Icon(Icons.save),
                        label: Text('Salvar')),
                  )
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusabledIntWidget extends StatelessWidget {
  const ReusabledIntWidget(
      {Key? key, required this.controller, required this.text})
      : super(key: key);

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ListTile(
        trailing: Text(text),
        title: TextField(
            controller: _howMuchTimeLiveHome,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputMask(mask: '999')
            ],
            decoration: kTextFieldDecorationMorarMelhor),
      ),
    );
  }
}

class ReusabledRadioListItem extends StatelessWidget {
  const ReusabledRadioListItem(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.function,
      required this.text})
      : super(key: key);
  final int value;
  final int groupValue;
  final Function(int?) function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
        activeColor: Colors.orange,
        title: Text(text),
        value: value,
        groupValue: groupValue,
        onChanged: function);
  }
}
