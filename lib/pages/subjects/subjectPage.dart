import 'package:aprendoai_front/pages/collections/emptyCollectionPage.dart';
import 'package:flutter/material.dart';
import 'listSubject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubjectPage extends StatefulWidget {
  final int collectionId;
  final String collectionName; // Novo campo para armazenar o nome da coleção

  const SubjectPage({super.key, required this.collectionId, required this.collectionName});

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<Map<String, dynamic>> subjects = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    final url = Uri.parse("https://seu-backend.com/api/collections/${widget.collectionId}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          subjects = List<Map<String, dynamic>>.from(data["data"] ?? []);
          isLoading = false;
        });
      } else {
        throw Exception("Erro ao buscar os assuntos");
      }
    } catch (e) {
      print("Erro: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (subjects.isEmpty) {
      return Scaffold(
        body: Center(
      child: EmptyCollectionPage(subjectName: widget.collectionName), // Passando o nome da coleção
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assuntos",
          style: TextStyle(
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
