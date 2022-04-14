// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'package:codesaima/components/home_page_central_button.dart';
import 'package:codesaima/consts.dart';
import 'package:codesaima/screens/searchs/morar_melhor_search_screen.dart';
import 'package:codesaima/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20), child: Icon(Icons.person))
        ],
        title: Image.asset(kPathMainLogoCodesaimaBranca,
            fit: BoxFit.cover, height: 30),
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
                        builder: (context) => MorarMelhorSearchScreen(),
                      ));
                })
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedIconTheme: IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.black),
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
          backgroundColor: Colors.red,
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
    );
  }
}
