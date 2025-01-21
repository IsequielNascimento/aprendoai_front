import 'package:aprendoai_front/pages/home.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _myIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
      

        height: 80,
        elevation: 0,
        onDestinationSelected: (index) {
          setState(() {
          _myIndex = index;
            
          });
        },
        

        destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.white,),
          icon: Icon(Icons.home_outlined), 
          label: "Home",),
        NavigationDestination(icon: Icon(Icons.bookmark_border), label: "Collections"),
        NavigationDestination(icon: Icon(Icons.account_circle), label: "Perfil"),        
      ],  
      
      selectedIndex: _myIndex,
      indicatorColor: Color.fromRGBO(5, 39, 77, 100),

      

    
      ),
      body: Container(),
      
      
    );

  }
}
