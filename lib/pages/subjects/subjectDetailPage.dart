import 'package:aprendoai_front/constants/constants.dart';
import 'package:aprendoai_front/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quiz_page.dart';
import 'quiz_cards_page.dart'; // Importar QuizCardsPage

class SubjectDetailsPage extends StatefulWidget {
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
  State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  late Future<List<Map<String, dynamic>>> flashcards;

  Future<List<Map<String, dynamic>>> fetchFlashcards() async {
    final url = Uri.parse(
        '$baseUrl/api/user/${widget.userId}/folder/${widget.folderId}/collection/${widget.subjectId}/flashcard');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception('Falha ao carregar flashcards');
    }
  }

  void startQuiz(List<Map<String, dynamic>> questions) {
    if (questions.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(questions: questions),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    flashcards = fetchFlashcards(); // Carrega os flashcards ao iniciar a página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subjectTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.subjectTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // Ação para mostrar o resumo completo
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF05274D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.summary.length > 100
                      ? "${widget.summary.substring(0, 255)}..."
                      : widget.summary,
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
                      userId: widget.userId,
                      folderId: widget.folderId,
                      subjectId: widget.subjectId,
                      subjectTitle: widget.subjectTitle,
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
            const SizedBox(height: 12),
            // Botão "Começar revisão"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Appthemes.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  try {
                    // Espera carregar os flashcards
                    final flashcardsData = await flashcards;
                    startQuiz(flashcardsData); // Inicia o quiz com os flashcards carregados
                  } catch (e) {
                    // Exibe mensagem de erro caso falhe ao carregar os flashcards
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Falha ao carregar flashcards')));
                  }
                },
                child: const Text(
                  "Teste os seus conhecimentos",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
