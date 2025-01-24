import 'package:flutter/material.dart';

class FoldersWidget extends StatefulWidget {
  const FoldersWidget({super.key});

  @override
  State<FoldersWidget> createState() => _FoldersWidgetState();
}

class _FoldersWidgetState extends State<FoldersWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      //Card Style
      child: Container(
        width: 320,
        height: 140, 
        decoration: BoxDecoration(
          color: const Color(0xFF05274D),
          borderRadius: BorderRadius.circular(16), 
        ),

        child: Stack(
          children: [
     
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                                
                                //Banner
                                    Column(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/FisicaBanner.png',
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),

                  //Text and Subjects Column
                  Expanded(
                    
                    child: 
                    Padding(padding: EdgeInsets.only(left: 18),
                    child: 
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // total Subject 
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '3 assuntos',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Title "Física"
                        const Text(
                          'Física',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    )
                  ),
                  // Action Buttons 
                  Column(
                    children: [
                      // Button "Copiar"
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.copy, color: Colors.white),
                        tooltip: 'Copiar',
                      ),
                      const Spacer(),
                      // Button "Avançar"
                      IconButton.filled(
                        onPressed: () {},
                        icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                            
                            ),
                            
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: Size(6, 6),
                             
                            ),
                        tooltip: 'Avançar',
                      ),
                    ],
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
