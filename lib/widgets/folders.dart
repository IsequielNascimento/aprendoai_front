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
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: Color(0xFF05274D),
              child: Row(
                children: <Widget>[
                  Container(),
                  Column(
                    children: [
                      Container(
                        child: Image.asset(
                          'assets/FisicaBanner.png',
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text("AAAAAAAAAAAAA",
                        style: TextStyle(
                          color: Colors.white
                        ),),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
