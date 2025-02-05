import 'dart:convert';
import 'package:aprendoai_front/pages/subjects/subjectPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListCollectionWidget extends StatefulWidget {
  const ListCollectionWidget({super.key});

  @override
  State<ListCollectionWidget> createState() => ListCollectionWidgetState();
}

class ListCollectionWidgetState extends State<ListCollectionWidget> {
  List<Map<String, dynamic>> collections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCollections();
  }

  Future<void> fetchCollections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId == null) {
      setState(() => isLoading = false);
      return;
    }

    const int quantity = 1000;
    const int page = 1;

    final response = await http.get(
      Uri.parse(
          'http://192.168.0.2:3000/api/user/$userId/folder?quantity=$quantity&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // setState(() {
      //   collections =
      //       List<Map<String, dynamic>>.from(data['data'].map((folder) => {
      //             "title": folder["nameFolder"],
      //             "image": "assets/teste.png",
      //             //"subjects": [], // Adiciona um campo subjects vazio por enquanto
      //             "subjects": <Map<String, dynamic>>[],
      //           }));
      //   isLoading = false;
      // });
      setState(() {
        collections =
            List<Map<String, dynamic>>.from(data['data'].map((folder) => {
                  "id": folder[
                      "id"], // ID da coleção, necessário para a navegação correta
                  "title": folder["nameFolder"],
                  "image": "assets/teste.png",
                  "subjects": <Map<String, dynamic>>[],
                }));
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> addCollection(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    const int quantity = 1000;
    const int page = 1;

    if (userId == null) return;

    final response = await http.post(
      Uri.parse(
          'http://192.168.0.2:3000/api/user/$userId/folder?quantity=$quantity&page=$page'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"nameFolder": name, "userId": userId}),
    );

    if (response.statusCode == 200) {
      fetchCollections();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : collections.isEmpty
            ? const Center(child: Text("Nenhuma coleção encontrada"))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  final collection = collections[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubjectPage(
                            collectionId: collection["id"],
                            collectionName: collection[
                                "title"], // Passando o nome da coleção
                          ),
                        ),
                      );
                    },
                    child: _buildCollectionCard(collection),
                  );
                },
              );
  }

  Widget _buildCollectionCard(Map<String, dynamic> collection) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF05274D),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  collection["image"],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection["title"],
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
