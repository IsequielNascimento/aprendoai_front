import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Folders Page"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child:
         Text("PERFIL"),
      ),
    );
  }
}
