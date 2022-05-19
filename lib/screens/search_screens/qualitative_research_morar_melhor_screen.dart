// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:codesaima/consts.dart';
import 'package:codesaima/models/person_model.dart';
import 'package:codesaima/screens/crud_person_screen.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

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
double _classificationMorarMelhor = 0;
double _classificationGovenment = 0;
String _knowEnterpriseOfService = '';

int _numberOfVisits = 0;
bool _checkBoxOwnerHouse = false;
String _degreeOfSatisfactionServices = '';

TextEditingController _ownerHouse = TextEditingController();
TextEditingController _howMuchTimeLiveHome = TextEditingController();
TextEditingController _numberPeopleLiveHome = TextEditingController();
TextEditingController _numberOfFamilies = TextEditingController();
TextEditingController _placeRegisterDone = TextEditingController();
TextEditingController _socialProfileBenefit = TextEditingController();
TextEditingController _kindOfImprovement = TextEditingController();
TextEditingController _otherInformationsImprovement = TextEditingController();
//int _steppsIndex = 0;
DateTime now = DateTime.now();

String dateSignatureContratcMorarMelhor =
    DateFormat('yyyy-MM-dd – kk:mm').format(now);

class _QualitativeResearchScreenState
    extends State<QualitativeResearchMorarMelhorScreen> {
  @override
  void initState() {
    if (widget.personIndex >= 0) {
      _person = _personListBox.get(widget.personIndex);
      _ownerHouse.text = '';
      _checkBoxOwnerHouse = false;
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
              /*SizedBox.fromSize(
                size: MediaQuery.of(context).size,
                child: Stepper(
                  currentStep: _steppsIndex,
                  type: StepperType.horizontal,
                  steps: [
                    Step(title: Text('title'), content: Text('asd')),
                    Step(title: Text('title'), content: Text('asd'))
                  ],
                  onStepCancel: () {
                    if (_steppsIndex > 0) {
                      setState(() {
                        _steppsIndex -= 1;
                      });
                    }
                  },
                  onStepContinue: () {
                    if (_steppsIndex <= 0) {
                      setState(() {
                        _steppsIndex += 1;
                      });
                    }
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _steppsIndex = index;
                    });
                  },
                ),
              ),*/
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
                        _placeRegisterDone.text = 'Codesaima';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              ReusabledRadioListItem(
                  text: 'No evento Governo Sem Parar',
                  value: 2,
                  groupValue: _groupPlaceRegister,
                  function: (newValue) => setState(() {
                        _groupPlaceRegister = newValue!;
                        _placeRegisterDone.text = 'No evento Governo Sem Parar';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              ReusabledRadioListItem(
                  text: 'Outros',
                  value: 3,
                  groupValue: _groupPlaceRegister,
                  function: (newValue) => setState(() {
                        _groupPlaceRegister = newValue!;
                        _placeRegisterDone.text = '';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              Visibility(
                visible: _groupPlaceRegister == 3 ? true : false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _placeRegisterDone,
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
                        _socialProfileBenefit.text = 'PCD';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      }),
                  text: 'PCD'),
              ReusabledRadioListItem(
                  value: 2,
                  groupValue: _groupSocialProfile,
                  function: (newValue) => setState(() {
                        _groupSocialProfile = newValue!;
                        _socialProfileBenefit.text = 'Idoso';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      }),
                  text: 'Idoso'),
              ReusabledRadioListItem(
                  value: 3,
                  groupValue: _groupSocialProfile,
                  function: (newValue) => setState(() {
                        _groupSocialProfile = newValue!;
                        _socialProfileBenefit.text = 'Mãe chefe de família';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      }),
                  text: 'Mãe chefe de família'),
              ReusabledRadioListItem(
                  value: 4,
                  groupValue: _groupSocialProfile,
                  function: (newValue) => setState(() {
                        _groupSocialProfile = newValue!;
                        _socialProfileBenefit.text = '';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      }),
                  text: 'Outros'),
              Visibility(
                visible: _groupSocialProfile == 4 ? true : false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _socialProfileBenefit,
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
              Align(
                  alignment: Alignment.center,
                  child: Text(dateSignatureContratcMorarMelhor.toString())),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                        cancelText: 'Cancelar',
                        confirmText: 'Selecionar',
                        locale: Locale('pt', 'BR'),
                      );
                    },
                    icon: Icon(Icons.calendar_month),
                    label: Text('Selecione uma data')),
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
                        _numberOfVisits = 0;
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              RadioListTile<int>(
                  title: Text('Sim'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupNumberVisits,
                  onChanged: (value) => setState(() {
                        _groupNumberVisits = value!;
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              Visibility(
                  visible: _groupNumberVisits == 1 ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: IconButton(
                            icon: Icon(Icons.remove, size: 40),
                            onPressed: () => setState(() {
                                  _numberOfVisits > 0
                                      ? _numberOfVisits--
                                      : null;
                                })),
                      ),
                      Flexible(
                          child: Text(
                        _numberOfVisits.toString(),
                        style: TextStyle(fontSize: 50),
                      )),
                      Flexible(
                        child: IconButton(
                            icon: Icon(Icons.add, size: 40),
                            onPressed: () => setState(() {
                                  _numberOfVisits++;
                                })),
                      ),
                    ],
                  )),
              Divider(),
              Text(
                'Que tipo de melhoria foi contemplada?',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: _kindOfImprovement,
                  minLines: 2,
                  maxLines: 5,
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
                        _degreeOfSatisfactionServices = 'Ótimo';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              RadioListTile<int>(
                  title: Text('Bom'),
                  activeColor: Colors.orange,
                  value: 2,
                  groupValue: _groupValue4,
                  onChanged: (value) => setState(() {
                        _groupValue4 = value!;
                        _degreeOfSatisfactionServices = 'Bom';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              RadioListTile<int>(
                  title: Text('Regular'),
                  activeColor: Colors.orange,
                  value: 3,
                  groupValue: _groupValue4,
                  onChanged: (value) => setState(() {
                        _groupValue4 = value!;
                        _degreeOfSatisfactionServices = 'Regular';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              RadioListTile<int>(
                  title: Text('Péssimo'),
                  activeColor: Colors.orange,
                  value: 4,
                  groupValue: _groupValue4,
                  onChanged: (value) => setState(() {
                        _groupValue4 = value!;
                        _degreeOfSatisfactionServices = 'Péssimo';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              Divider(),
              Text(
                'Você conhece os responsáveis pela empresa que está realizando os serviços?',
                style: TextStyle(fontSize: 25),
              ),
              RadioListTile<int>(
                  title: Text('NÃO'),
                  activeColor: Colors.orange,
                  value: 2,
                  groupValue: _groupValue5,
                  onChanged: (value) => setState(() {
                        _groupValue5 = value!;
                        _knowEnterpriseOfService = 'NÃO';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
                      })),
              RadioListTile<int>(
                  title: Text('SIM'),
                  activeColor: Colors.orange,
                  value: 1,
                  groupValue: _groupValue5,
                  onChanged: (value) => setState(() {
                        _groupValue5 = value!;
                        _knowEnterpriseOfService = 'SIM';
                        FocusManager.instance.primaryFocus
                            ?.unfocus(); //dismiss Keyboard
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
                value: _classificationMorarMelhor,
                label: _classificationMorarMelhor.round().toString(),
                onChangeStart: (_) => FocusManager.instance.primaryFocus
                    ?.unfocus(), //dismiss Keyboard,
                onChanged: (newValue) => setState(() {
                  _classificationMorarMelhor = newValue;
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
                value: _classificationGovenment,
                label: _classificationGovenment.round().toString(),
                onChangeStart: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                onChanged: (newValue) => setState(() {
                  _classificationGovenment = newValue;
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
                  minLines: 2,
                  maxLines: 5,
                  controller: _otherInformationsImprovement,
                  decoration: kTextFieldDecorationMorarMelhor.copyWith(
                      hintText: 'Sugestões, críticas ou observações'),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 70)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.save, color: Colors.white),
                        label: Text(
                          'Salvar',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
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
            controller: controller,
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
