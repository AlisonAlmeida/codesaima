import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../consts.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    Key? key,
    required TextEditingController telefoneController,
  })  : _telefoneController = telefoneController,
        super(key: key);

  final TextEditingController _telefoneController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputMask(mask: '(99)9 9999-9999')
      ],
      keyboardType: TextInputType.number,
      controller: _telefoneController,
      decoration: kTextFieldGeneralDecoration.copyWith(
        labelText: 'Telefone',
        hintText: '(95)98765-4321',
        prefixIcon: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(Icons.phone),
        ),
      ),
    );
  }
}
