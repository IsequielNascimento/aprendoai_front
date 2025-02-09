import 'package:aprendoai_front/pages/collections/listCollection.dart';
import 'package:aprendoai_front/widgets/weekly_summary.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),  // Pode ser deixado vazio se não for necessário um título
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Resumo Semanal",
                  style: TextStyle(
                    color: Color.fromRGBO(5, 39, 77, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const WeeklySummary(),
            Row(
              children: [
                const Text(
                  "Seus últimos estudos",
                  style: TextStyle(
                    color: Color.fromRGBO(5, 39, 77, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const ListCollectionWidget(),
            const SizedBox(height: 8),  // Pode ser mais legível que o Padding
          ],
        ),
      ),
    );
  }
}
