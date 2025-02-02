import 'package:aprendoai_front/widgets/folders.dart';
import 'package:aprendoai_front/widgets/modal_bottom_sheet.dart';
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
          title: const Text(
            "Coleções",
            style: TextStyle(
              color: Color.fromRGBO(5, 39, 77, 1),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoldersWidget(),
                ],
              ),
            ),

            /// Botão "Nova Coleção" que chama o ModalBottomSheet
            Container(
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
                    isScrollControlled: true, // Para ocupar mais espaço da tela
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => const ModalBottomSheetWidget(),
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
          ],
        ),
      ),
    );
  }
}
