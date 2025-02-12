import 'package:flutter/material.dart';
import 'package:aprendoai_front/modal/addSubjectModal.dart';

class EmptyCollectionPage extends StatelessWidget {
  final String userId;
  final String collectionId;
  final String collectionName;

  const EmptyCollectionPage({
    Key? key,
    required this.userId,
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
        heroTag: 'unique_tag_1', // Atribua uma tag única
        backgroundColor: const Color(0xFF05274D),
        onPressed: () {
          // Evitar que o modal sobreponha ou descongele a tela
          Future.delayed(Duration.zero, () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => AddSubjectModal(
                userId: userId,
                folderId: collectionId,
                onAddSubject: (newSubject) {
                  // Atualizar ou processar o assunto
                  // Esse trecho de código será chamado quando um novo assunto for adicionado.
                },
              ),
            );
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
