import 'dart:io';

import 'package:class_interaction_wear_os/Websocket/Websocket.dart';
import 'package:class_interaction_wear_os/classroom.dart';
import 'package:flutter/material.dart';

class Classroomwatch extends StatefulWidget {
  String classroom;
  WebSocket? websocket;
  Classroomwatch(this.classroom, {super.key});

  @override
  State<Classroomwatch> createState() => _Classroomwatch();
}

class _Classroomwatch extends State<Classroomwatch> {
  WebSocket? websocket;

  @override
  void initState() {
    super.initState();
  }

  void webSocketConnected(Classroom classroom) {
     websocket = await Websocket(widget.classroom.classId, user, jwt, context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ListTile(
                title: Center(
                  child: Text(
                    "Item fsdafdsafdasfasdfsdfsd$index",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
