import 'package:flutter/material.dart';
import 'package:aprendoai_front/widgets/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("HOME"),
        ),
        body: const Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
