import 'package:aprendoai_front/themes/app_themes.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizPage({super.key, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool isAnswered = false;

  void checkAnswer(String answer) {
    if (isAnswered) return;

    setState(() {
      selectedAnswer = answer;
      isAnswered = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < widget.questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
          isAnswered = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se a lista de perguntas está vazia
    if (widget.questions.isEmpty) {
      return Scaffold(
        backgroundColor: Appthemes.primary,
        appBar: AppBar(
          backgroundColor: Appthemes.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Quiz", style: TextStyle(color: Colors.white)),
        ),
        body: const Center(
          child: Text(
            "Nenhuma pergunta disponível!",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }

    final questionData = widget.questions[currentQuestionIndex];
    final questionText = questionData["question"];
    final options = (questionData["options"] as List<dynamic>).map((e) => e.toString()).toList();
    final correctAnswer = questionData["correctAnswer"];

    return Scaffold(
      backgroundColor: Appthemes.primary,
      appBar: AppBar(
        backgroundColor: Appthemes.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              "Quiz | ${questionData["source"]}",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.bolt, color: Colors.yellow, size: 18),
            const Text(
              " Gerado por IA",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de progresso
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / widget.questions.length,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 24),

            // Pergunta
            Text(
              questionText,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Opções de resposta
            Column(
              children: options.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;

                Color? buttonColor;
                Color textColor = Colors.white;
                if (isAnswered) {
                  if (option == correctAnswer) {
                    buttonColor = Colors.green[700];
                  } else if (option == selectedAnswer) {
                    buttonColor = Colors.red[700];
                  }
                } else {
                  buttonColor = Appthemes.primary;
                }

                return GestureDetector(
                  onTap: () => checkAnswer(option),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + index), // A, B, C, D
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 16, color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Botão "Favoritar"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F6A5E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Lógica para favoritar a pergunta
                },
                child: const Text("Favoritar",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
