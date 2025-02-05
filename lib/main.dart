import 'package:aprendoai_front/pages/home.dart';
import 'package:aprendoai_front/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:aprendoai_front/widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aprendo AI',

      home:
    RegisterPage(),
           //       BottomNavigation(),

    );
    
  }
}

