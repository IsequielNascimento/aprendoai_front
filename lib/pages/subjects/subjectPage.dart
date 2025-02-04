import 'package:aprendoai_front/pages/collections/emptyCollectionPage.dart';
import 'package:flutter/material.dart';
import 'listSubject.dart';

class SubjectPage extends StatelessWidget {
  final String subjectName;
  final List<Map<String, dynamic>> subjects;

  const SubjectPage({super.key, required this.subjectName, required this.subjects});

  @override
  Widget build(BuildContext context) {
    if (subjects.isEmpty) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmptyCollectionPage(subjectName: subjectName),
          ),
        );
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
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
      body: ListSubjectWidget(subjects: subjects),
    );
  }
}
