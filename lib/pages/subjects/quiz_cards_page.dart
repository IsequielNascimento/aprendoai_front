import 'package:flutter/material.dart';
import 'quiz_page.dart';

class QuizCardsPage extends StatefulWidget {
  final String subjectTitle;

  const QuizCardsPage({super.key, required this.subjectTitle});

  @override
  State<QuizCardsPage> createState() => _QuizCardsPageState();
}

class _QuizCardsPageState extends State<QuizCardsPage> {
  List<Map<String, dynamic>> flashcards = [
    {
      "question": "Qual das alternativas abaixo NÃO é uma forma de gerar energia elétrica?",
      "options": ["Energia eólica", "Energia solar", "Energia nuclear", "Energia mecânica"],
      "correctAnswer": "Energia mecânica",
      "source": "Criado por mim"
    },
    {
      "question": "Qual destes não é um estado físico da matéria?",
      "options": ["Sólido", "Líquido", "Gasoso", "Plasma"],
      "correctAnswer": "Plasma",
      "source": "Gerado por IA"
    },
      {
      "question": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
      "options": ["AAAAAAAAA eólica", "AAAAAAAAAA solar", "AAAAAAAAAAAAA nuclear", "AAAAAAAAA mecânica"],
      "correctAnswer": "AAAAAAAAAAAAA nuclear",
      "source": "Criado por mim"
    },
  ];

  void startQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(questions: flashcards),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perguntas Salvas",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: flashcards.length,
                itemBuilder: (context, index) {
                  final card = flashcards[index];
                  bool isCreatedByMe = card["source"] == "Criado por mim";

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
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isCreatedByMe ? Colors.blue[900] : Colors.blue[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            card["source"]!,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            card["question"]!,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.chevron_right, color: Colors.grey),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizPage(questions: [card]),
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

            // Botão "Criar quiz"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[900]!),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.black),
                  SizedBox(width: 8),
                  Text("Criar quiz", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Botão "Começar revisão"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: startQuiz,
                child: const Text("Começar revisão", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
