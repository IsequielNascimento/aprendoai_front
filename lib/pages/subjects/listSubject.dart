import 'package:aprendoai_front/pages/subjects/EmptySubjectPage.dart';
import 'package:aprendoai_front/pages/subjects/SubjectPage.dart';
import 'package:flutter/material.dart';

class ListSubjectWidget extends StatefulWidget {
  const ListSubjectWidget({super.key});

  @override
  State<ListSubjectWidget> createState() => _ListSubjectWidgetState();
}

class _ListSubjectWidgetState extends State<ListSubjectWidget> {
  final List<Map<String, dynamic>> subjects = [
    {
      "title": "Física",
      "image": "assets/FisicaBanner.png",
      "folders": 3,
      "hasContent": true,
      "content": [
        {"title": "Eletricidade", "image": "assets/teste.png"},
        {"title": "Dinâmica", "image": "assets/teste.png"},
      ],
    },
    {
      "title": "Café",
      "image": "assets/teste.png",
      "folders": 9,
      "hasContent": false,
      "content": [],
    },
    {
      "title": "Biologia",
      "image": "assets/teste.png",
      "folders": 2,
      "hasContent": false,
      "content": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];

        return GestureDetector(
          onTap: () {
            if (subject["hasContent"]) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectPage(
                    subjectName: subject["title"],
                    subjects: subject["content"],
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmptySubjectPage(subjectName: subject["title"]),
                ),
              );
            }
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
                        subject["image"],
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
                              '${subject["folders"]} pastas',
                              style: const TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subject["title"],
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
                        if (subject["hasContent"]) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectPage(
                                subjectName: subject["title"],
                                subjects: subject["content"],
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmptySubjectPage(subjectName: subject["title"]),
                            ),
                          );
                        }
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
