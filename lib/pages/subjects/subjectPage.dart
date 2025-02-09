import 'package:aprendoai_front/modal/addSubjectModal.dart';
import 'package:aprendoai_front/pages/collections/emptyCollectionPage.dart';
import 'package:flutter/material.dart';
import 'listSubject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubjectPage extends StatefulWidget {
  final String userId; 
  final String collectionId;
  final String collectionName;

  const SubjectPage({
    Key? key,
    required this.userId,
    required this.collectionId,
    required this.collectionName,
  }) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
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
    final url = Uri.parse(
        "http://192.168.0.2:3000/api/user/${widget.userId}/folder/${widget.collectionId}/collection");

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

  // Função para exibir o modal de adicionar assunto
  void _showAddSubjectModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddSubjectModal(
          userId: widget.userId,
          collectionId: widget.collectionId,
          onAddSubject: (newSubjectName) {
            // Atualize a lista de assuntos após adicionar um novo
            setState(() {
              subjects.add({"nameCollection": newSubjectName});
            });
          },
        );
      },
    );
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
          child: EmptyCollectionPage(
            userId: widget.userId,
            collectionId: widget.collectionId,
            collectionName: widget.collectionName,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddSubjectModal,
          child: const Icon(Icons.add),
          backgroundColor: const Color(0xFF05274D),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.collectionName,
          style: const TextStyle(
            color: Color.fromRGBO(5, 39, 77, 1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListSubjectWidget(subjects: subjects),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSubjectModal,
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF05274D),
      ),
    );
  }
}
