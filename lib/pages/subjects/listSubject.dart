import 'package:flutter/material.dart';
import 'subjectDetailPage.dart';

class ListSubjectWidget extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;

  const ListSubjectWidget({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubjectDetailsPage(
                  subjectTitle: subject["nameCollection"], // Nome correto vindo do back-end
                  summary: subject["resumeCollection"] ?? "Sem resumo disponível.",
                ),
              ),
            );
          },
          child: _buildSubjectCard(context, subject),
        );
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF05274D),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/teste.png", // Imagem padrão
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  subject["nameCollection"], // Nome correto vindo do back-end
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton.filled(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubjectDetailsPage(
                        subjectTitle: subject["nameCollection"],
                        summary: subject["resumeCollection"] ?? "Sem resumo disponível.",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
