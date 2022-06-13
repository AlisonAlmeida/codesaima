import 'package:flutter/material.dart';

class RadioResidenceChoice extends StatelessWidget {
  const RadioResidenceChoice({
    Key? key,
    required this.radioTitleList,
    required this.mainTitle,
    required this.groupValue,
    required this.function,
  }) : super(key: key);

  final String mainTitle;
  final List<String> radioTitleList;
  final Function(String?) function;
  final String groupValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(mainTitle,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          for (int i = 0; i < radioTitleList.length; i++)
            RadioListTile<String>(
                value: radioTitleList[i],
                title: Text(radioTitleList[i]),
                groupValue: groupValue,
                onChanged: function),
        ],
      ),
    );
  }
}
