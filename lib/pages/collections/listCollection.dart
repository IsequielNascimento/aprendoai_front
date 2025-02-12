import 'dart:convert';
import 'package:aprendoai_front/constants/constants.dart';
import 'package:aprendoai_front/pages/collections/emptyCollectionPage.dart';
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
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });

    if (userId != null) {
      fetchCollections();
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchCollections() async {
    if (userId == null) {
      setState(() => isLoading = false);
      return;
    }

    const int quantity = 1000;
    const int page = 1;

    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/api/user/$userId/folder?quantity=$quantity&page=$page'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          collections =
              List<Map<String, dynamic>>.from(data['data'].map((folder) => {
                    "id": folder["id"],
                    "title": folder["nameFolder"],
                    "image": "assets/teste.png",
                    "subjects": <Map<String, dynamic>>[],
                  }));
          isLoading = false;
        });
      } else {
        throw Exception("Erro ao carregar coleções: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Erro ao buscar coleções: $e");
    }
  }

  Future<void> addCollection(String name) async {
    if (userId == null) return;

    final response = await http.post(
      Uri.parse('$baseUrl/api/user/$userId/folder'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"nameFolder": name}),
    );

    if (response.statusCode == 200) {
      final newCollection = {
        "id": jsonDecode(response.body)["data"]["id"],
        "title": name,
        "image": "assets/teste.png",
        "subjects": <Map<String, dynamic>>[],
      };

      setState(() {
        collections.add(newCollection);
      });
    } else {
      debugPrint("Erro ao adicionar coleção: ${response.body}");
    }
  }

  void _handleCollectionTap(Map<String, dynamic> collection) async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro: usuário não identificado.")),
      );
      return;
    }

    int folderId = collection["id"];

    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/user/$userId/folder/$folderId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final bool hasSubjects =
            data['data']?['collection']?.isNotEmpty ?? false;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => hasSubjects
                ? SubjectPage(
                    userId: userId.toString(),
                    folderId: folderId.toString(),
                    collectionName: collection["title"],
                  )
                : EmptyCollectionPage(
                    userId: userId.toString(),
                    collectionId: folderId.toString(),
                    collectionName: collection["title"],
                  ),
          ),
        );
      } else {
        throw Exception("Erro ao carregar a coleção.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar a coleção.")),
      );
      debugPrint("Erro: $e");
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
                    onTap: () => _handleCollectionTap(collection),
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
    );
  }
}
