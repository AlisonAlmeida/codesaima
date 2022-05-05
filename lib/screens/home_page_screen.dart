// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/components/home_page_central_button.dart';
import 'package:codesaima/consts.dart';
import 'package:codesaima/screens/list_of_people.dart';
import 'package:codesaima/screens/crup_person_screen.dart';
import 'package:codesaima/screens/morar_melhor_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                accountEmail: Text('email Usuario'),
                accountName: Text('Usuario')),
            Card(
              elevation: 2,
              child: ListTile(
                  leading: Icon(Icons.person_search),
                  title: Text('Lista de cidadãos cadastrados'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListOfPeople()));
                  }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Image.asset(kPathMainLogoCodesaima, height: 30),
      ),
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          children: [
            CentralButton(
                title: 'Governo de Roraima',
                img: kPathLogoGovRoraimaPreta,
                onTap: () {}),
            CentralButton(
                title: 'Aqui Tem Dono',
                img: kPathLogoAquiTemDono,
                onTap: () {}),
            CentralButton(
                title: 'Morar Melhor',
                img: kPathLogoMorarMelhor,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MorarMelhorScreen(),
                      ));
                })
          ],
        ),
      ),

      /*
      bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          unselectedIconTheme: IconThemeData(color: Colors.black),
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Pesquisas',
            ),
          ]),

          */
    );
  }
}
