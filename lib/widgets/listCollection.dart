import 'package:aprendoai_front/pages/collections/emptyCollectionPage.dart';
import 'package:aprendoai_front/pages/subjects/subjectPage.dart';
import 'package:aprendoai_front/pages/subjects/EmptySubjectPage.dart';
import 'package:aprendoai_front/pages/subjects/listSubject.dart';
import 'package:flutter/material.dart';

class ListCollectionWidget extends StatefulWidget {

  const ListCollectionWidget({super.key});

  @override
  State<ListCollectionWidget> createState() => _ListCollectionWidgetState();
}

class _ListCollectionWidgetState extends State<ListCollectionWidget> {
  final List<Map<String, dynamic>> collections = [
    {"title": "Café", "image": "assets/FisicaBanner.png", "folders": 3},
    {"title": "listCollection.dart", "image": "assets/teste.png", "folders": 9},
    {"title": "Biologia", "image": "assets/teste.png", "folders": 2},
   
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                //coleção vazia
               //builder: (context) => EmptyCollectionPage(subjectName: collection["title"]),
               builder: (context) => SubjectPage(subjectName: collection["title"],),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF05274D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${collection["folders"]} pastas',
                              style: const TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            collection["title"],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmptyCollectionPage(subjectName: collection["title"]),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward, color: Colors.black),
                      style: IconButton.styleFrom(backgroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
