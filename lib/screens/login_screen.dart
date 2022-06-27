// ignore_for_file: prefer_const_constructors

import 'package:codesaima/consts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Hero(
                          tag: 'intro',
                          child: Image.asset(kPathMainLogoCodesaima))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Ex. abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 40),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Senha'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () async {
                    await _auth.signInAnonymously();
                  },

                  // _loginButtonPressed(),
                  child: Text(
                    'Acessar',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              TextButton(
                  child: Text('Logar anonimamente'),
                  onPressed: () async {
                    try {
                      await _auth.signInAnonymously();
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  void _loginButtonPressed() {
    showGeneralProgressIndicator(context, 'Logando');
    _signIn();
  }

  Future _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);

      e.toString().contains('Given String is empty or null')
          ? showGeneralAlertMessage(context, 'Preencha os dois campos!')
          : null;

      e.toString().contains('The email address is badly formatted')
          ? showGeneralAlertMessage(context, 'E-mail incorreto!')
          : null;

      e.toString().contains(
              'The password is invalid or the user does not have a password')
          ? showGeneralAlertMessage(
              context, 'Senha inválida ou usuário não tem acesso!')
          : null;
    }
  }
}
