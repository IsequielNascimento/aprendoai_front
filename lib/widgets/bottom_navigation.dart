import 'package:aprendoai_front/pages/collectionPage.dart';
import 'package:aprendoai_front/pages/home.dart';
import 'package:aprendoai_front/pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _myIndex = 0;
// Rotas para as telas
  List<Widget> pagesList = const [
    HomePage(),
    CollectionPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pagesList[_myIndex]),
      bottomNavigationBar: NavigationBar(

      //customização da navigationBar
        indicatorColor: Color.fromRGBO(5, 39, 77, 1),
        height: 80,
        elevation: 0,

        //Seleção da tela On click
        selectedIndex: _myIndex,
        onDestinationSelected: (index) {
          setState(() {
            _myIndex = index;
          });
        },
        // Customização dos Icones
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(Icons.home_outlined),
            label: "Início",
          ),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.bookmark,
                color: Color(0xFFFFFFFF),
              ),
              icon: Icon(Icons.bookmark_border),
              label: "Coleções"),
          NavigationDestination(
              selectedIcon: Icon(
                Icons.account_circle,
                color: Color(0xFFFFFFFF),
              ),
              icon: Icon(Icons.account_circle_outlined),
              label: "Perfil"),
        ],

        
       
      ),
    );
  }
}
