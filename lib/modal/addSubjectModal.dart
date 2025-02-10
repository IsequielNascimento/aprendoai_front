import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aprendoai_front/pages/subjects/EmptySubjectPage.dart';

class AddSubjectModal extends StatefulWidget {
  final String userId;
  final String folderId;
  final Function(String) onAddSubject;

  const AddSubjectModal({
    Key? key,
    required this.userId,
    required this.folderId,
    required this.onAddSubject,
  }) : super(key: key);

  @override
  State<AddSubjectModal> createState() => _AddSubjectModalState();
}

class _AddSubjectModalState extends State<AddSubjectModal> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  Future<void> _addSubject() async {
    if (_controller.text.isEmpty) return;

    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse("http://192.168.0.2:3000/api/user/${widget.userId}/folder/${widget.folderId}/collection"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nameCollection": _controller.text,
        "resumeCollection": "",
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final subjectId = data['id'];  // Captura o subjectId da resposta do servidor

      widget.onAddSubject(_controller.text);
      Navigator.pop(context); // Fecha o modal

      // Redireciona para a página do novo assunto com os parâmetros necessários
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmptySubjectPage(
            subjectName: _controller.text,
            userId: widget.userId, // Passando userId
            folderId: widget.folderId, // Passando folderId
            subjectId: subjectId,  // Passando o subjectId da resposta
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao adicionar o assunto")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Novo Assunto",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Nome do Assunto",
                hintText: "Ex: Álgebra, História Mundial",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF05274D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: isLoading ? null : _addSubject,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Adicionar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}