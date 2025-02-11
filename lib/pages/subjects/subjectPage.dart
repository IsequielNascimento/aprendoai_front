import 'package:aprendoai_front/modal/addSubjectModal.dart';
import 'package:aprendoai_front/pages/subjects/EmptySubjectPage.dart';
import 'package:flutter/material.dart';
import 'listSubject.dart';
import 'package:http/http.dart' as http;
import "package:aprendoai_front/constants/constants.dart";
import 'dart:convert';

class SubjectPage extends StatefulWidget {
  final String userId;
  final String folderId;
  final String collectionName;

  const SubjectPage({
    Key? key,
    required this.userId,
    required this.folderId,
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

  Future<String> fetchSummary(String subjectId) async {
    final url = Uri.parse(
      "$baseUrl/api/user/${widget.userId}/folder/${widget.folderId}/collection/$subjectId/summary?generatedIA=true",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["data"].isNotEmpty) {
          // Se houver dados, retorna o conteúdo do resumo
          return data["data"][0]["content"] ?? "";
        }
      }
    } catch (e) {
      print("Erro ao buscar sumário: $e");
    }
    return ""; // Caso de erro ou sumário vazio
  }

  Future<void> fetchSubjects() async {
    final url = Uri.parse(
      "$baseUrl/api/user/${widget.userId}/folder/${widget.folderId}/collection",
    );

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
          folderId: widget.folderId,
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

// No método build onde o EmptyCollectionPage é criado
    if (subjects.isEmpty) {
      return Scaffold(
        body: Center(
          child: EmptySubjectPage(
            // Alterado para EmptySubjectPage
            subjectName: widget.collectionName,
            userId: widget.userId,
            folderId: widget.folderId,
            subjectId:
                widget.folderId, // Ou o ID correto da coleção se disponível
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddSubjectModal,
          backgroundColor: const Color(0xFF05274D),
          child: const Icon(
            Icons.add,
          ),
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
      body: ListSubjectWidget(
        subjects: subjects,
        fetchSummary: fetchSummary,
        userId: widget.userId,
        folderId: widget.folderId,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSubjectModal,
        backgroundColor: const Color(0xFF05274D),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
