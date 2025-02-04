import 'package:flutter/material.dart';

class SubjectSummaryPage extends StatelessWidget {
  final String subjectTitle;
  final String fullSummary;

  const SubjectSummaryPage({
    super.key,
    required this.subjectTitle,
    required this.fullSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resumo | $subjectTitle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullSummary,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text("⚡ Gerado por IA", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
