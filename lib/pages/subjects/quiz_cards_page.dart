import 'package:aprendoai_front/constants/constants.dart';
import 'package:aprendoai_front/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quiz_page.dart';

class QuizCardsPage extends StatefulWidget {
  final String userId;
  final String folderId;
  final String subjectId;
  final String subjectTitle;

  const QuizCardsPage({
    super.key,
    required this.userId,
    required this.folderId,
    required this.subjectId,
    required this.subjectTitle,
  });

  @override
  State<QuizCardsPage> createState() => _QuizCardsPageState();
}

class _QuizCardsPageState extends State<QuizCardsPage> {
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

  Future<String> fetchSummary() async {
    final url = Uri.parse(
        '$baseUrl/api/user/${widget.userId}/folder/${widget.folderId}/collection/${widget.subjectId}/summary?generatedIA=true');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'][0]['content']; // Retorna o conteúdo do resumo
    } else {
      throw Exception('Falha ao carregar resumo');
    }
  }

  Future<void> createFlashcards(String content, int quantity) async {
    final url = Uri.parse(
        '$baseUrl/api/user/${widget.userId}/folder/${widget.folderId}/collection/${widget.subjectId}/flashcard?generatedIA=true');

    final body = jsonEncode({
      'userInput': content,
      'quantity': quantity,
    });

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      print("Resposta do servidor: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 201) {
        if (mounted) {
          setState(() {
            flashcards = fetchFlashcards(); // Atualiza a lista de flashcards
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Flashcards criados com sucesso!')));
          }
        }
      } else {
        // Trate o erro de outra forma, se necessário
      }
    } catch (e) {
      print("Erro de exceção: $e");
      // Exibindo o SnackBar após verificar se o widget está montado
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Falha ao criar flashcards')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    flashcards = fetchFlashcards(); // Carrega os flashcards ao iniciar a página
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


  void showFlashcardDialog() {
    TextEditingController quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Criar Flashcards'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Quantos flashcards você quer criar?'),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Quantidade'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                int quantity = int.tryParse(quantityController.text) ?? 1;
                String content = await fetchSummary();
                await createFlashcards(content, quantity);
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perguntas Salvas",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: flashcards,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(child: Text('Nenhum flashcard encontrado.')),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed:
                          showFlashcardDialog, // Botão para criar flashcards
                      child: const Text("Criar Flashcards",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ),
                ],
              );
            } else {
              final flashcards = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: flashcards.length,
                      itemBuilder: (context, index) {
                        final card = flashcards[index];
                        bool isCreatedByAi = card["source"] == "Criado por AI";

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Appthemes.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  card["source"] ?? "Gerado por IA",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  card["question"]!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.chevron_right,
                                      color: Colors.grey),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            QuizPage(questions: [card]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Appthemes.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => startQuiz(flashcards),
                      child: const Text("Começar revisão",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed:
                          showFlashcardDialog, // Botão para criar flashcards
                      child: const Text("Criar Flashcards",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
