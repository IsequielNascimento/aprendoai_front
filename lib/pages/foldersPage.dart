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
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoldersWidget(),
                ],
              ),
            ),
           
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                
                color: const Color(0xFF05274D),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: TextButton(
              
                style: ButtonStyle(),
                onPressed: () {
                  ModalBottomSheetWidget();
                },
                child: Text("Nova Coleção",
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                ),),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
