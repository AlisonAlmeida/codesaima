import 'package:codesaima/consts.dart';
import 'package:flutter/material.dart';

class RadioSexChoice extends StatelessWidget {
  const RadioSexChoice({
    Key? key,
    required this.gender,
    required this.groupValueSex,
    required this.function,
  }) : super(key: key);

  final Gender gender;

  final Gender groupValueSex;
  final Function(Gender?) function;

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final String text;

    switch (gender) {
      case Gender.male:
        {
          icon = Icons.male;
          text = 'Masculino';

          break;
        }
      case Gender.female:
        {
          icon = Icons.female;
          text = 'Feminino';
          break;
        }
      case Gender.other:
        {
          icon = Icons.transgender;
          text = 'Outro';
          break;
        }
    }
    return RadioListTile<Gender>(
        secondary: Icon(icon),
        value: gender,
        title: Text(text),
        groupValue: groupValueSex,
        onChanged: function);
  }
}
