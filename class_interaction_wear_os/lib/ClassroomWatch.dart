import 'package:flutter/material.dart';

class Classroomwatch extends StatefulWidget {
  const Classroomwatch({Key? key}) : super(key: key);

  @override
  State<Classroomwatch> createState() => _Classroomwatch();
}

class _Classroomwatch extends State<Classroomwatch> {
  final List<Color> _colors = [
    Color(0xff7b9bcf),
    Color(0xfff5c369),
    Color(0xffa4d3fb),
    Color(0xfff7a3b5),
    Color(0xfffcb29c),
    Color(0xffcab3e7),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0), // 가로 여백 설정
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                color: _colors[index % _colors.length],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 5,
                child: ListTile(
                  title: Center(
                    child: Text(
                      "Item $index",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
