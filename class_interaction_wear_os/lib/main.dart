import 'package:class_interaction_wear_os/ClassroomWatch.dart';
import 'package:class_interaction_wear_os/Enter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Classroomwatch(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black, // AppBar 배경색을 흰색으로 설정
          ),
          
        )
    );
  }
}
