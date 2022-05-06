// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/consts.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class QualitativeResearchScreen extends StatefulWidget {
  const QualitativeResearchScreen({Key? key}) : super(key: key);

  @override
  State<QualitativeResearchScreen> createState() =>
      _QualitativeResearchScreenState();
}

int _groupValue1 = 0;
int _groupValue2 = 0;
int _groupValue3 = 0;
int _groupValue4 = 0;
int _groupValue5 = 0;
double _currentSliderValue = 0;
double _currentSliderValue2 = 0;
bool _visibilityPlaceRegister = false;
bool _visibilitySocialProfile = false;
bool _visibilityNumberVisits = false;
int _numberOfVisits = 0;
bool? checkBoxTimeLiveInHome = false;

class _QualitativeResearchScreenState extends State<QualitativeResearchScreen> {
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
              Text(
                'Quem é o proprietário do imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      labelText: 'Proprietário do Imóvel',
                      hintText: 'Proprietário do Imóvel'),
                ),
              ),
              Divider(),
              Text(
                'Quanto tempo reside no imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(decoration: kTextFieldDecorationMorarMelhor),
              ),
              Divider(),
              Text(
                'Quantas famílias residem no imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(decoration: kTextFieldDecorationMorarMelhor),
              ),
              Divider(),
              Text(
                'Quantas famílias vivem no imóvel?',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(decoration: kTextFieldDecorationMorarMelhor),
              ),
              Divider(),
              Text(
                'Local onde foi realializado o cadastro do Morar Melhor?',
                style: TextStyle(fontSize: 25),
              ),
              RadioListTile<int>(
                  title: Text('Na Codesaima'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupValue1,
                  onChanged: (value) => setState(() {
                        _visibilityPlaceRegister = false;
                        _groupValue1 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Na evento Governo Sem Parar'),
                  activeColor: Colors.orange,
                  value: 2,
                  groupValue: _groupValue1,
                  onChanged: (value) => setState(() {
                        _visibilityPlaceRegister = false;
                        _groupValue1 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Outros'),
                  activeColor: Colors.orange,
                  value: 3,
                  groupValue: _groupValue1,
                  onChanged: (value) => setState(() {
                        _visibilityPlaceRegister = true;
                        _groupValue1 = value!;
                      })),
              Visibility(
                visible: _visibilityPlaceRegister,
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
              RadioListTile<int>(
                  title: Text('PCD'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupValue2,
                  onChanged: (value) => setState(() {
                        _visibilitySocialProfile = false;
                        _groupValue2 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Idoso'),
                  activeColor: Colors.orange,
                  value: 2,
                  groupValue: _groupValue2,
                  onChanged: (value) => setState(() {
                        _visibilitySocialProfile = false;
                        _groupValue2 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Mãe chefe de família'),
                  activeColor: Colors.orange,
                  value: 3,
                  groupValue: _groupValue2,
                  onChanged: (value) => setState(() {
                        _visibilitySocialProfile = false;
                        _groupValue2 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Outros'),
                  activeColor: Colors.orange,
                  value: 4,
                  groupValue: _groupValue2,
                  onChanged: (value) => setState(() {
                        _visibilitySocialProfile = true;
                        _groupValue2 = value!;
                      })),
              Visibility(
                visible: _visibilitySocialProfile,
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
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            cancelText: 'Cancelar',
                            confirmText: 'Confirmar',
                            initialDatePickerMode: DatePickerMode.year,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime.now());
                      },
                      icon: Icon(Icons.calendar_month),
                      label: Text('Selecione'),
                    ),
                  ),
                ],
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
                  groupValue: _groupValue3,
                  onChanged: (value) => setState(() {
                        _visibilityNumberVisits = false;
                        _groupValue3 = value!;
                      })),
              RadioListTile<int>(
                  title: Text('Sim'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupValue3,
                  onChanged: (value) => setState(() {
                        _visibilityNumberVisits = true;
                        _groupValue3 = value!;
                      })),
              Visibility(
                visible: _visibilityNumberVisits,
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
