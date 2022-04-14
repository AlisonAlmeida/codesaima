// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CentralButton extends StatelessWidget {
  final String title;

  final VoidCallback onTap;
  final String img;
  const CentralButton({
    Key? key,
    required this.title,
    required this.img,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Image.asset(img, fit: BoxFit.contain),
      ),
    );
  }
}
