import 'package:aprendoai_front/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'subject_summary_page.dart';
import 'quiz_cards_page.dart';

class SubjectDetailsPage extends StatelessWidget {
  final String userId;
  final String folderId;
  final String subjectId;
  final String subjectTitle;
  final String summary;

  const SubjectDetailsPage({
    super.key,
    required this.userId,
    required this.folderId,
    required this.subjectId,
    required this.subjectTitle,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subjectTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subjectTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectSummaryPage(
                      subjectTitle: subjectTitle,
                      fullSummary: summary,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF05274D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  summary.length > 100
                      ? "${summary.substring(0, 255)}..."
                      : summary,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizCardsPage(
                      userId: userId,
                      folderId: folderId,
                      subjectId: subjectId,
                      subjectTitle: subjectTitle,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.create,
                color: Appthemes.primary,
              ),
              label: Text(
                "Lista de perguntas",
                style: TextStyle(color: Appthemes.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
