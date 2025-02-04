import 'package:flutter/material.dart';

class EmptySubjectPage extends StatelessWidget {
  final String subjectName;

  const EmptySubjectPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coleção - $subjectName"),
      ),
      
      body:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       Padding(
        
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset("assets/teste.png", height: 200), // background image
            const SizedBox(height: 20),
            Text(
              subjectName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF05274D),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Opss!\nParece que esse assunto está vazio.\nVocê pode tentar:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                //  implementar adicionar gerar conteúdo com IA
              },
              icon: const Icon(Icons.auto_awesome),
              label: const Text("Gerar conteúdo com IA"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // implementar adicionar novo conteúdo
              },
              icon: const Icon(Icons.create),
              label: const Text("Criar conteúdo"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
      ])
    );
  }
}
