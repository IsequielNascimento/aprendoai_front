import 'package:aprendoai_front/widgets/folders.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_navigation.dart';

class FoldersPage extends StatelessWidget {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Folders Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Folders Page"),
        ),
        body: const Center(
          child: FoldersWidget(),

        ),
      ),
    );
  }
}
