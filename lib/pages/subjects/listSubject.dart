import 'package:flutter/material.dart';
import 'emptySubjectPage.dart';
import 'subjectDetailPage.dart';

class ListSubjectWidget extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;
  final Future<String> Function(String subjectId) fetchSummary;
  final String userId;
  final String folderId;

  const ListSubjectWidget({
    Key? key,
    required this.subjects,
    required this.userId,
    required this.folderId,
    required this.fetchSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        final String subjectId = subject["id"].toString(); // Conversão para String

        return ListTile(
            title: Text(subject["nameCollection"]),
            onTap: () async {
              String summary = await fetchSummary(subjectId); // Passando o subjectId como String
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => summary.isEmpty
                      ? EmptySubjectPage(
                          subjectName: subject['nameCollection'],
                          userId: userId,
                          folderId: folderId,
                          subjectId: subjectId, // Usando o subjectId como String
                        )
                      : SubjectDetailsPage(
                          subjectTitle: subject['nameCollection'],
                          summary: summary,
                        ),
                ),
              );
            });
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    final String subjectId = subject["id"].toString(); // Conversão para String
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
                  "assets/teste.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  subject["nameCollection"],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton.filled(
                onPressed: () async {
                  final summary =
                      await fetchSummary(subjectId); // Passando o subjectId como String

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => summary.isNotEmpty
                          ? SubjectDetailsPage(
                              subjectTitle: subject["nameCollection"],
                              summary: summary,
                            )
                          : EmptySubjectPage(
                              subjectName: subject["nameCollection"], // Nome do assunto
                              userId: subject["userId"].toString(), // Convertendo para String
                              folderId: subject["folderId"].toString(), // Convertendo para String
                              subjectId: subject["collectionId"].toString(), // Convertendo para String
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
