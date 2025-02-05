import 'package:flutter/material.dart';
import 'collections/listCollection.dart';
import '../modal/modal_bottom_sheet.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final GlobalKey<ListCollectionWidgetState> _listCollectionKey = GlobalKey();

  /// Função para adicionar nova coleção
  void _addCollection(String name) {
    _listCollectionKey.currentState?.addCollection(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Coleções",
          style: TextStyle(
            color: Color.fromRGBO(5, 39, 77, 1),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListCollectionWidget(key: _listCollectionKey), // Passando a key
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF05274D),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => ModalBottomSheetWidget(
                onAddCollection: _addCollection, // Passando a função
              ),
            );
          },
          child: const Text(
            "Nova Coleção",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
