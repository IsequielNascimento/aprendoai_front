import 'package:aprendoai_front/constants/constants.dart';
import 'package:aprendoai_front/modal/addSubjectModal.dart';
import 'package:aprendoai_front/pages/collections/emptyCollectionPage.dart';
import 'package:aprendoai_front/pages/subjects/listSubject.dart';
import 'package:aprendoai_front/pages/subjects/subjectDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmptySubjectPage extends StatefulWidget {
  final String subjectName;
  final String userId;
  final String folderId;
  final String subjectId; // ID da coleção/subject

  const EmptySubjectPage({
    super.key,
    required this.subjectName,
    required this.userId,
    required this.folderId,
    required this.subjectId,
  });

  @override
  _EmptySubjectPageState createState() => _EmptySubjectPageState();
}

class _EmptySubjectPageState extends State<EmptySubjectPage> {
  bool isLoading = false;

  Future<void> _generateContentWithAI() async {
    setState(() {
      isLoading = true;
    });

    // Verificando se os valores necessários não estão nulos ou vazios
    if (widget.userId.isEmpty ||
        widget.folderId.isEmpty ||
        widget.subjectId.isEmpty) {
      print(
          "Erro: userId, folderId ou subjectId não podem ser nulos ou vazios.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Erro: userId, folderId ou subjectId não podem ser nulos ou vazios.")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse(
      "$baseUrl/api/user/${widget.userId}/folder/${widget.folderId}/collection/${widget.subjectId}/summary?generatedIA=true",
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'subjectName': widget.subjectName,
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectDetailsPage(
              userId: widget.userId, 
              folderId: widget.folderId, 
              subjectId: widget.subjectId, 
              subjectTitle: widget.subjectName,
              //summary: data['data'],
              summary: data['data']['content'],// checar bug onde só é possível pegar subjecId voltando até collectionPage

            ),
          ),
        );
      } else {
        print(
            "Erro ao gerar conteúdo: ${response.statusCode} - ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Erro ao gerar conteúdo com IA. Código: ${response.statusCode}")),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Erro na requisição: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro na requisição")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("assets/teste.png", height: 200), // imagem de fundo
                const SizedBox(height: 20),
                Text(
                  widget.subjectName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF05274D),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Opss!\nParece que esse assunto está vazio.\nVocê pode tentar:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : _generateContentWithAI, // Chama a função para gerar o conteúdo
                  icon: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Icon(Icons.auto_awesome),
                  label: const Text("Gerar conteúdo com IA"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
