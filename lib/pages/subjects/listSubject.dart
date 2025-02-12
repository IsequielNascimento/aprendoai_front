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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return GestureDetector(
          onTap: () async {
            final summary = await fetchSummary(subject["id"].toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => summary.isEmpty
                    ? EmptySubjectPage(
                        subjectName: subject["nameCollection"],
                        userId: userId,
                        folderId: folderId,
                        subjectId: subject["id"].toString(),
                      )
                    : SubjectDetailsPage(
                        subjectTitle: subject["nameCollection"],
                        summary: summary,
                      ),
              ),
            );
          },
          child: _buildSubjectCard(context, subject), // Passando o contexto
        );
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF05274D),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/defaultSubject.png",
                height: 100,
                width: 100,
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
                final summary = await fetchSummary(subject["id"].toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => summary.isNotEmpty
                        ? SubjectDetailsPage(
                            subjectTitle: subject["nameCollection"],
                            summary: summary,
                          )
                        : EmptySubjectPage(
                            subjectName: subject["nameCollection"],
                            userId: userId,
                            folderId: folderId,
                            subjectId: subject["id"].toString(),
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
    );
  }
}
