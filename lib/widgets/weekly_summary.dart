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
        child: Stack(children: [
      Card(
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
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '14', // total horas

                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text("horas",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.add_task,
                            color: Colors.white,
                            size: 40,
                          )
                        ],
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '174', // total questões

                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text("questões",
                              style: TextStyle(
                                fontSize: 16,
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
    ]));
  }
}
