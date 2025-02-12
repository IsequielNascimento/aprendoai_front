import 'package:aprendoai_front/pages/collections/listCollection.dart';
import 'package:aprendoai_front/widgets/weekly_summary.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
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
            ),
            const ListCollectionWidget(),
          ],
        ),
      ),
    );
  }
}
