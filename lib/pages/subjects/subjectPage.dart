import 'package:aprendoai_front/modal/addSubjectModal.dart';
import 'package:aprendoai_front/pages/subjects/EmptySubjectPage.dart';
import 'package:flutter/material.dart';

class SubjectPage extends StatelessWidget {
  final String subjectName;
  final List<Map<String, dynamic>> subjects;

  const SubjectPage({super.key, required this.subjectName, required this.subjects});

  @override
  Widget build(BuildContext context) {
    // Verifica se a lista de assuntos está vazia antes de construir a tela
    if (subjects.isEmpty) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmptySubjectPage(subjectName: subjectName),
          ),
        );
      });

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Pequeno loading enquanto redireciona
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName,
          style: const TextStyle(
            color: Color.fromRGBO(5, 39, 77, 1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        subject["image"],
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        subject["title"],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward, color: Colors.black),
                      style: IconButton.styleFrom(backgroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF05274D),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const AddSubjectModal(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
