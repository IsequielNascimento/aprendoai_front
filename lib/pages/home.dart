import 'package:aprendoai_front/widgets/weekly_summary.dart';
import 'package:flutter/material.dart';
import 'package:aprendoai_front/widgets/bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
        title: Text(
         
         ""
        ),
        ),
        body:
         SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,            
            children: [
              //
              Row(
                children: [
                  Text("Resumo Semanal",
                  style: const TextStyle(
                    color:  Color.fromRGBO(5, 39, 77, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  )
                ],
                
              ),
              WeeklySummary(),
              Row(
                children: [
                  Text("Linha 2")
                ],
              )
              
            ],
          ),
          
          
        ),
      ),
       
    );
  }
}
