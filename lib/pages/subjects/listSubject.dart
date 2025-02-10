import 'package:flutter/material.dart';
import 'emptySubjectPage.dart';
import 'subjectDetailPage.dart';

class ListSubjectWidget extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;
  final Future<String> Function(String subjectId) fetchSummary;

  const ListSubjectWidget({
    Key? key,
    required this.subjects,
    required this.fetchSummary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        final String subjectId = subject["id"].toString();

        return ListTile(
          title: Text(subject["nameCollection"]),
          onTap: () async {
            final summary = await fetchSummary(subjectId); // Busca o resumo

            // Verifica se o resumo está vazio ou não
            if (summary.isNotEmpty) {
              // Se houver resumo, vai para a SubjectDetailsPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectDetailsPage(
                    subjectTitle: subject["nameCollection"],
                    summary: summary, // Passando o resumo gerado
                  ),
                ),
              );
            } else {
              // Se o resumo estiver vazio, vai para a EmptySubjectPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmptySubjectPage(
                    subjectName: subject[
                        "nameCollection"], // Aqui estamos passando o nome do assunto
                    userId: subject["userId"]
                        .toString(), // Converta para String se for int
                    folderId: subject["folderId"]
                        .toString(), // Converta para String se for int
                    subjectId: subject["collectionId"]
                        .toString(), // Converta para String se for int
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    final String subjectId = subject["id"].toString();
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
                      await fetchSummary(subjectId); // Busca o resumo

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => summary.isNotEmpty
                          ? SubjectDetailsPage(
                              subjectTitle: subject["nameCollection"],
                              summary: summary,
                            )
                          : EmptySubjectPage(
                              subjectName: subject[
                                  "nameCollection"], // Aqui estamos passando o nome do assunto
                              userId: subject["userId"]
                                  .toString(), // Converta para String se for int
                              folderId: subject["folderId"]
                                  .toString(), // Converta para String se for int
                              subjectId: subject["collectionId"]
                                  .toString(), // Converta para String se for int
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
