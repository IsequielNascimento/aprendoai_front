import 'package:aprendoai_front/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';


class Aprendoai extends StatefulWidget {
  const Aprendoai({super.key});

  @override
  State<Aprendoai> createState() => _AprendoaiState();
}

class _AprendoaiState extends State<Aprendoai> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: BottomNavigation(),
    );
  }
}