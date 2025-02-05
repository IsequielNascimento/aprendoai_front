import 'package:flutter/material.dart';
import 'package:aprendoai_front/modal/addSubjectModal.dart';

class EmptyCollectionPage extends StatelessWidget {
  final String userId; // Adicione essa linha
  final String collectionId;
  final String collectionName;

  const EmptyCollectionPage({
    Key? key,
    required this.userId, // Adicione esse parâmetro
    required this.collectionId,
    required this.collectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          collectionName,
          style: const TextStyle(
            color: Color.fromRGBO(5, 39, 77, 1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/teste.png",
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              "Opss!\nParece que essa coleção está vazia.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Text(
              "Comece criando um assunto!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF05274D),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => AddSubjectModal(
              userId: userId, // Agora passamos corretamente o userId
              collectionId: collectionId,
              onAddSubject: (newSubject) {
                // Você pode adicionar lógica aqui caso precise atualizar algo na UI
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
