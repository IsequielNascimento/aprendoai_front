import 'package:flutter/material.dart';

class WeeklySummary extends StatefulWidget {
  const WeeklySummary({super.key});

  @override
  State<WeeklySummary> createState() => _WeeklySummaryState();
}

class _WeeklySummaryState extends State<WeeklySummary> {
  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Stack(
        children:[ Card(
      
        color: Color.fromRGBO(5, 39, 77, 1),
         child: Container(
        height: 120, 
        decoration: BoxDecoration(
          color: const Color(0xFF05274D),
          borderRadius: BorderRadius.circular(16), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          //mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Total horas row
                Row(
                  
                  children: [
                    
                    Column(
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '14', // total horas

                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const Text("Horas",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                ),
                Text(
                  "|",
                  style: TextStyle(color: Colors.white),
                ),

                // Total Questões Row
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 16)),
                    Column(
                      children: [
                        Icon(
                          Icons.add_task,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '174', // total questões

                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const Text("Questões",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      ),
      ])
    );
  }
}
