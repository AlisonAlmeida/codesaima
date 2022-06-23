// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/components/home_page_central_button.dart';
import 'package:codesaima/consts.dart';
import 'package:codesaima/screens/morar_melhor_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                accountEmail: Text(user.email!),
                accountName: Text(user.uid)),
            Card(
              elevation: 2,
              child: ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: Text('Delogar'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Image.asset(kPathMainLogoCodesaima, height: 30),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 900,
            image: AssetImage(kPathEdificeCodesaimaBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GridView.count(
            padding: EdgeInsets.all(10),
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            children: [
              CentralButton(
                  title: 'Morar Melhor',
                  img: kPathLogoMorarMelhor,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MorarMelhorScreen(),
                      ))),

              /*
              CentralButton(
                  title: 'Governo de Roraima',
                  img: kPathLogoGovRoraimaPreta,
                  onTap: () {}),
              CentralButton(
                  title: 'Aqui Tem Dono',
                  img: kPathLogoAquiTemDono,
                  onTap: () {}),

                 */
            ],
          ),
        ),
      ),
    );
  }
}
