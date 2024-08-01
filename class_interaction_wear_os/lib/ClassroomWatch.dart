import 'dart:io';

import 'package:class_interaction_wear_os/Opinion/Opinion.dart';
import 'package:class_interaction_wear_os/Opinion/OpinionService.dart';
import 'package:class_interaction_wear_os/Opinion/OpinionVote.dart';
import 'package:class_interaction_wear_os/Websocket/Websocket.dart';
import 'package:class_interaction_wear_os/classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class Classroomwatch extends StatefulWidget {
  String classId;
  Classroomwatch(this.classId, {super.key});

  @override
  State<Classroomwatch> createState() => _Classroomwatch();
}

class _Classroomwatch extends State<Classroomwatch> {
  Websocket? websocket;
  String? jwt;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _initializeWebsocket();
  }

  Future<void> _initializeWebsocket() async {
    String classId = widget.classId;
    jwt = await storage.read(key: "Authorization") ?? "";
    websocket = await Websocket(classId, jwt, context);
  }

  @override
  void dispose() async {
    await websocket?.unsubscribe();
    websocket?.stomClient(jwt, context).deactivate(); // websocket 연결 해제
    Provider.of<OpinionService>(context, listen: false).deleteAll();
    super.dispose();
  }

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
          child: Consumer<OpinionService>(
              builder: (context, opinionService, child) {
            List<Opinion> opinionList = opinionService.opinionList; // 옵션 배열
            List<OpinionVote> opinionCount = opinionService.countList;

            return opinionList.isNotEmpty
                ? ListView.builder(
                    itemCount: opinionList.length,
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
                              "${opinionList[index].opinion}   : ${opinionCount[index].count}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                    "의견이없습니다",
                    style: TextStyle(color: Colors.white),
                  ));
          }),
        ),
      ),
    );
  }
}
