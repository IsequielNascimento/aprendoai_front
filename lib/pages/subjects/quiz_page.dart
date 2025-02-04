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
    final questionData = widget.questions[currentQuestionIndex];
    final questionText = questionData["question"];
    final options = questionData["options"] as List<String>;
    final correctAnswer = questionData["correctAnswer"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz | ${questionData["source"]}"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / widget.questions.length,
            ),
            const SizedBox(height: 20),
            Text(
              questionText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: options.map((option) {
                Color? buttonColor;
                if (isAnswered) {
                  if (option == correctAnswer) {
                    buttonColor = Colors.green;
                  } else if (option == selectedAnswer) {
                    buttonColor = Colors.red;
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor ?? Colors.blueAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(option),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (currentQuestionIndex < widget.questions.length - 1) {
                  setState(() {
                    currentQuestionIndex++;
                    selectedAnswer = null;
                    isAnswered = false;
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(currentQuestionIndex < widget.questions.length - 1 ? "Próxima pergunta" : "Finalizar"),
            ),
          ],
        ),
      ),
    );
  }
}
