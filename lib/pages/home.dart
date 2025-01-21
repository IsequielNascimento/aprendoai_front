import 'package:flutter/material.dart';
import 'package:aprendoai_front/widgests/bottom_navigation.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
    bottomNavigationBar: BottomNavigation(),
    
    );
  }
}